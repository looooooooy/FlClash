package heysocks

import (
	"bytes"
	"context"
	"crypto/rand"
	"encoding/hex"
	"encoding/json"
	"errors"
	"net/http"
	"net/url"
	"strings"
	"sync"
	"time"

	"github.com/coder/websocket"
)

type PasswordCredentials struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (PasswordCredentials) String() string     { return "heysocks.PasswordCredentials{redacted}" }
func (p PasswordCredentials) GoString() string { return p.String() }

type Session struct {
	Payload        json.RawMessage `json:"payload"`
	RefreshPayload json.RawMessage `json:"refreshPayload,omitempty"`
	token          string
}

func (Session) String() string     { return "heysocks.Session{redacted}" }
func (s Session) GoString() string { return s.String() }

type SessionSnapshot struct {
	Revision   uint64  `json:"revision"`
	Generation uint64  `json:"generation"`
	Session    Session `json:"session"`
}

func (SessionSnapshot) String() string     { return "heysocks.SessionSnapshot{redacted}" }
func (s SessionSnapshot) GoString() string { return s.String() }

type SessionState struct {
	Revision      uint64 `json:"revision"`
	Generation    uint64 `json:"generation"`
	Authenticated bool   `json:"authenticated"`
}
type CaptchaChallenge struct {
	ID        string `json:"id"`
	URL       string `json:"url"`
	Operation string `json:"operation"`
}

func (CaptchaChallenge) String() string     { return "heysocks.CaptchaChallenge{redacted}" }
func (s CaptchaChallenge) GoString() string { return s.String() }

type AuthResult struct {
	State     SessionState      `json:"state"`
	Challenge *CaptchaChallenge `json:"challenge,omitempty"`
}
type pendingCaptcha struct {
	challenge  CaptchaChallenge
	spec       requestSpec
	generation uint64
	expires    time.Time
	timer      *time.Timer
}
type refreshCall struct {
	generation uint64
	done       chan struct{}
	err        error
}

func cloneSession(s *Session) Session {
	return Session{Payload: bytes.Clone(s.Payload), RefreshPayload: bytes.Clone(s.RefreshPayload), token: s.token}
}

func parseSession(payload json.RawMessage) (*Session, error) {
	if len(payload) > 1<<20 {
		return nil, failure("session", ErrLimit)
	}
	var value struct {
		Token struct {
			Token string `json:"token"`
		} `json:"token"`
	}
	if json.Unmarshal(payload, &value) != nil || value.Token.Token == "" || len(value.Token.Token) > 16<<10 {
		return nil, failure("session", ErrProtocol)
	}
	return &Session{Payload: bytes.Clone(payload), token: value.Token.Token}, nil
}

func (c *Client) State() SessionState {
	c.mu.Lock()
	defer c.mu.Unlock()
	return SessionState{Revision: c.revision, Generation: c.generation, Authenticated: c.session != nil}
}

func (c *Client) WaitState(ctx context.Context, revision uint64) (SessionState, error) {
	for {
		c.mu.Lock()
		state := SessionState{Revision: c.revision, Generation: c.generation, Authenticated: c.session != nil}
		changed := c.changed
		c.mu.Unlock()
		if state.Revision != revision {
			return state, nil
		}
		select {
		case <-ctx.Done():
			return state, failure("state", ErrCanceled)
		case <-changed:
		}
	}
}

func (c *Client) changedLocked() {
	if c.changed != nil {
		close(c.changed)
	}
	c.changed = make(chan struct{})
}

func (c *Client) Snapshot() (SessionSnapshot, error) {
	c.mu.Lock()
	defer c.mu.Unlock()
	if c.session == nil {
		return SessionSnapshot{}, failure("snapshot", ErrUnauthorized)
	}
	return SessionSnapshot{Revision: c.revision, Generation: c.generation, Session: cloneSession(c.session)}, nil
}

func (c *Client) resetLocked() uint64 {
	c.accountCancel()
	c.accountCtx, c.accountCancel = context.WithCancel(context.Background())
	c.generation++
	c.revision++
	c.changedLocked()
	c.session = nil
	if c.pending != nil {
		c.pending.timer.Stop()
		clear(c.pending.spec.body)
		c.pending = nil
	}
	if c.device != nil {
		c.device.cancel()
		c.device = nil
	}
	c.refresh = nil
	return c.generation
}

