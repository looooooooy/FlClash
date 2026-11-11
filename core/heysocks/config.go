package heysocks

import (
	"context"
	"encoding/hex"
	"encoding/json"
	"net/http"
	"strconv"
	"strings"

	"go.yaml.in/yaml/v3"
)

type ConfigOptions struct {
	Nameservers []string
	Strategy    string
	ISP         string
	Energy      bool
	Advanced    map[string]json.RawMessage
}

type ConfigEnvelope struct {
	Global    string          `json:"global"`
	Smart     string          `json:"smart"`
	Customize string          `json:"customize"`
	Kernel    json.RawMessage `json:"kernel"`
	Durations json.RawMessage `json:"durations"`
	Gundam    json.RawMessage `json:"gundam"`
}

func (ConfigEnvelope) String() string     { return "heysocks.ConfigEnvelope{redacted}" }
func (c ConfigEnvelope) GoString() string { return c.String() }

type Connection struct {
	Name              string            `json:"name" yaml:"name"`
	Type              string            `json:"type" yaml:"type"`
	Server            string            `json:"server" yaml:"server"`
	Port              int               `json:"port" yaml:"port"`
	Cipher            string            `json:"cipher" yaml:"cipher"`
	Password          string            `json:"password" yaml:"password"`
	FakeNet           map[string]string `json:"fake-net" yaml:"fake-net"`
	UDP               bool              `json:"udp" yaml:"udp"`
	UDPOverTCP        bool              `json:"udp-over-tcp" yaml:"udp-over-tcp"`
	UDPOverTCPVersion int               `json:"udp-over-tcp-version" yaml:"udp-over-tcp-version"`
}

func (Connection) String() string     { return "heysocks.Connection{redacted}" }
func (c Connection) GoString() string { return c.String() }

type UnsupportedConnection struct {
	Index    int    `json:"index"`
	Protocol string `json:"protocol"`
	Reason   string `json:"reason"`
}
type NodeConfig struct {
	Node        Node                    `json:"node"`
	Connections []Connection            `json:"connections"`
	Unsupported []UnsupportedConnection `json:"unsupported"`
	Kernel      json.RawMessage         `json:"kernel,omitempty"`
	Durations   json.RawMessage         `json:"durations,omitempty"`
	Gundam      json.RawMessage         `json:"gundam,omitempty"`
}

func (NodeConfig) String() string     { return "heysocks.NodeConfig{redacted}" }
func (c NodeConfig) GoString() string { return c.String() }

func (c *Client) FetchNodeConfig(ctx context.Context, node Node, options ConfigOptions) (NodeConfig, error) {
	if scalarID(node.ID) == "" || len(options.Nameservers) > 32 || len(options.Advanced) > 64 {
		return NodeConfig{}, failure("node_config", ErrInput)
	}
	params := map[string]any{}
	for key, value := range options.Advanced {
		if len(key) > 128 || !json.Valid(value) {
			return NodeConfig{}, failure("node_config", ErrInput)
		}
		params[key] = value
	}
	params["energy"] = options.Energy
	params["groups"] = ""
	params["nameservers"] = strings.Join(options.Nameservers, ",")
	params["strategy"] = options.Strategy
	params["isp"] = options.ISP
	params["interface_name"] = ""
	params["id"] = node.ID
	delete(params, "connection_code")
	delete(params, "category")
	if node.ConnectionCode != "" {
		if scalarID(node.CategoryID) == "" {
			return NodeConfig{}, failure("node_config", ErrInput)
		}
		params["connection_code"] = node.ConnectionCode
		params["category"] = node.CategoryID
	}
	body, err := json.Marshal(params)
	if err != nil || len(body) > 64<<10 {
		return NodeConfig{}, failure("node_config", ErrInput)
	}
	data, err := c.authenticated(ctx, requestSpec{op: "node_config", method: http.MethodPost, path: "/v3/proxy/config", body: body, retryable: true})
	if err != nil {
		return NodeConfig{}, err
	}
	var envelope ConfigEnvelope
	if json.Unmarshal(data, &envelope) != nil || envelope.Global == "" {
		return NodeConfig{}, failure("node_config", ErrProtocol)
	}
	return ConvertConfig(node, envelope)
}

