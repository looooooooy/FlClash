package heysocks

import (
	"context"
	"encoding/base64"
	"encoding/json"
	"net/http"
	"strings"
	"testing"
	"time"

	"github.com/coder/websocket"
)

func writeDeviceEvent(ctx context.Context, conn *websocket.Conn, kind string, data any) error {
	plain, _ := json.Marshal(map[string]any{"type": kind, "data": data})
	key := []byte("response-fixture-key")
	for i := range plain {
		plain[i] ^= key[i%len(key)]
	}
	return conn.Write(ctx, websocket.MessageText, []byte(base64.StdEncoding.EncodeToString(plain)))
}

func TestDeviceCodePendingAuthorizationAndCancel(t *testing.T) {
	for _, authorize := range []bool{false, true} {
		t.Run(map[bool]string{false: "pending_cancel", true: "authorized"}[authorize], func(t *testing.T) {
			proceed := make(chan struct{})
			c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
				if r.URL.Path == "/v1/member/info" {
					if testHeader(t, r)["X-TOKEN"] != "device-synthetic-token" {
						t.Error("member token mismatch")
					}
					testResponse(w, 0, map[string]any{"id": 3, "limits": map[string]int{"devices": 2}})
					return
				}
				if r.URL.Query().Get("x-identifier") != "device-test" || r.URL.Query().Get("x-platform") != "android" || r.URL.Query().Get("x-version") != "551" {
					t.Error("device authorization query mismatch")
				}
				conn, err := websocket.Accept(w, r, nil)
				if err != nil {
					t.Error("websocket accept failed")
					return
				}
				defer conn.CloseNow()
				ctx, cancel := context.WithTimeout(r.Context(), 2*time.Second)
				defer cancel()
				if writeDeviceEvent(ctx, conn, "code", "TEST-CODE") != nil {
					return
				}
				<-proceed
				if authorize {
					_ = writeDeviceEvent(ctx, conn, "token", `{"token":"device-synthetic-token","vendor_expiry":111,"extension":"kept"}`)
				}
				_, _, _ = conn.Read(ctx)
			})
			flow, err := c.StartDeviceAuthorization(context.Background())
			if err != nil {
				t.Fatal(err)
			}
			pending, err := c.PollDeviceAuthorization(context.Background(), flow.ID)
			if err != nil || pending.Type != "code" || pending.Code != "TEST-CODE" || c.State().Authenticated {
				t.Fatal("device pending state failed")
			}
			if authorize {
				close(proceed)
				result, err := c.PollDeviceAuthorization(context.Background(), flow.ID)
				if err != nil || result.Type != "authorized" || !result.State.Authenticated {
					t.Fatal("device token flow failed")
				}
				snapshot, _ := c.Snapshot()
				if !strings.Contains(string(snapshot.Session.Payload), `"extension":"kept"`) {
					t.Fatal("device token payload was discarded")
				}
			} else {
				c.CancelDeviceAuthorization(flow.ID)
				close(proceed)
				if _, err := c.PollDeviceAuthorization(context.Background(), flow.ID); !kindOf(err, ErrSuperseded) || c.State().Authenticated {
					t.Fatal("device cancellation failed")
				}
			}
		})
	}
}

func TestDeviceErrorAndCancellationStayRedacted(t *testing.T) {
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		conn, err := websocket.Accept(w, r, nil)
		if err != nil {
			return
		}
		defer conn.CloseNow()
		_ = writeDeviceEvent(r.Context(), conn, "error", `{"message":"private device token"}`)
		_, _, _ = conn.Read(r.Context())
	})
	flow, err := c.StartDeviceAuthorization(context.Background())
	if err != nil {
		t.Fatal(err)
	}
	_, err = c.PollDeviceAuthorization(context.Background(), flow.ID)
	if !kindOf(err, ErrVendor) || strings.Contains(err.Error(), "private device") {
		t.Fatal("device error was not redacted")
	}
	blocked, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		conn, err := websocket.Accept(w, r, nil)
		if err != nil {
			return
		}
		defer conn.CloseNow()
		_, _, _ = conn.Read(r.Context())
	})
	flow, err = blocked.StartDeviceAuthorization(context.Background())
	if err != nil {
		t.Fatal(err)
	}
	ctx, cancel := context.WithCancel(context.Background())
	cancel()
	_, err = blocked.PollDeviceAuthorization(ctx, flow.ID)
	if !kindOf(err, ErrCanceled) || blocked.State().Authenticated {
		t.Fatal("device poll cancellation failed")
	}
}