func (c *Client) Suspend(ctx context.Context) (SessionState, error) {
	c.mu.Lock()
	defer c.mu.Unlock()
	if ctx.Err() != nil {
		return SessionState{}, failure("account", ErrCanceled)
	}
	session := c.session
	c.resetLocked()
	c.session = session
	return SessionState{Revision: c.revision, Generation: c.generation, Authenticated: c.session != nil}, nil
}

func (c *Client) Logout() { c.mu.Lock(); defer c.mu.Unlock(); c.resetLocked() }
func (c *Client) begin(ctx context.Context) (uint64, error) {
	c.mu.Lock()
	defer c.mu.Unlock()
	if ctx.Err() != nil {
		return 0, failure("account", ErrCanceled)
	}
	return c.resetLocked(), nil
}

func (c *Client) accountRequestContext(ctx context.Context, generation uint64) (context.Context, context.CancelFunc, error) {
	c.mu.Lock()
	if c.generation != generation {
		c.mu.Unlock()
		return nil, nil, failure("account", ErrSuperseded)
	}
	account := c.accountCtx
	c.mu.Unlock()
	child, cancel := context.WithCancel(ctx)
	stop := context.AfterFunc(account, cancel)
	return child, func() { stop(); cancel() }, nil
}

func (c *Client) install(ctx context.Context, generation uint64, session *Session) (AuthResult, error) {
	c.mu.Lock()
	defer c.mu.Unlock()
	if c.generation != generation {
		return AuthResult{}, failure("account", ErrSuperseded)
	}
	if ctx.Err() != nil {
		return AuthResult{}, failure("account", ErrCanceled)
	}
	c.session = session
	c.revision++
	c.changedLocked()
	if c.pending != nil {
		c.pending.timer.Stop()
		clear(c.pending.spec.body)
		c.pending = nil
	}
	return AuthResult{State: SessionState{Revision: c.revision, Generation: c.generation, Authenticated: true}}, nil
}

func (c *Client) LoginPassword(ctx context.Context, credentials PasswordCredentials) (AuthResult, error) {
	if len(credentials.Email) > 512 || !strings.Contains(credentials.Email, "@") || credentials.Password == "" || len(credentials.Password) > 4096 {
		return AuthResult{}, failure("login", ErrInput)
	}
	body, _ := json.Marshal(struct {
		Captcha  map[string]string `json:"captcha"`
		Email    string            `json:"email"`
		Method   string            `json:"method"`
		Password string            `json:"password"`
	}{map[string]string{"scene": "email.register"}, credentials.Email, "email-password", credentials.Password})
	defer clear(body)
	generation, err := c.begin(ctx)
	if err != nil {
		return AuthResult{}, err
	}
	return c.loginAttempt(ctx, generation, requestSpec{op: "login", method: http.MethodPost, path: "/v2/member/login", body: body, login: true})
}

func (c *Client) loginAttempt(ctx context.Context, generation uint64, spec requestSpec) (AuthResult, error) {
	ctx, cancel, err := c.accountRequestContext(ctx, generation)
	if err != nil {
		return AuthResult{}, err
	}
	defer cancel()
	payload, err := c.raw(ctx, spec, "")
	if err != nil {
		var apiErr *Error
		if errors.As(err, &apiErr) && apiErr.Kind == ErrCaptcha && apiErr.Challenge != nil {
			var id [16]byte
			if _, err := rand.Read(id[:]); err != nil {
				return AuthResult{}, failure("captcha", ErrProtocol)
			}
			challenge := *apiErr.Challenge
			challenge.ID = hex.EncodeToString(id[:])
			c.mu.Lock()
			defer c.mu.Unlock()
			if generation != c.generation {
				return AuthResult{}, failure("login", ErrSuperseded)
			}
			if ctx.Err() != nil {
				return AuthResult{}, failure("login", ErrCanceled)
			}
			if c.pending != nil {
				c.pending.timer.Stop()
				clear(c.pending.spec.body)
			}
			spec.body = bytes.Clone(spec.body)
			pending := &pendingCaptcha{challenge: challenge, spec: spec, generation: generation, expires: time.Now().Add(5 * time.Minute)}
			pending.timer = time.AfterFunc(5*time.Minute, func() {
				c.mu.Lock()
				defer c.mu.Unlock()
				if c.pending == pending {
					clear(pending.spec.body)
					c.pending = nil
				}
			})
			c.pending = pending
			return AuthResult{State: SessionState{Revision: c.revision, Generation: c.generation}, Challenge: &challenge}, nil
		}
		return AuthResult{}, err
	}
	session, err := parseSession(payload)
	if err != nil {
		return AuthResult{}, err
	}
	return c.install(ctx, generation, session)
}

