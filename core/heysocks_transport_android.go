//go:build android

package core

import (
	"context"
	"crypto/tls"
	"github.com/metacubex/mihomo/component/ca"
	"github.com/metacubex/mihomo/component/dialer"
	"github.com/metacubex/mihomo/component/resolver"
	"net"
	"net/http"
)

func accountHTTPTransport() *http.Transport {
	installHooks()
	transport := http.DefaultTransport.(*http.Transport).Clone()
	transport.Proxy = nil
	transport.TLSClientConfig = &tls.Config{MinVersion: tls.VersionTLS12, RootCAs: ca.GetCertPool()}
	transport.DialContext = func(ctx context.Context, network, address string) (net.Conn, error) {
		return dialer.DialContext(ctx, network, address, dialer.WithResolver(resolver.SystemResolver))
	}
	return transport
}
