package heysocks

// Published client interoperability parameters; these are not account credentials.
type protocol struct {
	platform, version, crypto, public, private, source string
	hosts, discovery                                   []string
}

var publishedProtocols = map[string]protocol{
	"android": {
		platform: "android", version: "551", crypto: "wdaHZso3Hr3QmBPD",
		public: "jMJaXZXGc1CbTri1UnRdvJ3izp8f0jGhXGr2jjr9nMkBKUZDoh3Avoijc4jQUw", private: "NiKNssxJcXp7Mh4yjjFGdrcFoC66wcVu5j1LgBevGCm8utV4qg089xdb20tAKu",
		source:    "{\"mvjarp\":\"official\",\"sracun\":\"official\"}",
		hosts:     []string{"https://g.just4test.xyz/api", "https://dl.playerstation.net:18638/fight", "https://20.255.60.19/c6a7b8e4d2c1a5f0b7e9d3a6c", "https://34.150.93.246:27270/master", "https://20.2.235.47:27270/master", "https://captive.iotcrate.com:27270/master"},
		discovery: []string{"https://captive.blob.core.windows.net/static/start.css", "https://stream-as.jp-osa-1.linodeobjects.com/color.vim", "https://download.asback.xyz/color.vim"},
	},
	"ios": {
		platform: "ios", version: "551", crypto: "wdaHZso3Hr3QmBPD",
		public: "jMJaXZXGc1CbTri1UnRdvJ3izp8f0jGhXGr2jjr9nMkBKUZDoh3Avoijc4jQUw", private: "NiKNssxJcXp7Mh4yjjFGdrcFoC66wcVu5j1LgBevGCm8utV4qg089xdb20tAKu",
		source:    "{\"mvjarp\":\"official\",\"sracun\":\"official\"}",
		hosts:     []string{"https://g.just4test.xyz/api", "https://dl.playerstation.net:18638/fight", "https://20.255.60.19/c6a7b8e4d2c1a5f0b7e9d3a6c", "https://34.150.93.246:27270/master", "https://20.2.235.47:27270/master", "https://captive.iotcrate.com:27270/master"},
		discovery: []string{"https://captive.blob.core.windows.net/static/start.css", "https://stream-as.jp-osa-1.linodeobjects.com/color.vim", "https://download.asback.xyz/color.vim"},
	},
	"macos": {
		platform: "macos", version: "561", crypto: "wdaHZso3Hr3QmBPD",
		public: "jMJaXZXGc1CbTri1UnRdvJ3izp8f0jGhXGr2jjr9nMkBKUZDoh3Avoijc4jQUw", private: "NiKNssxJcXp7Mh4yjjFGdrcFoC66wcVu5j1LgBevGCm8utV4qg089xdb20tAKu",
		source:    "{\"mvjarp\":\"official\",\"sracun\":\"official\"}",
		hosts:     []string{"https://g.just4test.xyz/api", "https://dl.playerstation.net:18638/fight", "https://34.150.93.246:27270/master", "https://20.2.235.47:27270/master", "https://captive.iotcrate.com:27270/master"},
		discovery: []string{"https://stream-as.jp-osa-1.linodeobjects.com/color.vim", "https://captive.blob.core.windows.net/static/start.css", "https://download.asback.xyz/color.vim"},
	},
	"windows": {
		platform: "windows", version: "561", crypto: "wdaHZso3Hr3QmBPD",
		public: "jMJaXZXGc1CbTri1UnRdvJ3izp8f0jGhXGr2jjr9nMkBKUZDoh3Avoijc4jQUw", private: "NiKNssxJcXp7Mh4yjjFGdrcFoC66wcVu5j1LgBevGCm8utV4qg089xdb20tAKu",
		source:    "{\"mvjarp\":\"official\",\"sracun\":\"official\"}",
		hosts:     []string{"https://g.just4test.xyz/api", "https://dl.playerstation.net:18638/fight", "https://34.150.93.246:27270/master", "https://20.2.235.47:27270/master", "https://captive.iotcrate.com:27270/master"},
		discovery: []string{"https://stream-as.jp-osa-1.linodeobjects.com/color.vim", "https://captive.blob.core.windows.net/static/start.css", "https://download.asback.xyz/color.vim"},
	},
	"linux": {
		platform: "linux", version: "561", crypto: "wdaHZso3Hr3QmBPD",
		public: "jMJaXZXGc1CbTri1UnRdvJ3izp8f0jGhXGr2jjr9nMkBKUZDoh3Avoijc4jQUw", private: "NiKNssxJcXp7Mh4yjjFGdrcFoC66wcVu5j1LgBevGCm8utV4qg089xdb20tAKu",
		source:    "{\"mvjarp\":\"official\",\"sracun\":\"official\"}",
		hosts:     []string{"https://g.just4test.xyz/api", "https://dl.playerstation.net:18638/fight", "https://34.150.93.246:27270/master", "https://20.2.235.47:27270/master", "https://captive.iotcrate.com:27270/master"},
		discovery: []string{"https://stream-as.jp-osa-1.linodeobjects.com/color.vim", "https://captive.blob.core.windows.net/static/start.css", "https://download.asback.xyz/color.vim"},
	},
}

const configKDFPath = "CHACHA 20 POLY 1305"
