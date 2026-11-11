package core

import (
	"context"
	"core/heysocks"
	"encoding/json"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/metacubex/mihomo/constant"
)

type bridgeClient struct {
	*heysocks.Client
	startContext context.Context
	entered      chan struct{}
}

func (f *bridgeClient) StartDeviceAuthorization(ctx context.Context) (heysocks.DeviceAuthorization, error) {
	f.startContext = ctx
	return heysocks.DeviceAuthorization{ID: "synthetic-flow", TimeoutSeconds: 300}, nil
}
func (f *bridgeClient) PollDeviceAuthorization(ctx context.Context, id string) (heysocks.DeviceEvent, error) {
	if f.startContext.Err() != nil {
		return heysocks.DeviceEvent{}, f.startContext.Err()
	}
	return heysocks.DeviceEvent{Type: "code", Code: "synthetic-private-code", State: f.State()}, nil
}
func (f *bridgeClient) FetchCatalog(ctx context.Context, isp string) (heysocks.Catalog, error) {
	close(f.entered)
	<-ctx.Done()
	return heysocks.Catalog{}, ctx.Err()
}

func bridgeForTest(t *testing.T) (*accountBridge, *bridgeClient) {
	t.Helper()
	client, err := heysocks.NewClient(heysocks.Options{DeviceID: "test-install", DeviceName: "test-device"})
	if err != nil {
		t.Fatal(err)
	}
	fake := &bridgeClient{Client: client, entered: make(chan struct{})}
	b := newAccountBridge()
	b.factory = func(heysocks.Options) (accountClient, error) { return fake, nil }
	t.Cleanup(func() {
		b.mu.Lock()
		if b.cancel != nil {
			b.cancel()
		}
		b.mu.Unlock()
		client.Logout()
	})
	bridgeCall(t, b, accountInitializeMethod, accountRequest{DeviceID: "test-install", Platform: "android"})
	return b, fake
}
func bridgeCall(t *testing.T, b *accountBridge, method CoreMethod, p accountRequest) accountReply {
	t.Helper()
	data, _ := json.Marshal(p)
	result, err := b.handle(&MethodCall{Method: method, Arguments: data})
	if err != nil {
		t.Fatal(err)
	}
	return result.(accountReply)
}

func TestPrivateAccountResponsesNeverSpill(t *testing.T) {
	oldHome := constant.Path.HomeDir()
	constant.SetHomeDir(t.TempDir())
	t.Cleanup(func() { constant.SetHomeDir(oldHome) })
	original := methodHandlers[accountSnapshotMethod]
	t.Cleanup(func() { methodHandlers[accountSnapshotMethod] = original })
	for _, size := range []int{responseSpillThreshold + 100, maxAccountPayload + 1} {
		methodHandlers[accountSnapshotMethod] = func(*MethodCall) (any, error) { return accountReply{Value: strings.Repeat("s", size)}, nil }
		data := handleMethodCall(&MethodCall{ID: "1", Method: accountSnapshotMethod})
		var response MethodResponse
		if json.Unmarshal(data, &response) != nil || response.File != "" {
			t.Fatal("private response spilled")
		}
		if size > maxAccountPayload && (response.Error == nil || response.Error.Code != "size_limit") {
			t.Fatal("missing safe bound")
		}
		if entries, _ := os.ReadDir(spilledResponseDir()); len(entries) != 0 {
			t.Fatal("private data reached disk")
		}
	}
}
func TestPrivateAccountPanicAndDecodeAreRedacted(t *testing.T) {
	original := methodHandlers[accountLoginMethod]
	t.Cleanup(func() { methodHandlers[accountLoginMethod] = original })
	methodHandlers[accountLoginMethod] = func(*MethodCall) (any, error) { panic("synthetic-secret-password") }
	data := handleMethodCall(&MethodCall{ID: "1", Method: accountLoginMethod})
	if strings.Contains(string(data), "synthetic-secret") || !strings.Contains(string(data), "internal_error") {
		t.Fatal("panic was not redacted")
	}
	b, _ := bridgeForTest(t)
	methodHandlers[accountLoginMethod] = b.handle
	data = handleMethodCall(&MethodCall{ID: "2", Method: accountLoginMethod, Arguments: json.RawMessage(`{"credentials":{"password":{"synthetic-secret-token":true}}}`)})
	if strings.Contains(string(data), "synthetic-secret") || !strings.Contains(string(data), "invalid_arguments") {
		t.Fatal("decode error was not redacted")
	}
}
func TestDeviceStartContextOutlivesRPCAndLogoutCancels(t *testing.T) {
	b, fake := bridgeForTest(t)
	p := accountRequest{Lease: 1, Intent: 1, RequestID: "start"}
	reply := bridgeCall(t, b, accountDeviceStartMethod, p)
	if reply.Failure != nil || fake.startContext.Err() != nil {
		t.Fatal("start context ended with RPC")
	}
	p.ID = "synthetic-flow"
	p.RequestID = "poll"
	reply = bridgeCall(t, b, accountDevicePollMethod, p)
	if reply.Failure != nil || reply.Value.(heysocks.DeviceEvent).Code == "" {
		t.Fatal("poll did not receive code")
	}
	p.Intent = 2
	p.RequestID = "logout"
	bridgeCall(t, b, accountLogoutMethod, p)
	select {
	case <-fake.startContext.Done():
	case <-time.After(time.Second):
		t.Fatal("logout did not cancel flow")
	}
}
func TestLogoutFencesInFlightAndQueuedAccountCalls(t *testing.T) {
	b, fake := bridgeForTest(t)
	done := make(chan accountReply, 1)
	go func() { done <- bridgeCall(t, b, accountCatalogMethod, accountRequest{Lease: 1, RequestID: "fetch"}) }()
	<-fake.entered
	bridgeCall(t, b, accountLogoutMethod, accountRequest{Lease: 1, Intent: 1, RequestID: "logout"})
	if result := <-done; result.Failure == nil || result.Failure.Kind != heysocks.ErrSuperseded {
		t.Fatal("stale response survived logout")
	}
	result := bridgeCall(t, b, accountLoginMethod, accountRequest{Lease: 1, Intent: 1, RequestID: "old-login"})
	if result.Failure == nil || result.Failure.Kind != heysocks.ErrSuperseded {
		t.Fatal("queued old login survived logout")
	}
}

