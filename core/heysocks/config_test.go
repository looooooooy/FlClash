package heysocks

import (
	"context"
	"encoding/base64"
	"encoding/binary"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"net/http"
	"reflect"
	"strings"
	"testing"

	"go.yaml.in/yaml/v3"
	"golang.org/x/crypto/chacha20poly1305"
)

func sealFixture(plain []byte) string {
	secret := []byte("synthetic-configuration-key")
	material := []byte(hex.EncodeToString(secret))
	aead, _ := chacha20poly1305.New(configKey(secret))
	nonce := make([]byte, 12)
	payload := append(nonce, aead.Seal(nil, nonce, plain, nil)...)
	body := append(append(append(append([]byte(nil), payload[:9]...), material[:12]...), payload[9:]...), material[12:]...)
	raw := make([]byte, 17)
	raw[0] = 2
	binary.BigEndian.PutUint32(raw[1:], 9)
	binary.BigEndian.PutUint32(raw[5:], 21)
	binary.BigEndian.PutUint32(raw[9:], uint32(len(body)-(len(material)-12)))
	binary.BigEndian.PutUint32(raw[13:], uint32(len(body)))
	return base64.StdEncoding.EncodeToString(append(raw, body...))
}

func syntheticCertificate(port any, server string) string {
	plain, _ := json.Marshal(map[string]any{"type": "xhttp", "server": server, "port": port, "cipher": "aes-128-ctr", "password": "synthetic-secret:020102", "fake-net": map[string]string{"tcp": "aabb"}, "udp": true, "udp-over-tcp": true})
	return "-----BEGIN CERTIFICATE-----\nsynthetic-format-header\n" + sealFixture(plain) + "\n-----END CERTIFICATE-----"
}

func configFixture(proxies []map[string]any) ConfigEnvelope {
	plain, _ := yaml.Marshal(map[string]any{"mixed-port": 9999, "dns": map[string]bool{"enable": true}, "proxies": proxies, "rules": []string{"MATCH,DIRECT"}})
	return ConfigEnvelope{Global: sealFixture(plain)}
}

func fixtureNode() Node {
	return Node{StableID: stableKey("category", "country", "node"), CatalogNode: CatalogNode{ID: json.RawMessage(`17`), CategoryID: json.RawMessage(`2`), Name: "Node", CountryCode: "US"}, CategoryName: "Standard", CountryName: "Country"}
}

func TestNestedCertificatesAndSupportedBackups(t *testing.T) {
	envelope := configFixture([]map[string]any{
		{"type": "xhttp", "server": "outer-wrong.invalid", "port": 1, "certificate": syntheticCertificate("443", "primary.invalid")},
		{"type": "xhttp", "certificate": syntheticCertificate(8443, "backup.invalid")},
		{"type": "xhttp", "certificate": syntheticCertificate(8443, "backup.invalid")},
		{"type": "ss"}, {"type": "vless"}, {"type": "unexpected-private-protocol"},
	})
	result, err := ConvertConfig(fixtureNode(), envelope)
	if err != nil {
		t.Fatal(err)
	}
	if len(result.Connections) != 2 || len(result.Unsupported) != 3 || result.Connections[0].Server != "primary.invalid" || result.Connections[0].Port != 443 || result.Connections[1].Port != 8443 {
		t.Fatal("inner conversion or connection deduplication failed")
	}
	if result.Unsupported[0].Reason != "connection_validation_failed" || result.Unsupported[2].Protocol != "unknown" {
		t.Fatal("unsupported transports were silently accepted")
	}
	profile, err := BuildProfile([]NodeConfig{result})
	if err != nil {
		t.Fatal(err)
	}
	if len(profile.Proxies) != 2 || len(profile.Groups) != 3 || !profile.Groups[2].Hidden {
		t.Fatal("supported backup connections were not retained")
	}
	encoded, _ := yaml.Marshal(profile)
	for _, forbidden := range []string{"mixed-port:", "dns:", "rules:", "outer-wrong.invalid"} {
		if strings.Contains(string(encoded), forbidden) {
			t.Fatal("original runtime settings entered generated profile")
		}
	}
}

func TestCorruptConfigCannotYieldUsableNode(t *testing.T) {
	valid := sealFixture([]byte(`{"ok":true}`))
	raw, _ := base64.StdEncoding.DecodeString(valid)
	variants := [][]byte{}
	mutate := func(f func([]byte)) {
		value := append([]byte(nil), raw...)
		f(value)
		variants = append(variants, value)
	}
	mutate(func(v []byte) { v[17] ^= 1 })
	mutate(func(v []byte) { binary.BigEndian.PutUint32(v[1:], 0xffffffff) })
	mutate(func(v []byte) { binary.BigEndian.PutUint32(v[9:], 0) })
	mutate(func(v []byte) { v[26] = 'z' })
	variants = append(variants, append(append([]byte(nil), raw...), 0))
	for _, variant := range variants {
		if _, err := DecodeConfig(base64.StdEncoding.EncodeToString(variant)); err == nil {
			t.Fatal("corrupted authenticated envelope accepted")
		}
	}
	envelope := configFixture([]map[string]any{{"type": "xhttp", "certificate": syntheticCertificate(443, "primary.invalid")}, {"type": "xhttp", "certificate": "corrupt"}})
	result, err := ConvertConfig(fixtureNode(), envelope)
	if err == nil || len(result.Connections) != 0 {
		t.Fatal("failed certificate yielded a partial usable node")
	}
	unsupported, err := ConvertConfig(fixtureNode(), configFixture([]map[string]any{{"type": "ss"}, {"type": "vless"}}))
	if err != nil || len(unsupported.Connections) != 0 || len(unsupported.Unsupported) != 2 {
		t.Fatal("failed live backups must remain unsupported")
	}
	if _, err = BuildProfile([]NodeConfig{unsupported}); !kindOf(err, ErrUnavailable) {
		t.Fatal("unsupported-only catalog yielded a usable profile")
	}
}