func (c Connection) validate() error {
	if c.Type != "heysocks-xhttp" || c.Cipher != "aes-128-ctr" || c.Server == "" || len(c.Server) > 253 || strings.ContainsAny(c.Server, "\x00\r\n /\\") || c.Port < 1 || c.Port > 65535 || c.UDP && !c.UDPOverTCP || c.UDPOverTCPVersion != 2 {
		return failure("connection", ErrProtocol)
	}
	secret, token, ok := strings.Cut(c.Password, ":")
	decoded, err := hex.DecodeString(token)
	if !ok || secret == "" || len(c.Password) > 4096 || err != nil || len(decoded) == 0 || int(decoded[0]) != len(decoded)-1 {
		return failure("connection", ErrProtocol)
	}
	value, exists := c.FakeNet["tcp"]
	if !exists || value == "" {
		return failure("connection", ErrProtocol)
	}
	prefix, err := hex.DecodeString(value)
	if err != nil || len(prefix) > 128 {
		return failure("connection", ErrProtocol)
	}
	return nil
}

func ConvertConfig(node Node, envelope ConfigEnvelope) (NodeConfig, error) {
	plain, err := DecodeConfig(envelope.Global)
	if err != nil {
		return NodeConfig{}, err
	}
	defer clear(plain)
	var document struct {
		Proxies []struct {
			Type        string `yaml:"type"`
			Certificate string `yaml:"certificate"`
		} `yaml:"proxies"`
	}
	if yaml.Unmarshal(plain, &document) != nil || document.Proxies == nil {
		return NodeConfig{}, failure("node_config", ErrProtocol)
	}
	result := NodeConfig{Node: node, Connections: []Connection{}, Unsupported: []UnsupportedConnection{}, Kernel: envelope.Kernel, Durations: envelope.Durations, Gundam: envelope.Gundam}
	seen := map[string]bool{}
	for i, outer := range document.Proxies {
		if outer.Type != "xhttp" {
			protocol, reason := "unknown", "unsupported_protocol"
			if outer.Type == "ss" || outer.Type == "vless" {
				protocol = outer.Type
				reason = "connection_validation_failed"
			}
			result.Unsupported = append(result.Unsupported, UnsupportedConnection{Index: i, Protocol: protocol, Reason: reason})
			continue
		}
		inner, err := DecodeCertificate(outer.Certificate)
		if err != nil {
			return NodeConfig{}, err
		}
		var fields struct {
			Type       string            `json:"type"`
			Server     string            `json:"server"`
			Port       json.RawMessage   `json:"port"`
			Cipher     string            `json:"cipher"`
			Password   string            `json:"password"`
			FakeNet    map[string]string `json:"fake-net"`
			UDP        bool              `json:"udp"`
			UDPOverTCP bool              `json:"udp-over-tcp"`
		}
		if json.Unmarshal(inner, &fields) != nil {
			return NodeConfig{}, failure("certificate", ErrProtocol)
		}
		clear(inner)
		if fields.Type != "xhttp" || fields.Cipher != "aes-128-ctr" {
			result.Unsupported = append(result.Unsupported, UnsupportedConnection{Index: i, Protocol: "xhttp", Reason: "unsupported_inner_protocol"})
			continue
		}
		port, err := strconv.Atoi(scalarID(fields.Port))
		if err != nil {
			return NodeConfig{}, failure("connection", ErrProtocol)
		}
		conn := Connection{Type: "heysocks-xhttp", Server: fields.Server, Port: port, Cipher: fields.Cipher, Password: fields.Password, FakeNet: map[string]string{"tcp": fields.FakeNet["tcp"]}, UDP: fields.UDP, UDPOverTCP: fields.UDPOverTCP, UDPOverTCPVersion: 2}
		if err := conn.validate(); err != nil {
			return NodeConfig{}, err
		}
		encoded, _ := json.Marshal(conn)
		key := stableKey(string(encoded))
		clear(encoded)
		if seen[key] {
			continue
		}
		seen[key] = true
		result.Connections = append(result.Connections, conn)
	}
	return result, nil
}

func connectionLabel(index int) string { return "Connection " + strconv.Itoa(index) }
