package heysocks

import (
	"context"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"net"
	"net/http"
	"net/url"
	"sort"
	"strconv"
	"strings"
)

type Category struct {
	ID        json.RawMessage `json:"id"`
	Name      string          `json:"name"`
	Countries []Country       `json:"countries"`
}
type Country struct {
	Name       string        `json:"name"`
	Code       string        `json:"country_code"`
	Selectable bool          `json:"selectable"`
	Expandable *bool         `json:"expandable"`
	Nodes      []CatalogNode `json:"nodes"`
}
type CatalogNode struct {
	ID                      json.RawMessage   `json:"id"`
	Name                    string            `json:"name"`
	CountryCode             string            `json:"country_code"`
	CategoryID              json.RawMessage   `json:"category_id"`
	ConnectionCode          string            `json:"connection_code,omitempty"`
	Inbound                 json.RawMessage   `json:"inbound,omitempty"`
	InboundFallbackResolver map[string]string `json:"inbound_fallback_resolver,omitempty"`
	Edges                   json.RawMessage   `json:"edges,omitempty"`
}
type Node struct {
	StableID string `json:"stableId"`
	CatalogNode
	CategoryName string `json:"categoryName"`
	CountryName  string `json:"countryName"`
	Ordinal      int    `json:"ordinal,omitempty"`
}

func (CatalogNode) String() string     { return "heysocks.CatalogNode{redacted}" }
func (n CatalogNode) GoString() string { return n.String() }
func (Node) String() string            { return "heysocks.Node{redacted}" }
func (n Node) GoString() string        { return n.String() }

type Catalog struct {
	Categories []Category `json:"categories"`
	Nodes      []Node     `json:"nodes"`
}

func scalarID(raw json.RawMessage) string {
	var value any
	decoder := json.NewDecoder(strings.NewReader(string(raw)))
	decoder.UseNumber()
	if decoder.Decode(&value) != nil {
		return ""
	}
	switch v := value.(type) {
	case string:
		return v
	case json.Number:
		return string(v)
	default:
		return ""
	}
}

func stableKey(parts ...string) string {
	encoded, _ := json.Marshal(parts)
	sum := sha256.Sum256(encoded)
	return hex.EncodeToString(sum[:16])
}

func FlattenCatalog(categories []Category) []Node {
	nodes := make([]Node, 0)
	seen := map[string]bool{}
	for _, category := range categories {
		for _, country := range category.Countries {
			if country.Expandable != nil && !*country.Expandable {
				continue
			}
			for _, source := range country.Nodes {
				id := scalarID(source.ID)
				if id == "" || id == "group" {
					continue
				}
				categoryID := category.ID
				if scalarID(categoryID) == "" {
					categoryID = source.CategoryID
				}
				if scalarID(categoryID) == "" {
					continue
				}
				code := strings.ToUpper(strings.TrimSpace(country.Code))
				if code == "" {
					code = strings.ToUpper(strings.TrimSpace(source.CountryCode))
				}
				if code == "" {
					continue
				}
				source.CategoryID = append(json.RawMessage(nil), categoryID...)
				source.CountryCode = code
				source.ID = append(json.RawMessage(nil), source.ID...)
				source.Edges = append(json.RawMessage(nil), source.Edges...)
				source.Inbound = append(json.RawMessage(nil), source.Inbound...)
				key := stableKey(scalarID(categoryID), code, id, source.ConnectionCode)
				if seen[key] {
					continue
				}
				seen[key] = true
				nodes = append(nodes, Node{StableID: key, CatalogNode: source, CategoryName: strings.TrimSpace(category.Name), CountryName: strings.TrimSpace(country.Name)})
			}
		}
	}
	// A partial profile uses the same route names as the complete catalog.
	sort.Slice(nodes, func(i, j int) bool {
		return profileNodeLess(nodes[i], nodes[j])
	})
	for i := range nodes {
		nodes[i].Ordinal = i + 1
	}
	sort.Slice(nodes, func(i, j int) bool {
		a, b := nodes[i], nodes[j]
		if a.CountryCode != b.CountryCode {
			return a.CountryCode < b.CountryCode
		}
		if a.CategoryName != b.CategoryName {
			return a.CategoryName < b.CategoryName
		}
		if a.Name != b.Name {
			return a.Name < b.Name
		}
		return a.StableID < b.StableID
	})
	return nodes
}

func (c *Client) FetchCatalog(ctx context.Context, isp string) (Catalog, error) {
	if len(isp) > 256 {
		return Catalog{}, failure("catalog", ErrInput)
	}
	data, err := c.authenticated(ctx, requestSpec{op: "catalog", method: http.MethodGet, path: "/v3/proxy/nodes", params: url.Values{"isp": {isp}}, retryable: true})
	if err != nil {
		return Catalog{}, err
	}
	var categories []Category
	if json.Unmarshal(data, &categories) != nil || categories == nil {
		return Catalog{}, failure("catalog", ErrProtocol)
	}
	return Catalog{Categories: categories, Nodes: FlattenCatalog(categories)}, nil
}

type ProxyGroup struct {
	Name    string   `json:"name" yaml:"name"`
	Type    string   `json:"type" yaml:"type"`
	Proxies []string `json:"proxies" yaml:"proxies"`
	Hidden  bool     `json:"hidden,omitempty" yaml:"hidden,omitempty"`
}
type Profile struct {
	Proxies []Connection `json:"proxies" yaml:"proxies"`
	Groups  []ProxyGroup `json:"proxy-groups" yaml:"proxy-groups"`
}

func (Profile) String() string     { return "heysocks.Profile{redacted}" }
func (p Profile) GoString() string { return p.String() }

