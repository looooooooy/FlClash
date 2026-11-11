package core

import (
	"bytes"
	"context"
	"core/heysocks"
	"encoding/json"
	"errors"
	"net/http"
	"strings"
	"sync"
	"time"
)

const maxAccountPayload = 4 << 20

type accountClient interface {
	Discover(context.Context) (heysocks.DiscoveryResult, error)
	LoginPassword(context.Context, heysocks.PasswordCredentials) (heysocks.AuthResult, error)
	ContinueCaptcha(context.Context, string, string) (heysocks.AuthResult, error)
	ValidateCaptcha(context.Context, string) error
	RestoreSession(context.Context, heysocks.SessionSnapshot) (heysocks.AuthResult, error)
	RefreshSession(context.Context) (heysocks.SessionState, error)
	State() heysocks.SessionState
	Snapshot() (heysocks.SessionSnapshot, error)
	WaitState(context.Context, uint64) (heysocks.SessionState, error)
	StartDeviceAuthorization(context.Context) (heysocks.DeviceAuthorization, error)
	PollDeviceAuthorization(context.Context, string) (heysocks.DeviceEvent, error)
	CancelDeviceAuthorization(string)
	FetchCatalog(context.Context, string) (heysocks.Catalog, error)
	FetchNodeConfig(context.Context, heysocks.Node, heysocks.ConfigOptions) (heysocks.NodeConfig, error)
	Suspend(context.Context) (heysocks.SessionState, error)
	Logout()
}

type accountRequest struct {
	Lease        uint64                       `json:"lease"`
	Intent       uint64                       `json:"intent"`
	RequestID    string                       `json:"requestId"`
	Platform     string                       `json:"platform"`
	DeviceID     string                       `json:"deviceId"`
	DeviceName   string                       `json:"deviceName"`
	Language     string                       `json:"language"`
	Credentials  heysocks.PasswordCredentials `json:"credentials"`
	Snapshot     heysocks.SessionSnapshot     `json:"snapshot"`
	ID           string                       `json:"id"`
	CaptchaToken string                       `json:"captchaToken"`
	Revision     uint64                       `json:"revision"`
	ISP          string                       `json:"isp"`
	Node         heysocks.Node                `json:"node"`
	Options      heysocks.ConfigOptions       `json:"options"`
	Configs      []heysocks.NodeConfig        `json:"configs"`
}

type accountReply struct {
	Value     any                        `json:"value,omitempty"`
	Failure   *heysocks.Error            `json:"failure,omitempty"`
	Challenge *heysocks.CaptchaChallenge `json:"challenge,omitempty"`
}

func (accountRequest) String() string { return "accountRequest{redacted}" }
func (accountReply) String() string   { return "accountReply{redacted}" }

type accountBridge struct {
	mu                 sync.Mutex
	client             accountClient
	deviceID, platform string
	lease, intent      uint64
	ctx                context.Context
	cancel             context.CancelFunc
	pending            map[string]context.CancelFunc
	factory            func(heysocks.Options) (accountClient, error)
}

func newAccountBridge() *accountBridge {
	return &accountBridge{factory: func(options heysocks.Options) (accountClient, error) {
		options.HTTPClient = &http.Client{Transport: accountHTTPTransport()}
		return heysocks.NewClient(options)
	}}
}

var accounts = newAccountBridge()

func isAccountMethod(method CoreMethod) bool { return strings.HasPrefix(string(method), "account.") }

func privateAccountResponse(call *MethodCall) (data []byte) {
	defer func() {
		if recover() != nil {
			data = accountFailureResponse(call.ID, "internal_error")
		}
	}()
	handler, exists := methodHandlers[call.Method]
	if !exists {
		return accountFailureResponse(call.ID, "not_implemented")
	}
	result, err := handler(call)
	if err != nil {
		return accountFailureResponse(call.ID, "invalid_arguments")
	}
	data, err = json.Marshal(MethodResponse{ID: call.ID, Result: result})
	if err != nil {
		return accountFailureResponse(call.ID, "internal_error")
	}
	if len(data) > maxAccountPayload {
		return accountFailureResponse(call.ID, "size_limit")
	}
	return data
}

func accountFailureResponse(id, code string) []byte {
	data, _ := json.Marshal(MethodResponse{ID: id, Error: &MethodError{Code: code, Message: "Account operation failed"}})
	return data
}

func accountFailure(kind heysocks.ErrorKind) accountReply {
	return accountReply{Failure: &heysocks.Error{Kind: kind, Operation: "account"}}
}

