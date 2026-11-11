package heysocks

import (
	"bytes"
	"context"
	"crypto/tls"
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"sync"
	"time"
)

type ErrorKind string

const (
	ErrInput        ErrorKind = "invalid_input"
	ErrNetwork      ErrorKind = "network_unavailable"
	ErrCanceled     ErrorKind = "canceled"
	ErrProtocol     ErrorKind = "invalid_response"
	ErrIntegrity    ErrorKind = "config_authentication_failed"
	ErrLimit        ErrorKind = "size_limit"
	ErrUnauthorized ErrorKind = "authentication_required"
	ErrUnavailable  ErrorKind = "account_unavailable"
	ErrCaptcha      ErrorKind = "captcha_required"
	ErrVendor       ErrorKind = "request_rejected"
	ErrSuperseded   ErrorKind = "superseded"
	ErrBusy         ErrorKind = "operation_in_progress"
)

type Error struct {
	Kind       ErrorKind         `json:"kind"`
	Operation  string            `json:"operation"`
	HTTPStatus int               `json:"httpStatus,omitempty"`
	VendorCode int               `json:"vendorCode,omitempty"`
	Challenge  *CaptchaChallenge `json:"-"`
}

func (e *Error) Error() string {
	return fmt.Sprintf("heysocks: %s: %s (http=%d code=%d)", e.Operation, e.Kind, e.HTTPStatus, e.VendorCode)
}
func (e *Error) GoString() string              { return e.Error() }
func failure(op string, kind ErrorKind) *Error { return &Error{Operation: op, Kind: kind} }
func kindOf(err error, kind ErrorKind) bool {
	var e *Error
	return errors.As(err, &e) && e.Kind == kind
}

type Options struct {
	Platform         string
	DeviceID         string
	DeviceName       string
	Language         string
	HTTPClient       *http.Client
	RequestTimeout   time.Duration
	CallTimeout      time.Duration
	MaxResponseBytes int
}

type Client struct {
	mu            sync.Mutex
	p             protocol
	options       Options
	http          *http.Client
	hosts         []string
	preferred     string
	allowHTTP     bool
	generation    uint64
	revision      uint64
	changed       chan struct{}
	accountCtx    context.Context
	accountCancel context.CancelFunc
	session       *Session
	refresh       *refreshCall
	pending       *pendingCaptcha
	device        *deviceFlow
}

func (c *Client) String() string   { return "heysocks.Client{redacted}" }
func (c *Client) GoString() string { return c.String() }

func NewClient(options Options) (*Client, error) {
	if options.Platform == "" {
		options.Platform = "android"
	}
	p, ok := publishedProtocols[options.Platform]
	if !ok || strings.TrimSpace(options.DeviceID) == "" || len(options.DeviceID) > 256 || options.DeviceName == "" || len(options.DeviceName) > 256 {
		return nil, failure("client", ErrInput)
	}
	if options.Language == "" {
		options.Language = "en"
	}
	if strings.ContainsAny(options.Language, "\r\n") || len(options.Language) > 128 {
		return nil, failure("client", ErrInput)
	}
	if options.RequestTimeout <= 0 {
		options.RequestTimeout = 10 * time.Second
	}
	if options.CallTimeout <= 0 {
		options.CallTimeout = 45 * time.Second
	}
	if options.MaxResponseBytes <= 0 {
		options.MaxResponseBytes = 16 << 20
	}
	if options.MaxResponseBytes > 32<<20 {
		return nil, failure("client", ErrInput)
	}
	hc := &http.Client{}
	if options.HTTPClient != nil {
		*hc = *options.HTTPClient
	}
	if hc.Transport == nil {
		hc.Transport = http.DefaultTransport.(*http.Transport).Clone()
	}
	if tr, ok := hc.Transport.(*http.Transport); ok {
		tr = tr.Clone()
		if tr.TLSClientConfig != nil {
			tr.TLSClientConfig = tr.TLSClientConfig.Clone()
		} else {
			tr.TLSClientConfig = &tls.Config{}
		}
		if tr.TLSClientConfig.InsecureSkipVerify {
			return nil, failure("client", ErrInput)
		}
		if tr.TLSClientConfig.MinVersion < tls.VersionTLS12 {
			tr.TLSClientConfig.MinVersion = tls.VersionTLS12
		}
		hc.Transport = tr
	}
	hc.CheckRedirect = func(*http.Request, []*http.Request) error { return http.ErrUseLastResponse }
	ctx, cancel := context.WithCancel(context.Background())
	return &Client{p: p, options: options, http: hc, hosts: append([]string(nil), p.hosts...), accountCtx: ctx, accountCancel: cancel, changed: make(chan struct{})}, nil
}

