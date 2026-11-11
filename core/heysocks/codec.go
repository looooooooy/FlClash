package heysocks

import (
	"crypto/hmac"
	"crypto/md5"
	"crypto/sha256"
	"encoding/base64"
	"encoding/binary"
	"encoding/hex"
	"encoding/json"
	"strconv"
	"strings"
	"unicode/utf8"

	"golang.org/x/crypto/chacha20poly1305"
)

const maxConfigBytes = 8 << 20

func (p protocol) sign(device string, timestamp int64) string {
	sum := md5.Sum([]byte(p.platform + p.version + device + strconv.FormatInt(timestamp, 10) + p.crypto))
	return hex.EncodeToString(sum[:])
}

func xorBytes(value []byte, key string) []byte {
	result := make([]byte, len(value))
	for i, b := range value {
		result[i] = b ^ key[i%len(key)]
	}
	return result
}

func (p protocol) encode(value []byte) string {
	return base64.StdEncoding.EncodeToString(xorBytes(value, p.public))
}

func (p protocol) decode(value string, limit int) ([]byte, error) {
	if len(value) > limit || p.private == "" {
		return nil, failure("decode", ErrLimit)
	}
	decoded, err := base64.StdEncoding.Strict().DecodeString(value)
	if err != nil {
		return nil, failure("decode", ErrProtocol)
	}
	decoded = xorBytes(decoded, p.private)
	if !utf8.Valid(decoded) {
		return nil, failure("decode", ErrProtocol)
	}
	return decoded, nil
}

func configKey(secret []byte) []byte {
	digest := func(value []byte) []byte {
		mac := hmac.New(sha256.New, []byte("VMess AEAD KDF"))
		mac.Write(value)
		return mac.Sum(nil)
	}
	path := []byte(configKDFPath)
	inner, outer := make([]byte, 64), make([]byte, 64)
	copy(inner, path)
	copy(outer, path)
	for i := range inner {
		inner[i] ^= 0x36
		outer[i] ^= 0x5c
	}
	return digest(append(outer, digest(append(inner, secret...))...))
}

func DecodeConfig(encoded string) ([]byte, error) {
	if len(encoded) > maxConfigBytes {
		return nil, failure("config_decode", ErrLimit)
	}
	raw, err := base64.StdEncoding.Strict().DecodeString(encoded)
	if err != nil || len(raw) == 0 || raw[0] < 2 || raw[0] > 15 {
		return nil, failure("config_decode", ErrProtocol)
	}
	count := int(raw[0])
	header := 1 + count*8
	if len(raw) < header {
		return nil, failure("config_decode", ErrProtocol)
	}
	body := raw[header:]
	cursor := uint64(0)
	var material, payload []byte
	for i := 0; i < count; i++ {
		start := uint64(binary.BigEndian.Uint32(raw[1+i*8:]))
		end := uint64(binary.BigEndian.Uint32(raw[5+i*8:]))
		if start < cursor || start > end || end > uint64(len(body)) || len(material)+int(end-start) > 4096 {
			return nil, failure("config_decode", ErrProtocol)
		}
		payload = append(payload, body[cursor:start]...)
		material = append(material, body[start:end]...)
		cursor = end
	}
	if cursor != uint64(len(body)) || len(material) == 0 || len(payload) < 28 {
		return nil, failure("config_decode", ErrProtocol)
	}
	secret := make([]byte, hex.DecodedLen(len(material)))
	n, err := hex.Decode(secret, material)
	if err != nil {
		return nil, failure("config_decode", ErrProtocol)
	}
	aead, err := chacha20poly1305.New(configKey(secret[:n]))
	clear(secret)
	if err != nil {
		return nil, failure("config_decode", ErrProtocol)
	}
	plain, err := aead.Open(nil, payload[:12], payload[12:], nil)
	if err != nil {
		return nil, failure("config_decode", ErrIntegrity)
	}
	return plain, nil
}

func DecodeCertificate(certificate string) (json.RawMessage, error) {
	if len(certificate) > maxConfigBytes {
		return nil, failure("certificate_decode", ErrLimit)
	}
	lines := strings.Split(strings.ReplaceAll(certificate, "\r\n", "\n"), "\n")
	if len(lines) < 4 {
		return nil, failure("certificate_decode", ErrProtocol)
	}
	plain, err := DecodeConfig(strings.Join(lines[2:len(lines)-1], ""))
	if err != nil {
		return nil, err
	}
	if !json.Valid(plain) {
		return nil, failure("certificate_decode", ErrProtocol)
	}
	return plain, nil
}
