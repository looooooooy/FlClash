package heysocks

import (
	"context"
	"crypto/tls"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync"
	"sync/atomic"
	"testing"
	"time"
)

func testClient(t *testing.T, handler http.HandlerFunc) (*Client, *httptest.Server) {
	t.Helper()
	server := httptest.NewServer(handler)
	t.Cleanup(server.Close)
	c, err := NewClient(Options{DeviceID: "device-test", DeviceName: "Synthetic Android device", RequestTimeout: time.Second, CallTimeout: 3 * time.Second})
	if err != nil {
		t.Fatal(err)
	}
	c.p = protocol{platform: "android", version: "551", crypto: "synthetic-salt", public: "request-fixture-key", private: "response-fixture-key", source: `{"mvjarp":"synthetic","sracun":"test"}`}
	c.hosts = []string{server.URL}
	c.p.hosts = []string{server.URL}
	c.allowHTTP = true
	t.Cleanup(c.Logout)
	return c, server
}

func testResponse(w http.ResponseWriter, code int, data any) {
	plain, _ := json.Marshal(map[string]any{"code": code, "data": data, "message": "vendor-error-containing-sensitive-token-and-html"})
	key := []byte("response-fixture-key")
	for i := range plain {
		plain[i] ^= key[i%len(key)]
	}
	w.Header().Set("Content-Type", "text/plain")
	_, _ = io.WriteString(w, base64.StdEncoding.EncodeToString(plain))
}

func testDecodeRequest(t *testing.T, value string) []byte {
	t.Helper()
	raw, err := base64.StdEncoding.DecodeString(value)
	if err != nil {
		t.Error("invalid request encoding")
		return nil
	}
	key := []byte("request-fixture-key")
	for i := range raw {
		raw[i] ^= key[i%len(key)]
	}
	return raw
}

func testHeader(t *testing.T, r *http.Request) map[string]string {
	t.Helper()
	var header map[string]string
	if json.Unmarshal(testDecodeRequest(t, r.Header.Get("X-HEADER")), &header) != nil {
		t.Error("invalid extra headers")
	}
	return header
}

func testBody(t *testing.T, r *http.Request) map[string]json.RawMessage {
	t.Helper()
	var envelope struct {
		Data string `json:"data"`
	}
	if json.NewDecoder(r.Body).Decode(&envelope) != nil {
		t.Error("invalid request body")
	}
	var fields map[string]json.RawMessage
	if json.Unmarshal(testDecodeRequest(t, envelope.Data), &fields) != nil {
		t.Error("invalid inner body")
	}
	return fields
}

func seedSession(t *testing.T, c *Client, token string) {
	t.Helper()
	payload, _ := json.Marshal(map[string]any{"id": 17, "token": map[string]any{"token": token, "vendor_expiry": 1234, "vendor_extension": "preserve"}})
	session, err := parseSession(payload)
	if err != nil {
		t.Fatal(err)
	}
	c.mu.Lock()
	c.session = session
	c.revision++
	c.mu.Unlock()
}

func TestEnvelopeHeadersAndQuery(t *testing.T) {
	var c *Client
	c, _ = testClient(t, func(w http.ResponseWriter, r *http.Request) {
		header := testHeader(t, r)
		if r.Header.Get("X-PLATFORM") != "android" || r.Header.Get("X-VERSION") != "551" || header["X-IDENTIFIER"] != "device-test" || header["X-TOKEN"] != "" || header["X-SOURCE"] != c.p.source {
			t.Error("native request headers mismatch")
		}
		if got := string(testDecodeRequest(t, r.URL.Query().Get("data"))); got != "keys=urls%2Chello%20world" {
			t.Error("query is not qs-compatible")
		}
		testResponse(w, 0, map[string]any{"urls": map[string]string{}})
	})
	data, err := c.PublicConfig(context.Background(), "urls,hello world")
	if err != nil || !json.Valid(data) {
		t.Fatal("public config failed")
	}
}