func (c *Client) ContinueCaptcha(ctx context.Context, id, captchaToken string) (AuthResult, error) {
	if captchaToken == "" || len(captchaToken) > 16<<10 {
		return AuthResult{}, failure("captcha", ErrInput)
	}
	c.mu.Lock()
	if c.pending == nil || c.pending.challenge.ID != id || time.Now().After(c.pending.expires) {
		c.mu.Unlock()
		return AuthResult{}, failure("captcha", ErrSuperseded)
	}
	pending := *c.pending
	pending.spec.body = bytes.Clone(pending.spec.body)
	c.pending.timer.Stop()
	clear(c.pending.spec.body)
	c.pending = nil
	c.mu.Unlock()
	defer clear(pending.spec.body)
	ctx, cancel, err := c.accountRequestContext(ctx, pending.generation)
	if err != nil {
		return AuthResult{}, err
	}
	defer cancel()
	if err := c.validateCaptcha(ctx, captchaToken, ""); err != nil {
		return AuthResult{}, err
	}
	return c.loginAttempt(ctx, pending.generation, pending.spec)
}

func (c *Client) validateCaptcha(ctx context.Context, token, authToken string) error {
	body, _ := json.Marshal(map[string]string{"captchaToken": token})
	defer clear(body)
	data, err := c.raw(ctx, requestSpec{op: "captcha", method: http.MethodPost, path: "/v1/captcha/capjs", body: body}, authToken)
	if err != nil {
		return err
	}
	value := string(bytes.TrimSpace(data))
	if value == "" || value == "null" || value == "false" || value == "0" || value == `""` {
		return failure("captcha", ErrVendor)
	}
	return nil
}

func (c *Client) ValidateCaptcha(ctx context.Context, captchaToken string) error {
	if captchaToken == "" || len(captchaToken) > 16<<10 {
		return failure("captcha", ErrInput)
	}
	c.mu.Lock()
	generation := c.generation
	token := ""
	if c.session != nil {
		token = c.session.token
	}
	c.mu.Unlock()
	ctx, cancel, err := c.accountRequestContext(ctx, generation)
	if err != nil {
		return err
	}
	defer cancel()
	return c.validateCaptcha(ctx, captchaToken, token)
}

func (c *Client) RestoreSession(ctx context.Context, snapshot SessionSnapshot) (AuthResult, error) {
	session, err := parseSession(snapshot.Session.Payload)
	if err != nil {
		return AuthResult{}, err
	}
	if len(snapshot.Session.RefreshPayload) > 1<<20 {
		return AuthResult{}, failure("restore", ErrLimit)
	}
	session.RefreshPayload = bytes.Clone(snapshot.Session.RefreshPayload)
	generation, err := c.begin(ctx)
	if err != nil {
		return AuthResult{}, err
	}
	ctx, cancel, err := c.accountRequestContext(ctx, generation)
	if err != nil {
		return AuthResult{}, err
	}
	defer cancel()
	member, err := c.raw(ctx, requestSpec{op: "restore", method: http.MethodGet, path: "/v1/member/info", retryable: true}, session.token)
	if kindOf(err, ErrUnauthorized) {
		var refreshed json.RawMessage
		refreshed, err = c.raw(ctx, requestSpec{op: "refresh", method: http.MethodGet, path: "/v1/member/token/refresh", retryable: true}, session.token)
		if err == nil {
			session, err = mergeRefresh(*session, refreshed)
		}
		if err == nil {
			member, err = c.raw(ctx, requestSpec{op: "restore", method: http.MethodGet, path: "/v1/member/info", retryable: true}, session.token)
		}
	}
	if err != nil {
		return AuthResult{}, err
	}
	session, err = withMember(session, member)
	if err != nil {
		return AuthResult{}, err
	}
	return c.install(ctx, generation, session)
}

