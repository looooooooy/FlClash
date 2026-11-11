package heysocks

import (
	"encoding/base64"
	"strings"
	"testing"
)

func TestPublishedAPIEncodingVectors(t *testing.T) {
	p := protocol{platform: "android", version: "551", crypto: "synthetic-salt", public: "synthetic-key", private: "synthetic-key"}
	if got := p.sign("device-test", 1700000000); got != "24ed4fb5e23dc700d7f4042f55845d31" {
		t.Fatal("login signature differs from original MD5 vector")
	}
	const plain = `{"email":"用户@example.invalid"}`
	const encoded = "CFsLGQkMGEtZD4zx0ZXx2TQNHRUEE0EOSxAdDw8YAQFWFA=="
	if got := p.encode([]byte(plain)); got != encoded {
		t.Fatal("UTF-8 request encoding differs from original XOR vector")
	}
	decoded, err := p.decode(encoded, 1024)
	if err != nil || string(decoded) != plain {
		t.Fatal("response decoding failed")
	}
}

func TestConfigEnvelopeRejectsMalformedInput(t *testing.T) {
	for _, encoded := range []string{"", "?", base64.StdEncoding.EncodeToString([]byte{1}), base64.StdEncoding.EncodeToString([]byte{16}), base64.StdEncoding.EncodeToString([]byte{2, 0, 0}), strings.Repeat("A", maxConfigBytes*2)} {
		if _, err := DecodeConfig(encoded); err == nil {
			t.Fatal("malformed envelope accepted")
		}
	}
}