func TestHostFailureCancellationLimitsAndRedaction(t *testing.T) {
	t.Run("failover", func(t *testing.T) {
		c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) { testResponse(w, 0, true) })
		bad := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { w.WriteHeader(503) }))
		defer bad.Close()
		c.hosts = append([]string{bad.URL}, c.hosts...)
		if _, err := c.PublicConfig(context.Background(), "urls"); err != nil {
			t.Fatal(err)
		}
	})
	t.Run("canceled", func(t *testing.T) {
		entered := make(chan struct{})
		c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) { close(entered); <-r.Context().Done() })
		ctx, cancel := context.WithCancel(context.Background())
		done := make(chan error, 1)
		go func() { _, err := c.PublicConfig(ctx, "urls"); done <- err }()
		<-entered
		cancel()
		if err := <-done; !kindOf(err, ErrCanceled) {
			t.Fatal("cancellation was not propagated")
		}
	})
	t.Run("bounded", func(t *testing.T) {
		c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) { _, _ = io.WriteString(w, strings.Repeat("x", 1025)) })
		c.options.MaxResponseBytes = 1024
		if _, err := c.PublicConfig(context.Background(), "urls"); !kindOf(err, ErrLimit) {
			t.Fatal("response size was not bounded")
		}
	})
	t.Run("vendor", func(t *testing.T) {
		c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
			testResponse(w, 4029, map[string]string{"token": "hidden-secret"})
		})
		_, err := c.PublicConfig(context.Background(), "urls")
		if !kindOf(err, ErrUnavailable) {
			t.Fatal("account restriction was lost")
		}
		encoded, _ := json.Marshal(err)
		if strings.Contains(fmt.Sprintf("%v %#v %s", err, err, encoded), "secret") || strings.Contains(fmt.Sprint(err), "vendor-error") {
			t.Fatal("error leaked raw server contents")
		}
	})
}

func TestRedirectCannotForwardEnvelope(t *testing.T) {
	var received atomic.Int32
	target := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { received.Add(1) }))
	defer target.Close()
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, target.URL, http.StatusTemporaryRedirect)
	})
	_, err := c.PublicConfig(context.Background(), "urls")
	if err == nil || received.Load() != 0 {
		t.Fatal("redirect received a device envelope")
	}
}

func TestOfficialHostPathPrefixesAndDiscovery(t *testing.T) {
	var source string
	c, server := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case "/published-list":
			key := strings.Repeat("s", 64)
			plain, _ := json.Marshal([]string{source + "/native-prefix"})
			_, _ = io.WriteString(w, base64.StdEncoding.EncodeToString(append([]byte(key), xorBytes(plain, key)...)))
		case "/native-prefix/ping":
			_, _ = io.WriteString(w, "pong")
		case "/native-prefix/v1/system/config":
			testResponse(w, 0, true)
		default:
			t.Error("official host path prefix was discarded")
			w.WriteHeader(404)
		}
	})
	source = server.URL
	c.hosts = []string{server.URL + "/native-prefix"}
	c.p.hosts = append([]string(nil), c.hosts...)
	c.p.discovery = []string{server.URL + "/published-list"}
	result, err := c.Discover(context.Background())
	if err != nil || !result.Reachable || result.CandidateCount != 1 {
		t.Fatal("published encrypted host discovery failed")
	}
	if _, err := c.PublicConfig(context.Background(), "urls"); err != nil {
		t.Fatal("prefixed API call failed")
	}
}