func (b *accountBridge) handle(call *MethodCall) (any, error) {
	var p accountRequest
	if len(call.Arguments) == 0 || len(call.Arguments) > maxAccountPayload || bytes.Equal(call.Arguments, []byte("null")) {
		return nil, errors.New("invalid account arguments")
	}
	decoder := json.NewDecoder(bytes.NewReader(call.Arguments))
	decoder.DisallowUnknownFields()
	if decoder.Decode(&p) != nil {
		return nil, errors.New("invalid account arguments")
	}
	b.mu.Lock()
	if call.Method == accountInitializeMethod {
		defer b.mu.Unlock()
		if b.client == nil {
			client, err := b.factory(heysocks.Options{Platform: p.Platform, DeviceID: p.DeviceID, DeviceName: p.DeviceName, Language: p.Language})
			if err != nil {
				return accountFailure(heysocks.ErrInput), nil
			}
			b.client, b.deviceID, b.platform = client, p.DeviceID, p.Platform
		} else if b.deviceID != p.DeviceID || b.platform != p.Platform {
			return accountFailure(heysocks.ErrInput), nil
		}
		b.resetLocked()
		b.lease++
		b.intent = 0
		return accountReply{Value: struct {
			Lease uint64                `json:"lease"`
			State heysocks.SessionState `json:"state"`
		}{b.lease, b.client.State()}}, nil
	}
	if b.client == nil || p.Lease != b.lease {
		b.mu.Unlock()
		return accountFailure(heysocks.ErrSuperseded), nil
	}
	mutation := call.Method == accountLoginMethod || call.Method == accountRestoreMethod || call.Method == accountDeviceStartMethod || call.Method == accountLogoutMethod || call.Method == accountSuspendMethod
	if mutation {
		if p.Intent <= b.intent {
			b.mu.Unlock()
			return accountFailure(heysocks.ErrSuperseded), nil
		}
		b.resetLocked()
		if call.Method != accountSuspendMethod {
			b.client.Logout()
		}
		b.intent = p.Intent
	} else if p.Intent != b.intent {
		b.mu.Unlock()
		return accountFailure(heysocks.ErrSuperseded), nil
	}
	client := b.client
	if call.Method == accountCancelMethod {
		if cancel := b.pending[p.ID]; cancel != nil {
			cancel()
		}
		b.mu.Unlock()
		return accountReply{Value: true}, nil
	}
	if len(p.RequestID) == 0 || len(p.RequestID) > 128 || len(b.pending) >= 16 {
		b.mu.Unlock()
		return accountFailure(heysocks.ErrBusy), nil
	}
	if _, exists := b.pending[p.RequestID]; exists {
		b.mu.Unlock()
		return accountFailure(heysocks.ErrBusy), nil
	}
	timeout := 50 * time.Second
	if call.Method == accountWatchMethod {
		timeout = 25 * time.Second
	}
	if call.Method == accountDevicePollMethod || call.Method == accountDeviceStartMethod {
		timeout = 310 * time.Second
	}
	ctx, cancel := context.WithTimeout(b.ctx, timeout)
	b.pending[p.RequestID] = cancel
	lease, intent := b.lease, b.intent
	b.mu.Unlock()
	keepContext := false
	defer func() {
		if !keepContext {
			cancel()
		}
		b.mu.Lock()
		if b.lease == lease && b.intent == intent {
			delete(b.pending, p.RequestID)
		}
		b.mu.Unlock()
	}()
	var value any
	var err error
	switch call.Method {
	case accountDiscoverMethod:
		value, err = client.Discover(ctx)
	case accountLoginMethod:
		value, err = client.LoginPassword(ctx, p.Credentials)
	case accountCaptchaMethod:
		value, err = client.ContinueCaptcha(ctx, p.ID, p.CaptchaToken)
	case accountValidateCaptchaMethod:
		err = client.ValidateCaptcha(ctx, p.CaptchaToken)
		value = true
	case accountRestoreMethod:
		value, err = client.RestoreSession(ctx, p.Snapshot)
	case accountRefreshMethod:
		value, err = client.RefreshSession(ctx)
	case accountStateMethod:
		value = client.State()
	case accountSnapshotMethod:
		value, err = client.Snapshot()
	case accountWatchMethod:
		value, err = client.WaitState(ctx, p.Revision)
		if ctx.Err() == context.DeadlineExceeded {
			value, err = client.State(), nil
		}
	case accountDeviceStartMethod:
		value, err = client.StartDeviceAuthorization(ctx)
		keepContext = err == nil
	case accountDevicePollMethod:
		value, err = client.PollDeviceAuthorization(ctx, p.ID)
	case accountDeviceCancelMethod:
		client.CancelDeviceAuthorization(p.ID)
		value = true
	case accountCatalogMethod:
		value, err = client.FetchCatalog(ctx, p.ISP)
	case accountConfigMethod:
		value, err = client.FetchNodeConfig(ctx, p.Node, p.Options)
	case accountBuildProfileMethod:
		value, err = heysocks.BuildProfile(p.Configs)
	case accountSuspendMethod:
		value, err = client.Suspend(ctx)
	case accountLogoutMethod:
		value = client.State()
	default:
		return accountFailure(heysocks.ErrInput), nil
	}
	b.mu.Lock()
	stale := b.lease != lease || b.intent != intent
	b.mu.Unlock()
	if stale {
		return accountFailure(heysocks.ErrSuperseded), nil
	}
	if err != nil {
		var safe *heysocks.Error
		if errors.As(err, &safe) {
			return accountReply{Failure: safe, Challenge: safe.Challenge}, nil
		}
		return accountFailure(heysocks.ErrUnavailable), nil
	}
	return accountReply{Value: value}, nil
}

func (b *accountBridge) resetLocked() {
	if b.cancel != nil {
		b.cancel()
	}
	b.ctx, b.cancel = context.WithCancel(context.Background())
	b.pending = make(map[string]context.CancelFunc)
}
