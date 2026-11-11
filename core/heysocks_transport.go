//go:build !android

package core

import (
	"crypto/tls"
	"github.com/metacubex/mihomo/component/ca"
	"net/http"
)

func accountHTTPTransport() *http.Transport {
	transport := http.DefaultTransport.(*http.Transport).Clone()
	transport.Proxy = nil
	transport.TLSClientConfig = &tls.Config{MinVersion: tls.VersionTLS12, RootCAs: ca.GetCertPool()}
	return transport
}