func withMember(session *Session, member json.RawMessage) (*Session, error) {
	var previous, fields map[string]json.RawMessage
	if json.Unmarshal(session.Payload, &previous) != nil || json.Unmarshal(member, &fields) != nil || fields == nil {
		return nil, failure("member", ErrProtocol)
	}
	for key, value := range fields {
		if key != "token" {
			previous[key] = value
		}
	}
	payload, _ := json.Marshal(previous)
	updated, err := parseSession(payload)
	if err != nil {
		return nil, err
	}
	updated.RefreshPayload = bytes.Clone(session.RefreshPayload)
	return updated, nil
}

func (c *Client) authenticated(ctx context.Context, spec requestSpec) (json.RawMessage, error) {
	c.mu.Lock()
	generation := c.generation
	token := ""
	if c.session != nil {
		token = c.session.token
	}
	c.mu.Unlock()
	if token == "" {
		return nil, failure(spec.op, ErrUnauthorized)
	}
	ctx, cancel, err := c.accountRequestContext(ctx, generation)
	if err != nil {
		return nil, err
	}
	defer cancel()
	data, err := c.raw(ctx, spec, token)
	if kindOf(err, ErrUnauthorized) {
		if err = c.refreshSession(ctx, generation, token); err != nil {
			return nil, err
		}
		c.mu.Lock()
		if generation != c.generation || c.session == nil {
			c.mu.Unlock()
			return nil, failure(spec.op, ErrSuperseded)
		}
		token = c.session.token
		c.mu.Unlock()
		data, err = c.raw(ctx, spec, token)
	}
	c.mu.Lock()
	stale := generation != c.generation
	c.mu.Unlock()
	if stale {
		return nil, failure(spec.op, ErrSuperseded)
	}
	return data, err
}

func (c *Client) RefreshSession(ctx context.Context) (SessionState, error) {
	c.mu.Lock()
	generation := c.generation
	token := ""
	if c.session != nil {
		token = c.session.token
	}
	c.mu.Unlock()
	if token == "" {
		return c.State(), failure("refresh", ErrUnauthorized)
	}
	err := c.refreshSession(ctx, generation, token)
	return c.State(), err
}

func mergeRefresh(before Session, payload json.RawMessage) (*Session, error) {
	var fields map[string]json.RawMessage
	if json.Unmarshal(payload, &fields) != nil || fields == nil {
		return nil, failure("refresh", ErrProtocol)
	}
	tokenObject := payload
	if value := bytes.TrimSpace(fields["token"]); len(value) > 0 && value[0] == '{' {
		tokenObject = value
	}
	var original map[string]json.RawMessage
	if json.Unmarshal(before.Payload, &original) != nil || original == nil {
		return nil, failure("refresh", ErrProtocol)
	}
	original["token"] = tokenObject
	merged, _ := json.Marshal(original)
	session, err := parseSession(merged)
	if err != nil {
		return nil, err
	}
	session.RefreshPayload = bytes.Clone(payload)
	return session, nil
}