type requestSpec struct {
	op, method, path string
	params           url.Values
	body             []byte
	login, retryable bool
}

func (c *Client) endpoint(value string, origin bool) (*url.URL, error) {
	u, err := url.Parse(value)
	if err != nil || u.Hostname() == "" || u.User != nil || u.Fragment != "" || (u.Scheme != "https" && !(c.allowHTTP && u.Scheme == "http")) || (origin && u.RawQuery != "") {
		return nil, failure("host", ErrProtocol)
	}
	return u, nil
}

func (c *Client) hostList() []string {
	c.mu.Lock()
	defer c.mu.Unlock()
	result := make([]string, 0, len(c.hosts))
	if c.preferred != "" {
		result = append(result, c.preferred)
	}
	for _, host := range c.hosts {
		if host != c.preferred {
			result = append(result, host)
		}
	}
	return result
}

func (c *Client) useHost(host string) { c.mu.Lock(); c.preferred = host; c.mu.Unlock() }

func (c *Client) send(ctx context.Context, req *http.Request, op string, limit int) ([]byte, int, error) {
	attempt, cancel := context.WithTimeout(ctx, c.options.RequestTimeout)
	defer cancel()
	resp, err := c.http.Do(req.WithContext(attempt))
	if err != nil {
		if ctx.Err() != nil {
			return nil, 0, failure(op, ErrCanceled)
		}
		return nil, 0, failure(op, ErrNetwork)
	}
	defer resp.Body.Close()
	if resp.ContentLength > int64(limit) {
		return nil, resp.StatusCode, failure(op, ErrLimit)
	}
	body, err := io.ReadAll(io.LimitReader(resp.Body, int64(limit)+1))
	if len(body) > limit {
		return nil, resp.StatusCode, failure(op, ErrLimit)
	}
	if err != nil {
		if ctx.Err() != nil {
			return nil, resp.StatusCode, failure(op, ErrCanceled)
		}
		return nil, resp.StatusCode, failure(op, ErrNetwork)
	}
	return body, resp.StatusCode, nil
}

func (c *Client) makeRequest(spec requestSpec, host, token string) (*http.Request, error) {
	u, err := c.endpoint(host, true)
	if err != nil {
		return nil, err
	}
	u.Path = strings.TrimRight(u.Path, "/") + spec.path
	u.RawPath = ""
	if spec.params != nil {
		u.RawQuery = url.Values{"data": {c.p.encode([]byte(strings.ReplaceAll(spec.params.Encode(), "+", "%20")))}}.Encode()
	}
	var body io.Reader
	if spec.body != nil {
		encoded, _ := json.Marshal(struct {
			Data string `json:"data"`
		}{c.p.encode(spec.body)})
		body = bytes.NewReader(encoded)
	}
	req, err := http.NewRequest(spec.method, u.String(), body)
	if err != nil {
		return nil, failure(spec.op, ErrInput)
	}
	now := time.Now().Unix()
	extra := map[string]string{"X-DEVICE-NAME": c.options.DeviceName, "X-IDENTIFIER": c.options.DeviceID, "X-TOKEN": token, "X-SOURCE": c.p.source, "X-TIMESTAMP": strconv.FormatInt(now, 10)}
	if spec.login {
		extra["x-sign"] = c.p.sign(c.options.DeviceID, now)
	}
	header, _ := json.Marshal(extra)
	req.Header.Set("X-HEADER", c.p.encode(header))
	req.Header.Set("X-VERSION", c.p.version)
	req.Header.Set("X-PLATFORM", c.p.platform)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept-Language", c.options.Language)
	return req, nil
}