func TestAccountTransportUsesVerifiedEmbeddedRoots(t *testing.T) {
	transport := accountHTTPTransport()
	if transport.TLSClientConfig == nil || transport.TLSClientConfig.RootCAs == nil || transport.TLSClientConfig.InsecureSkipVerify || transport.TLSClientConfig.MinVersion < 0x0303 {
		t.Fatal("account transport omitted verified embedded root trust")
	}
	if transport.Proxy != nil {
		t.Fatal("account transport inherited host proxy state")
	}
}

type gatedSuspendClient struct {
	*heysocks.Client
	entered chan struct{}
	release chan struct{}
}

func (f *gatedSuspendClient) Suspend(ctx context.Context) (heysocks.SessionState, error) {
	close(f.entered)
	<-f.release
	return f.Client.Suspend(ctx)
}

func (f *gatedSuspendClient) LoginPassword(context.Context, heysocks.PasswordCredentials) (heysocks.AuthResult, error) {
	return heysocks.AuthResult{State: f.Client.State()}, nil
}

func (f *gatedSuspendClient) RestoreSession(context.Context, heysocks.SessionSnapshot) (heysocks.AuthResult, error) {
	return heysocks.AuthResult{State: f.Client.State()}, nil
}

func TestNewAccountIntentFencesDelayedSuspend(t *testing.T) {
	for _, newer := range []CoreMethod{accountLoginMethod, accountRestoreMethod, accountInitializeMethod} {
		t.Run(string(newer), func(t *testing.T) {
			b, fake := bridgeForTest(t)
			gated := &gatedSuspendClient{Client: fake.Client, entered: make(chan struct{}), release: make(chan struct{})}
			b.client = gated
			suspended := make(chan accountReply, 1)
			go func() {
				suspended <- bridgeCall(t, b, accountSuspendMethod, accountRequest{Lease: 1, Intent: 1, RequestID: "old-suspend"})
			}()
			<-gated.entered
			reply := bridgeCall(t, b, newer, accountRequest{Lease: 1, Intent: 2, RequestID: "new-account", DeviceID: "test-install", Platform: "android"})
			if reply.Failure != nil {
				t.Fatal("newer account operation failed")
			}
			current := gated.State()
			close(gated.release)
			reply = <-suspended
			if reply.Failure == nil || reply.Failure.Kind != heysocks.ErrSuperseded {
				t.Fatal("old suspend response was accepted")
			}
			if gated.State() != current {
				t.Fatal("stale suspend mutated the newer account generation")
			}
		})
	}
}