func (c *Client) refreshSession(ctx context.Context, generation uint64, previousToken string) error {
	if ctx.Err() != nil {
		return failure("refresh", ErrCanceled)
	}
	c.mu.Lock()
	if generation != c.generation || c.session == nil {
		c.mu.Unlock()
		return failure("refresh", ErrSuperseded)
	}
	if c.session.token != previousToken {
		c.mu.Unlock()
		return nil
	}
	call := c.refresh
	if call != nil && call.generation == generation {
		c.mu.Unlock()
	} else {
		call = &refreshCall{generation: generation, done: make(chan struct{})}
		c.refresh = call
		before := cloneSession(c.session)
		refreshCtx, cancel := context.WithTimeout(c.accountCtx, c.options.CallTimeout)
		c.mu.Unlock()
		safeGo("refresh", func() error {
			defer cancel()
			payload, err := c.raw(refreshCtx, requestSpec{op: "refresh", method: http.MethodGet, path: "/v1/member/token/refresh", retryable: true}, previousToken)
			if err != nil {
				return err
			}
			session, err := mergeRefresh(before, payload)
			if err != nil {
				return err
			}
			_, err = c.install(refreshCtx, generation, session)
			return err
		}, func(err error) {
			c.mu.Lock()
			defer c.mu.Unlock()
			call.err = err
			if c.refresh == call {
				c.refresh = nil
			}
			close(call.done)
		})
	}
	select {
	case <-ctx.Done():
		return failure("refresh", ErrCanceled)
	case <-call.done:
		if ctx.Err() != nil {
			return failure("refresh", ErrCanceled)
		}
		return call.err
	}
}

func safeGo(operation string, run func() error, finish func(error)) {
	go func() {
		var err error
		defer func() {
			if recover() != nil {
				err = failure(operation, ErrProtocol)
			}
			finish(err)
		}()
		err = run()
	}()
}

type DeviceAuthorization struct {
	ID             string `json:"id"`
	TimeoutSeconds int    `json:"timeoutSeconds"`
}
type DeviceEvent struct {
	Type  string       `json:"type"`
	Code  string       `json:"code,omitempty"`
	State SessionState `json:"state"`
}

func (DeviceEvent) String() string     { return "heysocks.DeviceEvent{redacted}" }
func (s DeviceEvent) GoString() string { return s.String() }

type deviceFlow struct {
	id         string
	generation uint64
	conn       *websocket.Conn
	ctx        context.Context
	cancel     context.CancelFunc
	mu         sync.Mutex
	polling    bool
}

func (c *Client) StartDeviceAuthorization(ctx context.Context) (DeviceAuthorization, error) {
	generation, err := c.begin(ctx)
	if err != nil {
		return DeviceAuthorization{}, err
	}
	accountCtx, accountCancel, err := c.accountRequestContext(ctx, generation)
	if err != nil {
		return DeviceAuthorization{}, err
	}
	flowCtx, timeoutCancel := context.WithTimeout(accountCtx, 5*time.Minute)
	cancel := func() { timeoutCancel(); accountCancel() }
	var conn *websocket.Conn
	dialBudget, stopDial := context.WithTimeout(flowCtx, c.options.CallTimeout)
	defer stopDial()
	for _, host := range c.hostList() {
		u, err := c.endpoint(host, true)
		if err != nil {
			continue
		}
		if u.Scheme == "https" {
			u.Scheme = "wss"
		} else {
			u.Scheme = "ws"
		}
		u.Path = strings.TrimRight(u.Path, "/") + "/v1/member/link-code"
		u.RawPath = ""
		u.RawQuery = url.Values{"x-identifier": {c.options.DeviceID}, "x-device-name": {c.options.DeviceName}, "x-platform": {c.p.platform}, "x-version": {c.p.version}}.Encode()
		dialCtx, dialCancel := context.WithTimeout(dialBudget, c.options.RequestTimeout)
		candidate, response, dialErr := websocket.Dial(dialCtx, u.String(), &websocket.DialOptions{HTTPClient: c.http})
		dialCancel()
		if response != nil && response.Body != nil {
			response.Body.Close()
		}
		if dialErr == nil {
			conn = candidate
			c.useHost(host)
			break
		}
		if flowCtx.Err() != nil {
			cancel()
			return DeviceAuthorization{}, failure("device_start", ErrCanceled)
		}
	}
	if conn == nil {
		cancel()
		return DeviceAuthorization{}, failure("device_start", ErrNetwork)
	}
	conn.SetReadLimit(1 << 20)
	var id [16]byte
	if _, err = rand.Read(id[:]); err != nil {
		conn.CloseNow()
		cancel()
		return DeviceAuthorization{}, failure("device_start", ErrProtocol)
	}
	flow := &deviceFlow{id: hex.EncodeToString(id[:]), generation: generation, conn: conn, ctx: flowCtx, cancel: cancel}
	context.AfterFunc(flowCtx, func() { conn.CloseNow() })
	c.mu.Lock()
	defer c.mu.Unlock()
	if c.generation != generation || flowCtx.Err() != nil {
		cancel()
		return DeviceAuthorization{}, failure("device_start", ErrSuperseded)
	}
	c.device = flow
	return DeviceAuthorization{ID: flow.id, TimeoutSeconds: 300}, nil
}