func (c *Client) raw(ctx context.Context, spec requestSpec, token string) (json.RawMessage, error) {
	ctx, cancel := context.WithTimeout(ctx, c.options.CallTimeout)
	defer cancel()
	hosts := c.hostList()
	if spec.login {
		host, err := c.pickHost(ctx, hosts)
		if err != nil {
			return nil, err
		}
		hosts = []string{host}
	}
	for _, host := range hosts {
		if ctx.Err() != nil {
			return nil, failure(spec.op, ErrCanceled)
		}
		req, err := c.makeRequest(spec, host, token)
		if err != nil {
			return nil, err
		}
		body, status, err := c.send(ctx, req, spec.op, c.options.MaxResponseBytes)
		if err != nil {
			if kindOf(err, ErrNetwork) && spec.retryable {
				continue
			}
			return nil, err
		}
		if status == 401 {
			return nil, &Error{Kind: ErrUnauthorized, Operation: spec.op, HTTPStatus: status}
		}
		if status >= 500 && spec.retryable {
			continue
		}
		if status < 200 || status >= 300 {
			return nil, &Error{Kind: ErrVendor, Operation: spec.op, HTTPStatus: status}
		}
		var encoded string
		if len(body) > 0 && body[0] == '"' {
			if json.Unmarshal(body, &encoded) != nil {
				return nil, failure(spec.op, ErrProtocol)
			}
		} else {
			encoded = strings.TrimSpace(string(body))
		}
		plain, err := c.p.decode(encoded, c.options.MaxResponseBytes)
		if err != nil {
			return nil, err
		}
		var envelope struct {
			Code *int            `json:"code"`
			Data json.RawMessage `json:"data"`
		}
		if json.Unmarshal(plain, &envelope) != nil || envelope.Code == nil {
			return nil, failure(spec.op, ErrProtocol)
		}
		c.useHost(host)
		if *envelope.Code == 0 {
			return envelope.Data, nil
		}
		e := &Error{Operation: spec.op, Kind: ErrVendor, VendorCode: *envelope.Code, HTTPStatus: status}
		switch *envelope.Code {
		case 4029:
			e.Kind = ErrUnavailable
		case 4034:
			e.Kind = ErrCaptcha
			var data struct {
				URL string `json:"url"`
			}
			if json.Unmarshal(envelope.Data, &data) == nil {
				if _, err := c.endpoint(data.URL, false); err == nil {
					e.Challenge = &CaptchaChallenge{URL: data.URL, Operation: spec.op}
				}
			}
		}
		return nil, e
	}
	return nil, failure(spec.op, ErrNetwork)
}

func (c *Client) pickHost(ctx context.Context, hosts []string) (string, error) {
	for _, host := range hosts {
		u, err := c.endpoint(host, true)
		if err != nil {
			continue
		}
		u.Path = strings.TrimRight(u.Path, "/") + "/ping"
		u.RawPath = ""
		req, _ := http.NewRequest(http.MethodGet, u.String(), nil)
		body, status, err := c.send(ctx, req, "discover", 128)
		if err == nil && status == 200 && strings.EqualFold(strings.TrimSpace(string(body)), "pong") {
			c.useHost(host)
			return host, nil
		}
		if ctx.Err() != nil {
			return "", failure("discover", ErrCanceled)
		}
	}
	return "", failure("discover", ErrNetwork)
}

type DiscoveryResult struct {
	CandidateCount int  `json:"candidateCount"`
	Reachable      bool `json:"reachable"`
}

func (c *Client) Discover(ctx context.Context) (DiscoveryResult, error) {
	ctx, cancel := context.WithTimeout(ctx, c.options.CallTimeout)
	defer cancel()
	for _, source := range c.p.discovery {
		u, err := c.endpoint(source, false)
		if err != nil {
			continue
		}
		req, _ := http.NewRequest(http.MethodGet, u.String(), nil)
		body, status, err := c.send(ctx, req, "discover", 64<<10)
		if err != nil || status != 200 {
			continue
		}
		decoded, err := base64.StdEncoding.Strict().DecodeString(strings.TrimSpace(string(body)))
		if err != nil || len(decoded) <= 64 {
			continue
		}
		var hosts []string
		if json.Unmarshal(xorBytes(decoded[64:], string(decoded[:64])), &hosts) != nil || len(hosts) > 24 {
			continue
		}
		valid := make([]string, 0, len(hosts))
		seen := map[string]bool{}
		for _, host := range append(hosts, c.p.hosts...) {
			if _, err := c.endpoint(host, true); err == nil && !seen[host] {
				valid = append(valid, host)
				seen[host] = true
			}
		}
		if len(valid) > 0 {
			c.mu.Lock()
			c.hosts = valid
			c.mu.Unlock()
			break
		}
	}
	hosts := c.hostList()
	_, err := c.pickHost(ctx, hosts)
	return DiscoveryResult{CandidateCount: len(hosts), Reachable: err == nil}, err
}

func (c *Client) PublicConfig(ctx context.Context, keys string) (json.RawMessage, error) {
	if keys == "" || len(keys) > 1024 {
		return nil, failure("public_config", ErrInput)
	}
	return c.raw(ctx, requestSpec{op: "public_config", method: http.MethodGet, path: "/v1/system/config", params: url.Values{"keys": {keys}}, retryable: true}, "")
}
