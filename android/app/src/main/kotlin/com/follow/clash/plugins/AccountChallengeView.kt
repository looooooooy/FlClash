package com.follow.clash.plugins

import android.annotation.SuppressLint
import android.content.Context
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.view.View
import android.webkit.WebResourceRequest
import android.webkit.WebResourceResponse
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.json.JSONObject
import org.json.JSONTokener
import java.io.ByteArrayInputStream

class AccountChallengeFactory(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView =
        AccountChallengeView(context, messenger, viewId, args as? Map<*, *> ?: emptyMap<Any, Any>())
}

@SuppressLint("SetJavaScriptEnabled")
private class AccountChallengeView(
    context: Context,
    messenger: BinaryMessenger,
    viewId: Int,
    args: Map<*, *>,
) : PlatformView {
    private val web = WebView(context)
    private val channel = MethodChannel(messenger, "com.follow.clash/account-challenge/$viewId")
    private val handler = Handler(Looper.getMainLooper())
    private val flow = args["flow"] as? String ?: ""
    private var active = true
    private val wrapper = "https://heysocks.invalid/verification"
    private val poll = object : Runnable {
        override fun run() {
            if (!active) return
            web.evaluateJavascript("window.takeAccountToken && window.takeAccountToken()") { encoded ->
                if (!active) return@evaluateJavascript
                val token = try { JSONTokener(encoded).nextValue() as? String } catch (_: Exception) { null }
                if (!token.isNullOrBlank() && token.length <= 16384) {
                    active = false
                    channel.invokeMethod("token", mapOf("flow" to flow, "token" to token))
                } else {
                    handler.postDelayed(this, 250)
                }
            }
        }
    }

    init {
        val raw = args["url"] as? String ?: ""
        val uri = Uri.parse(raw)
        val valid = uri.scheme == "https" && !uri.host.isNullOrBlank() &&
            uri.userInfo == null && flow.isNotBlank() && raw.length <= 16384
        web.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            allowFileAccess = false
            allowContentAccess = false
            mixedContentMode = WebSettings.MIXED_CONTENT_NEVER_ALLOW
            javaScriptCanOpenWindowsAutomatically = false
            setSupportMultipleWindows(false)
            cacheMode = WebSettings.LOAD_NO_CACHE
        }
        web.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean =
                request.isForMainFrame || request.url.scheme != "https"

            override fun shouldInterceptRequest(view: WebView, request: WebResourceRequest): WebResourceResponse? =
                if (request.url.scheme == "https") null else
                    WebResourceResponse("text/plain", "utf-8", ByteArrayInputStream(ByteArray(0)))
        }
        if (valid) {
            val origin = Uri.Builder().scheme("https").encodedAuthority(uri.encodedAuthority).build().toString()
            val source = JSONObject.quote(raw).replace("<", "\\u003c")
            val expected = JSONObject.quote(origin).replace("<", "\\u003c")
            val html = """
                <!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1">
                <style>html,body,iframe{margin:0;width:100%;height:100%;border:0}body{background:#fff}</style>
                </head><body><iframe id="challenge" sandbox="allow-scripts allow-same-origin allow-forms"></iframe>
                <script>
                (()=>{const frame=document.getElementById('challenge');let result=null;
                window.takeAccountToken=()=>{const value=result;result=null;return value};
                window.addEventListener('message',event=>{
                  if(event.source!==frame.contentWindow||event.origin!==$expected)return;
                  try{let data=typeof event.data==='string'?JSON.parse(event.data):event.data;
                    if(!data||typeof data!=='object')return;
                    let value=typeof data.token==='string'?JSON.parse(data.token):data.token;
                    if(value&&typeof value.cap_token==='string'&&value.cap_token.length<=16384)result=value.cap_token;
                  }catch(_){}
                });frame.src=$source;})();
                </script></body></html>
            """.trimIndent()
            web.loadDataWithBaseURL(wrapper, html, "text/html", "UTF-8", null)
            handler.post(poll)
            handler.postDelayed({
                if (active) {
                    active = false
                    channel.invokeMethod("expired", mapOf("flow" to flow))
                }
            }, 300000)
        } else {
            handler.post { channel.invokeMethod("invalid", mapOf("flow" to flow)) }
        }
    }

    override fun getView(): View = web

    override fun dispose() {
        active = false
        handler.removeCallbacksAndMessages(null)
        channel.setMethodCallHandler(null)
        web.stopLoading()
        web.loadUrl("about:blank")
        web.clearHistory()
        web.destroy()
    }
}