func TestPasswordCaptchaAndSessionSnapshot(t *testing.T) {
	var loginCount atomic.Int32
	var validated atomic.Bool
	var c *Client
	var server *httptest.Server
	c, server = testClient(t, func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/ping" {
			_, _ = io.WriteString(w, "pong")
			return
		}
		switch r.URL.Path {
		case "/v2/member/login":
			header := testHeader(t, r)
			fields := testBody(t, r)
			if string(fields["method"]) != `"email-password"` || string(fields["captcha"]) != `{"scene":"email.register"}` || header["x-sign"] == "" {
				t.Error("login protocol mismatch")
			}
			loginCount.Add(1)
			if !validated.Load() {
				testResponse(w, 4034, map[string]string{"url": server.URL + "/captcha?secret=challenge"})
				return
			}
			testResponse(w, 0, map[string]any{"id": 1, "token": map[string]any{"token": "synthetic-token", "vendor_expiry": 987, "unrecognized": "kept"}})
		case "/v1/captcha/capjs":
			if string(testBody(t, r)["captchaToken"]) != `"synthetic-captcha"` {
				t.Error("captcha token mismatch")
			}
			validated.Store(true)
			testResponse(w, 0, true)
		default:
			t.Error("unexpected path")
		}
	})
	result, err := c.LoginPassword(context.Background(), PasswordCredentials{Email: "test@example.invalid", Password: "synthetic-password"})
	if err != nil || result.Challenge == nil || c.State().Authenticated {
		t.Fatal("login captcha state missing")
	}
	if strings.Contains(fmt.Sprintf("%v %#v", result.Challenge, result.Challenge), "challenge?secret") {
		t.Fatal("captcha was logged")
	}
	result, err = c.ContinueCaptcha(context.Background(), result.Challenge.ID, "synthetic-captcha")
	if err != nil || !result.State.Authenticated || loginCount.Load() != 2 {
		t.Fatal("captcha did not resume login")
	}
	snapshot, err := c.Snapshot()
	if err != nil || !strings.Contains(string(snapshot.Session.Payload), `"unrecognized":"kept"`) {
		t.Fatal("original token metadata was lost")
	}
	snapshot.Session.Payload[0] = 'x'
	fresh, _ := c.Snapshot()
	if !json.Valid(fresh.Session.Payload) {
		t.Fatal("snapshot aliases internal state")
	}
	if strings.Contains(fmt.Sprintf("%v %#v", fresh, fresh), "synthetic-token") {
		t.Fatal("session formatter leaks token")
	}
	c.Logout()
	if c.State().Authenticated || c.State().Revision <= fresh.Revision {
		t.Fatal("logout did not invalidate snapshot revision")
	}
}

func TestConcurrentRefreshAndOneAuthRetry(t *testing.T) {
	var refreshes atomic.Int32
	var catalogs atomic.Int32
	entered := make(chan struct{})
	release := make(chan struct{})
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		header := testHeader(t, r)
		switch r.URL.Path {
		case "/v1/member/token/refresh":
			refreshes.Add(1)
			close(entered)
			<-release
			testResponse(w, 0, map[string]any{"token": "new-synthetic-token", "vendor_expiry": 5678, "other": "retained"})
		case "/v3/proxy/nodes":
			catalogs.Add(1)
			if header["X-TOKEN"] == "old-synthetic-token" {
				w.WriteHeader(401)
				return
			}
			testResponse(w, 0, []any{})
		}
	})
	seedSession(t, c, "old-synthetic-token")
	revision := c.State().Revision
	const count = 16
	var wg sync.WaitGroup
	errs := make(chan error, count)
	for range count {
		wg.Add(1)
		go func() { defer wg.Done(); _, err := c.FetchCatalog(context.Background(), ""); errs <- err }()
	}
	<-entered
	close(release)
	wg.Wait()
	close(errs)
	for err := range errs {
		if err != nil {
			t.Fatal(err)
		}
	}
	if refreshes.Load() != 1 || catalogs.Load() < count || c.State().Revision <= revision {
		t.Fatal("refresh was not coalesced or revision was not advanced")
	}
	snapshot, _ := c.Snapshot()
	if snapshot.Session.token != "new-synthetic-token" || !strings.Contains(string(snapshot.Session.RefreshPayload), `"other":"retained"`) {
		t.Fatal("refresh metadata was lost")
	}
	var attempts atomic.Int32
	var renewals atomic.Int32
	d, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/v1/member/token/refresh" {
			renewals.Add(1)
			testResponse(w, 0, map[string]any{"token": map[string]any{"token": "rotated"}})
			return
		}
		attempts.Add(1)
		w.WriteHeader(401)
	})
	seedSession(t, d, "expired")
	_, err := d.FetchCatalog(context.Background(), "")
	if !kindOf(err, ErrUnauthorized) || attempts.Load() != 2 || renewals.Load() != 1 {
		t.Fatal("authentication retry is not bounded")
	}
}