func (c *Client) CancelDeviceAuthorization(id string) {
	c.mu.Lock()
	defer c.mu.Unlock()
	if c.device != nil && c.device.id == id {
		c.resetLocked()
	}
}

func (c *Client) PollDeviceAuthorization(ctx context.Context, id string) (DeviceEvent, error) {
	c.mu.Lock()
	flow := c.device
	c.mu.Unlock()
	if flow == nil || flow.id != id {
		return DeviceEvent{}, failure("device_poll", ErrSuperseded)
	}
	flow.mu.Lock()
	if flow.polling {
		flow.mu.Unlock()
		return DeviceEvent{}, failure("device_poll", ErrBusy)
	}
	flow.polling = true
	flow.mu.Unlock()
	defer func() { flow.mu.Lock(); flow.polling = false; flow.mu.Unlock() }()
	readCtx, cancel := context.WithCancel(ctx)
	stop := context.AfterFunc(flow.ctx, cancel)
	defer func() { stop(); cancel() }()
	_, encoded, err := flow.conn.Read(readCtx)
	if err != nil {
		flow.cancel()
		if readCtx.Err() != nil {
			return DeviceEvent{}, failure("device_poll", ErrCanceled)
		}
		return DeviceEvent{}, failure("device_poll", ErrNetwork)
	}
	plain, err := c.p.decode(string(encoded), 1<<20)
	if err != nil {
		flow.cancel()
		return DeviceEvent{}, err
	}
	var event struct {
		Type string          `json:"type"`
		Data json.RawMessage `json:"data"`
	}
	if json.Unmarshal(plain, &event) != nil {
		flow.cancel()
		return DeviceEvent{}, failure("device_poll", ErrProtocol)
	}
	c.mu.Lock()
	stale := c.generation != flow.generation
	c.mu.Unlock()
	if stale || readCtx.Err() != nil {
		return DeviceEvent{}, failure("device_poll", ErrSuperseded)
	}
	switch event.Type {
	case "code":
		var code string
		if json.Unmarshal(event.Data, &code) != nil || code == "" || len(code) > 64 {
			flow.cancel()
			return DeviceEvent{}, failure("device_poll", ErrProtocol)
		}
		return DeviceEvent{Type: "code", Code: code, State: c.State()}, nil
	case "token":
		defer flow.cancel()
		var tokenData string
		if json.Unmarshal(event.Data, &tokenData) != nil {
			return DeviceEvent{}, failure("device_poll", ErrProtocol)
		}
		payload, _ := json.Marshal(map[string]json.RawMessage{"token": json.RawMessage(tokenData)})
		session, err := parseSession(payload)
		if err != nil {
			return DeviceEvent{}, err
		}
		member, err := c.raw(readCtx, requestSpec{op: "device_member", method: http.MethodGet, path: "/v1/member/info", retryable: true}, session.token)
		if err != nil {
			return DeviceEvent{}, err
		}
		session, err = withMember(session, member)
		if err != nil {
			return DeviceEvent{}, err
		}
		result, err := c.install(readCtx, flow.generation, session)
		if err != nil {
			return DeviceEvent{}, err
		}
		c.mu.Lock()
		if c.device == flow {
			c.device = nil
		}
		c.mu.Unlock()
		return DeviceEvent{Type: "authorized", State: result.State}, nil
	case "error":
		flow.cancel()
		return DeviceEvent{}, failure("device_poll", ErrVendor)
	default:
		flow.cancel()
		return DeviceEvent{}, failure("device_poll", ErrProtocol)
	}
}
