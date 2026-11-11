package heysocks

import (
	"context"
	"net/http"
	"testing"
	"time"
)

func TestStateWatchCapturesRotationAfterLastCallerCanceled(t *testing.T) {
	entered, release := make(chan struct{}), make(chan struct{})
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		close(entered)
		select {
		case <-release:
			testResponse(w, 0, map[string]string{"token": "synthetic-late-renewal"})
		case <-r.Context().Done():
		}
	})
	seedSession(t, c, "synthetic-before")
	before := c.State()
	ctx, cancel := context.WithCancel(context.Background())
	done := make(chan error, 1)
	go func() { _, err := c.RefreshSession(ctx); done <- err }()
	<-entered
	cancel()
	if !kindOf(<-done, ErrCanceled) {
		t.Fatal("caller did not cancel")
	}
	close(release)
	watchCtx, stop := context.WithTimeout(context.Background(), time.Second)
	defer stop()
	state, err := c.WaitState(watchCtx, before.Revision)
	if err != nil || !state.Authenticated || state.Revision == before.Revision {
		t.Fatal("late revision was not observable")
	}
	snapshot, err := c.Snapshot()
	if err != nil || snapshot.Session.token != "synthetic-late-renewal" {
		t.Fatal("watch did not expose latest private snapshot")
	}
}
func TestCanceledLoginCannotResetCurrentGeneration(t *testing.T) {
	c, _ := testClient(t, func(http.ResponseWriter, *http.Request) { t.Error("canceled login made network request") })
	seedSession(t, c, "synthetic-existing")
	before := c.State()
	ctx, cancel := context.WithCancel(context.Background())
	cancel()
	_, err := c.LoginPassword(ctx, PasswordCredentials{Email: "synthetic@example.test", Password: "synthetic"})
	if !kindOf(err, ErrCanceled) || c.State() != before {
		t.Fatal("canceled login replaced current generation")
	}
}

func TestSuspendRetainsSessionAndRejectsCanceledContext(t *testing.T) {
	c, _ := testClient(t, func(http.ResponseWriter, *http.Request) { t.Error("suspend made a network request") })
	seedSession(t, c, "synthetic-existing")
	before := c.State()
	ctx, cancel := context.WithCancel(context.Background())
	cancel()
	if _, err := c.Suspend(ctx); !kindOf(err, ErrCanceled) || c.State() != before {
		t.Fatal("canceled suspend changed the current session")
	}
	after, err := c.Suspend(context.Background())
	if err != nil || !after.Authenticated || after.Generation <= before.Generation || after.Revision <= before.Revision {
		t.Fatal("active suspend did not retain and fence the session")
	}
	snapshot, err := c.Snapshot()
	if err != nil || snapshot.Session.token != "synthetic-existing" {
		t.Fatal("suspend lost the current private session")
	}
}