type refreshWaitContext struct {
	context.Context
	waiting chan struct{}
	once    sync.Once
}

func (c *refreshWaitContext) Done() <-chan struct{} {
	c.once.Do(func() { close(c.waiting) })
	return c.Context.Done()
}

func TestRefreshOwnerCancellationDoesNotCancelWaiter(t *testing.T) {
	var refreshes atomic.Int32
	entered := make(chan struct{})
	release := make(chan struct{})
	releaseServer := sync.OnceFunc(func() { close(release) })
	defer releaseServer()
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		refreshes.Add(1)
		if r.URL.Path != "/v1/member/token/refresh" {
			t.Error("unexpected refresh path")
		}
		if refreshes.Load() == 1 {
			close(entered)
		}
		select {
		case <-r.Context().Done():
			return
		case <-release:
			testResponse(w, 0, map[string]string{"token": "renewed-synthetic-token"})
		}
	})
	seedSession(t, c, "old-synthetic-token")
	ownerCtx, cancelOwner := context.WithCancel(context.Background())
	defer cancelOwner()
	ownerDone := make(chan error, 1)
	go func() { _, err := c.RefreshSession(ownerCtx); ownerDone <- err }()
	select {
	case <-entered:
	case <-time.After(2 * time.Second):
		t.Fatal("refresh request did not start")
	}
	waiterCtx := &refreshWaitContext{Context: context.Background(), waiting: make(chan struct{})}
	waiterDone := make(chan error, 1)
	go func() { _, err := c.RefreshSession(waiterCtx); waiterDone <- err }()
	select {
	case <-waiterCtx.waiting:
	case <-time.After(2 * time.Second):
		t.Fatal("waiter did not join shared refresh")
	}
	cancelOwner()
	select {
	case err := <-ownerDone:
		if !kindOf(err, ErrCanceled) {
			t.Fatal("canceled owner did not return cancellation")
		}
	case <-time.After(2 * time.Second):
		t.Fatal("canceled owner remained blocked")
	}
	releaseServer()
	select {
	case err := <-waiterDone:
		if err != nil {
			t.Fatal("owner cancellation aborted another caller's refresh")
		}
	case <-time.After(2 * time.Second):
		t.Fatal("active waiter did not complete")
	}
	snapshot, err := c.Snapshot()
	if err != nil || snapshot.Session.token != "renewed-synthetic-token" || refreshes.Load() != 1 {
		t.Fatal("shared refresh did not install exactly one successful renewal")
	}
}

func TestLogoutWinsInFlightLoginRestoreAndRefresh(t *testing.T) {
	for _, operation := range []string{"login", "restore", "refresh"} {
		t.Run(operation, func(t *testing.T) {
			entered := make(chan struct{})
			release := make(chan struct{})
			c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
				if r.URL.Path == "/ping" {
					_, _ = io.WriteString(w, "pong")
					return
				}
				close(entered)
				<-release
				testResponse(w, 0, map[string]any{"id": 2, "token": map[string]any{"token": "late-token"}})
			})
			seedSession(t, c, "old-token")
			snapshot, _ := c.Snapshot()
			done := make(chan error, 1)
			go func() {
				var err error
				switch operation {
				case "login":
					_, err = c.LoginPassword(context.Background(), PasswordCredentials{"test@example.invalid", "synthetic-password"})
				case "restore":
					_, err = c.RestoreSession(context.Background(), snapshot)
				case "refresh":
					_, err = c.RefreshSession(context.Background())
				}
				done <- err
			}()
			<-entered
			c.Logout()
			close(release)
			if err := <-done; err == nil || c.State().Authenticated {
				t.Fatal("stale response restored a logged-out account")
			}
		})
	}
}