func profileNodeLess(a, b Node) bool {
	if a.CountryCode != b.CountryCode {
		return a.CountryCode < b.CountryCode
	}
	return a.StableID < b.StableID
}

func BuildProfile(configs []NodeConfig) (Profile, error) {
	ordered := append([]NodeConfig(nil), configs...)
	identities := map[string]string{}
	for _, config := range ordered {
		encoded, _ := json.Marshal(config)
		fingerprint := stableKey(string(encoded))
		clear(encoded)
		if previous, exists := identities[config.Node.StableID]; exists && previous != fingerprint {
			return Profile{}, failure("profile", ErrInput)
		}
		identities[config.Node.StableID] = fingerprint
	}
	sort.Slice(ordered, func(i, j int) bool {
		return profileNodeLess(ordered[i].Node, ordered[j].Node)
	})
	profile := Profile{Proxies: []Connection{}}
	used := map[string]bool{"HeySocks": true, "DIRECT": true, "REJECT": true, "GLOBAL": true}
	allocate := func(name, key string) string {
		name = strings.TrimSpace(name)
		if name == "" {
			name = key
		}
		if used[name] {
			name += " · " + key
		}
		base := name
		for suffix := 2; used[name]; suffix++ {
			name = base + " · " + strconv.Itoa(suffix)
		}
		used[name] = true
		return name
	}
	countries := map[string]*ProxyGroup{}
	codes := []string{}
	for _, config := range ordered {
		if len(config.Connections) == 0 {
			continue
		}
		n := config.Node
		if n.StableID == "" || n.CountryCode == "" {
			return Profile{}, failure("profile", ErrInput)
		}
		if countries[n.CountryCode] == nil {
			group := &ProxyGroup{Name: allocate(n.CountryName, n.CountryCode), Type: "select", Proxies: []string{}}
			countries[n.CountryCode] = group
			codes = append(codes, n.CountryCode)
		}
	}
	lineGroups := []ProxyGroup{}
	seen := map[string]bool{}
	lineIndex := 0
	for _, config := range ordered {
		n := config.Node
		if len(config.Connections) == 0 || seen[n.StableID] {
			continue
		}
		seen[n.StableID] = true
		lineIndex++
		nodeName := strings.TrimSpace(n.Name)
		if nodeName == "" {
			nodeName = "Node"
		}
		ordinal := n.Ordinal
		if ordinal < 1 {
			ordinal = lineIndex
		}
		lineName := allocate(fmt.Sprintf("%02d · %s", ordinal, nodeName), n.StableID[:min(8, len(n.StableID))])
		names := make([]string, 0, len(config.Connections))
		for i, conn := range config.Connections {
			if err := conn.validate(); err != nil {
				return Profile{}, err
			}
			conn.Name = lineName
			conn.ProbeEndpoints = catalogProbeEndpoints(n)
			conn.ProbeEndpointFallbackResolver = catalogProbeFallbackResolver(n, conn.ProbeEndpoints)
			if len(config.Connections) > 1 {
				conn.Name = allocate(lineName+" · "+connectionLabel(i+1), n.StableID[:min(8, len(n.StableID))])
			}
			names = append(names, conn.Name)
			profile.Proxies = append(profile.Proxies, conn)
		}
		countries[n.CountryCode].Proxies = append(countries[n.CountryCode].Proxies, lineName)
		if len(names) > 1 {
			lineGroups = append(lineGroups, ProxyGroup{Name: lineName, Type: "select", Proxies: names, Hidden: true})
		}
	}
	sort.Strings(codes)
	root := ProxyGroup{Name: "HeySocks", Type: "select", Proxies: []string{}}
	for _, code := range codes {
		root.Proxies = append(root.Proxies, countries[code].Name)
	}
	if len(root.Proxies) == 0 {
		return Profile{}, failure("profile", ErrUnavailable)
	}
	profile.Groups = append(profile.Groups, root)
	for _, code := range codes {
		profile.Groups = append(profile.Groups, *countries[code])
	}
	profile.Groups = append(profile.Groups, lineGroups...)
	return profile, nil
}

// catalogProbeEndpoints keeps the catalog's direct TCP probe targets alongside
// each generated HeySocks outbound. HeySocks tests these inbounds, not the
// encrypted transport endpoint embedded in the fetched node configuration.
func catalogProbeEndpoints(node Node) []string {
	var inbound string
	if len(node.Inbound) == 0 || json.Unmarshal(node.Inbound, &inbound) != nil {
		return nil
	}
	seen := map[string]bool{}
	endpoints := make([]string, 0)
	for _, endpoint := range strings.Split(inbound, ",") {
		endpoint = strings.TrimSpace(endpoint)
		host, portText, err := net.SplitHostPort(endpoint)
		port, portErr := strconv.Atoi(portText)
		if err != nil || portErr != nil || host == "" || port < 1 || port > 65535 || seen[endpoint] {
			continue
		}
		seen[endpoint] = true
		endpoints = append(endpoints, net.JoinHostPort(host, strconv.Itoa(port)))
	}
	return endpoints
}

func catalogProbeFallbackResolver(node Node, endpoints []string) map[string]string {
	if len(node.InboundFallbackResolver) == 0 || len(endpoints) == 0 {
		return nil
	}
	hosts := make(map[string]bool, len(endpoints))
	for _, endpoint := range endpoints {
		host, _, err := net.SplitHostPort(endpoint)
		if err == nil {
			hosts[host] = true
		}
	}
	if len(hosts) == 0 {
		return nil
	}
	fallbacks := make(map[string]string)
	for host := range hosts {
		if fallback := node.InboundFallbackResolver[host]; fallback != "" && len(fallback) <= 4096 {
			fallbacks[host] = fallback
		}
	}
	if len(fallbacks) == 0 {
		return nil
	}
	return fallbacks
}