func TestCatalogIdentityNoFixedLimitsAndDeterministicGroups(t *testing.T) {
	yes, no := true, false
	categories := []Category{{ID: json.RawMessage(`1`), Name: "Standard", Countries: []Country{{Code: "US", Name: "Country", Expandable: &yes}, {Code: "FAST", Name: "Fastest", Expandable: &no}}}, {ID: json.RawMessage(`2`), Name: "Residential", Countries: []Country{{Code: "CA", Name: "Country", Expandable: &yes}}}}
	for i := range 150 {
		node := CatalogNode{ID: json.RawMessage(fmt.Sprint(i + 1)), Name: "Shared name", ConnectionCode: "synthetic-routing-key"}
		categories[0].Countries[0].Nodes = append(categories[0].Countries[0].Nodes, node)
	}
	categories[0].Countries[1].Nodes = categories[0].Countries[0].Nodes
	categories[0].Countries[0].Nodes = append(categories[0].Countries[0].Nodes, categories[0].Countries[0].Nodes[0])
	categories[1].Countries[0].Nodes = []CatalogNode{categories[0].Countries[0].Nodes[0]}
	nodes := FlattenCatalog(categories)
	if len(nodes) != 151 {
		t.Fatal("catalog flattened with fixed cap or aggregate duplicates")
	}
	if nodes[0].CategoryName != "Residential" || scalarID(nodes[0].CategoryID) != "2" || nodes[0].ConnectionCode == "" {
		t.Fatal("category or connection identity was lost")
	}
	connection, err := ConvertConfig(nodes[0], configFixture([]map[string]any{{"type": "xhttp", "certificate": syntheticCertificate(443, "primary.invalid")}}))
	if err != nil {
		t.Fatal(err)
	}
	configs := []NodeConfig{}
	for _, node := range nodes {
		value := connection
		value.Node = node
		configs = append(configs, value)
	}
	a, err := BuildProfile(configs)
	if err != nil {
		t.Fatal(err)
	}
	for i, j := 0, len(configs)-1; i < j; i, j = i+1, j-1 {
		configs[i], configs[j] = configs[j], configs[i]
	}
	b, err := BuildProfile(configs)
	if err != nil || !reflect.DeepEqual(a, b) || len(a.Proxies) != 151 {
		t.Fatal("grouping is not deterministic or is capped")
	}
	for _, config := range configs {
		if config.Node.Ordinal > 1 {
			partial, err := BuildProfile([]NodeConfig{config})
			if err != nil || partial.Proxies[0].Name != a.Proxies[config.Node.Ordinal-1].Name {
				t.Fatal("partial publication renamed a route")
			}
			break
		}
	}
	seen := map[string]bool{}
	for _, group := range a.Groups {
		if seen[group.Name] {
			t.Fatal("duplicate group name")
		}
		seen[group.Name] = true
	}
	for _, proxy := range a.Proxies {
		if seen[proxy.Name] {
			t.Fatal("ambiguous proxy name")
		}
		seen[proxy.Name] = true
	}
}

func TestNodeConfigRequestPreservesSelectionAndCategory(t *testing.T) {
	envelope := configFixture([]map[string]any{{"type": "xhttp", "certificate": syntheticCertificate(443, "primary.invalid")}})
	c, _ := testClient(t, func(w http.ResponseWriter, r *http.Request) {
		fields := testBody(t, r)
		if string(fields["id"]) != "17" || string(fields["category"]) != "2" || string(fields["connection_code"]) != `"synthetic-routing-key"` || string(fields["interface_name"]) != `""` || string(fields["nameservers"]) != `"192.0.2.53"` {
			t.Error("node selection or original config fields changed")
		}
		testResponse(w, 0, envelope)
	})
	seedSession(t, c, "synthetic-token")
	node := fixtureNode()
	node.ConnectionCode = "synthetic-routing-key"
	result, err := c.FetchNodeConfig(context.Background(), node, ConfigOptions{Nameservers: []string{"192.0.2.53"}, Strategy: "global", Advanced: map[string]json.RawMessage{"id": json.RawMessage(`999`), "interface_name": json.RawMessage(`"unwanted"`)}})
	if err != nil || len(result.Connections) != 1 {
		t.Fatal("node configuration fetch failed")
	}
}