func TestRestorePreservesOriginalFieldsAndRejectsUnknownRefresh(t *testing.T) {
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/v1/member/info" {
			testResponse(w, 0, map[string]any{"name": "updated", "limits": map[string]int{"devices": 2}})
			return
		}
		testResponse(w, 0, map[string]any{"expires_in": 42, "access_token": "not-the-protocol"})
	})
	seedSession(t, c, "synthetic-token")
	snapshot, _ := c.Snapshot()
	c.Logout()
	result, err := c.RestoreSession(context.Background(), snapshot)
	if err != nil || !result.State.Authenticated {
		t.Fatal("restore failed")
	}
	restored, _ := c.Snapshot()
	if !strings.Contains(string(restored.Session.Payload), `"vendor_extension":"preserve"`) || !strings.Contains(string(restored.Session.Payload), `"limits"`) {
		t.Fatal("vendor fields were not preserved")
	}
	_, err = c.RefreshSession(context.Background())
	if !kindOf(err, ErrProtocol) {
		t.Fatal("invented OAuth fields were accepted")
	}
}

func TestRestoreCanRenewWithoutInstallingUnverifiedSession(t *testing.T) {
	var refreshes atomic.Int32
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/v1/member/token/refresh" {
			refreshes.Add(1)
			testResponse(w, 0, map[string]any{"token": "renewed-token", "vendor_expiry": 456})
			return
		}
		if testHeader(t, r)["X-TOKEN"] != "renewed-token" {
			w.WriteHeader(401)
			return
		}
		testResponse(w, 0, map[string]any{"id": 5})
	})
	seedSession(t, c, "old-token")
	snapshot, _ := c.Snapshot()
	c.Logout()
	result, err := c.RestoreSession(context.Background(), snapshot)
	if err != nil || !result.State.Authenticated || refreshes.Load() != 1 {
		t.Fatal("expired persisted session could not renew")
	}
}

func TestTLSPolicyAndStructuredCaptchaRedaction(t *testing.T) {
	_, err := NewClient(Options{DeviceID: "synthetic-device", DeviceName: "Synthetic", HTTPClient: &http.Client{Transport: &http.Transport{TLSClientConfig: &tls.Config{InsecureSkipVerify: true}}}})
	if !kindOf(err, ErrInput) {
		t.Fatal("TLS verification can be disabled")
	}
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		testResponse(w, 4034, map[string]string{"url": "https://captcha.invalid/?token=sensitive-challenge"})
	})
	_, err = c.PublicConfig(context.Background(), "urls")
	encoded, _ := json.Marshal(err)
	if !kindOf(err, ErrCaptcha) || strings.Contains(string(encoded), "sensitive-challenge") {
		t.Fatal("structured errors leak challenge URLs")
	}
}

func TestNewAccountSupersedesOldLogin(t *testing.T) {
	entered := make(chan struct{})
	release := make(chan struct{})
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/ping" {
			_, _ = io.WriteString(w, "pong")
			return
		}
		fields := testBody(t, r)
		if string(fields["email"]) == `"first@example.invalid"` {
			close(entered)
			<-release
			testResponse(w, 0, map[string]any{"token": map[string]string{"token": "first-token"}})
			return
		}
		testResponse(w, 0, map[string]any{"token": map[string]string{"token": "second-token"}})
	})
	done := make(chan error, 1)
	go func() {
		_, err := c.LoginPassword(context.Background(), PasswordCredentials{"first@example.invalid", "synthetic-password"})
		done <- err
	}()
	<-entered
	result, err := c.LoginPassword(context.Background(), PasswordCredentials{"second@example.invalid", "synthetic-password"})
	close(release)
	if err != nil || !result.State.Authenticated {
		t.Fatal("new account login failed")
	}
	if <-done == nil {
		t.Fatal("old account login was not superseded")
	}
	snapshot, _ := c.Snapshot()
	if snapshot.Session.token != "second-token" {
		t.Fatal("old login overwrote newer account")
	}
}
