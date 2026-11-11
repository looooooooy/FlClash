import Cocoa
import FlutterMacOS
import WebKit

private final class WeakAccountChallengeMessageHandler: NSObject, WKScriptMessageHandler {
    weak var target: WKScriptMessageHandler?

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        target?.userContentController(userContentController, didReceive: message)
    }
}

final class AccountChallengeViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    func create(withViewIdentifier viewId: Int64, arguments args: Any?) -> NSView {
        AccountChallengePlatformView(
            frame: .zero,
            messenger: messenger,
            viewId: viewId,
            arguments: args as? [String: Any] ?? [:]
        )
    }
}

private final class AccountChallengePlatformView: NSView, WKNavigationDelegate, WKScriptMessageHandler {
    private let flow: String
    private let expectedOrigin: String
    private let wrapperOrigin = "https://heysocks.invalid"
    private let channel: FlutterMethodChannel
    private let webView: WKWebView
    private let messageHandler: WeakAccountChallengeMessageHandler
    private var expiry: DispatchWorkItem?
    private var active = true

    init(frame: NSRect, messenger: FlutterBinaryMessenger, viewId: Int64, arguments: [String: Any]) {
        flow = arguments["flow"] as? String ?? ""
        let rawURL = arguments["url"] as? String ?? ""
        let url = URL(string: rawURL)
        let components = URLComponents(string: rawURL)
        let validURL = components?.scheme == "https"
            && components?.host?.isEmpty == false
            && components?.user == nil
            && components?.password == nil
            && rawURL.utf8.count <= 16384
        if validURL, let components {
            let port = components.port.flatMap { $0 == 443 ? nil : $0 }
            expectedOrigin = "https://\(components.host!.lowercased())" + (port.map { ":\($0)" } ?? "")
        } else {
            expectedOrigin = ""
        }
        channel = FlutterMethodChannel(
            name: "com.follow.clash/account-challenge/\(viewId)",
            binaryMessenger: messenger
        )

        let controller = WKUserContentController()
        let messageHandler = WeakAccountChallengeMessageHandler()
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = controller
        configuration.websiteDataStore = .nonPersistent()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        controller.add(messageHandler, name: "heysocksAccountToken")
        webView = WKWebView(frame: .zero, configuration: configuration)
        self.messageHandler = messageHandler
        super.init(frame: frame)

        messageHandler.target = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        guard validURL, let url, !flow.isEmpty else {
            DispatchQueue.main.async { [weak self] in self?.finish(method: "invalid") }
            return
        }
        loadChallenge(url: url)
        let expiry = DispatchWorkItem { [weak self] in self?.finish(method: "expired") }
        self.expiry = expiry
        DispatchQueue.main.asyncAfter(deadline: .now() + 300, execute: expiry)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func loadChallenge(url: URL) {
        let source = Self.jsonString(url.absoluteString)
        let origin = Self.jsonString(expectedOrigin)
        let html = """
        <!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1">
        <style>html,body,iframe{margin:0;width:100%;height:100%;border:0}body{background:#fff}</style>
        </head><body><iframe id="challenge" sandbox="allow-scripts allow-same-origin allow-forms"></iframe>
        <script>(()=>{const frame=document.getElementById('challenge');
        window.addEventListener('message',event=>{
          if(event.source!==frame.contentWindow||event.origin!==\(origin))return;
          try{let data=typeof event.data==='string'?JSON.parse(event.data):event.data;
            if(!data||typeof data!=='object')return;
            let value=typeof data.token==='string'?JSON.parse(data.token):data.token;
            if(value&&typeof value.cap_token==='string'&&value.cap_token.length>0&&value.cap_token.length<=16384)
              window.webkit.messageHandlers.heysocksAccountToken.postMessage(value.cap_token);
          }catch(_){ }
        });frame.src=\(source);})();</script></body></html>
        """
        webView.loadHTMLString(html, baseURL: URL(string: "\(wrapperOrigin)/verification"))
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
              url.scheme?.lowercased() == "https" else {
            decisionHandler(.cancel)
            return
        }
        if navigationAction.targetFrame?.isMainFrame == true {
            let isWrapper = url.host == "heysocks.invalid" && url.path == "/verification"
            decisionHandler(isWrapper ? .allow : .cancel)
            return
        }
        decisionHandler(navigationAction.targetFrame == nil ? .cancel : .allow)
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard active,
              message.name == "heysocksAccountToken",
              message.frameInfo.isMainFrame,
              message.frameInfo.securityOrigin.protocol == "https",
              message.frameInfo.securityOrigin.host == "heysocks.invalid",
              let token = message.body as? String,
              !token.isEmpty,
              token.utf8.count <= 16384 else { return }
        finish(method: "token", token: token)
    }

    private func finish(method: String, token: String? = nil) {
        guard active else { return }
        active = false
        expiry?.cancel()
        var arguments: [String: Any] = ["flow": flow]
        if let token { arguments["token"] = token }
        channel.invokeMethod(method, arguments: arguments)
    }

    private static func jsonString(_ value: String) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: [value]),
              let encoded = String(data: data, encoding: .utf8) else { return "\"\"" }
        return String(encoded.dropFirst().dropLast()).replacingOccurrences(of: "<", with: "\\u003c")
    }

    deinit {
        active = false
        expiry?.cancel()
        webView.stopLoading()
        webView.navigationDelegate = nil
        messageHandler.target = nil
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "heysocksAccountToken")
        channel.setMethodCallHandler(nil)
    }
}
