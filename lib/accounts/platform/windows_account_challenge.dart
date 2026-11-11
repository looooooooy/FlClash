import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/ui/ui.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:webview_flutter_windows/webview_flutter_windows.dart';

class WindowsAccountChallengeView extends StatefulWidget {
  final Uri url;
  final String flow;
  final ValueChanged<String?> onFinished;

  const WindowsAccountChallengeView({
    super.key,
    required this.url,
    required this.flow,
    required this.onFinished,
  });

  @override
  State<WindowsAccountChallengeView> createState() =>
      _WindowsAccountChallengeViewState();
}

class _WindowsAccountChallengeViewState
    extends State<WindowsAccountChallengeView> {
  static int _nextHostId = 0;

  final _controller = WebviewController();
  StreamSubscription<String>? _urls;
  Timer? _timeout;
  Timer? _poll;
  Directory? _wrapperDirectory;
  String? _wrapperUrl;
  bool _ready = false;
  bool _finished = false;
  bool _polling = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    final challenge = widget.url;
    if (widget.flow.isEmpty ||
        challenge.scheme != 'https' ||
        challenge.host.isEmpty ||
        challenge.userInfo.isNotEmpty ||
        challenge.toString().length > 16384) {
      _finish(null);
      return;
    }

    try {
      await _controller.initialize();
      if (_finished) return;
      await _controller.setDevToolsEnabled(false);
      await _controller.setZoomControlEnabled(false);
      await _controller.setDefaultContextMenusEnabled(false);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.setCacheDisabled(true);

      _urls = _controller.url.listen(_handleUrl);

      final directory = await Directory.systemTemp.createTemp(
        'heysocks-verification-',
      );
      _wrapperDirectory = directory;
      final host = 'heysocks-challenge-${++_nextHostId}.invalid';
      final wrapperUrl = 'https://$host/index.html';
      _wrapperUrl = wrapperUrl;
      await File(
        p.join(directory.path, 'index.html'),
      ).writeAsString(_wrapperHtml(challenge), flush: true);
      await _controller.addVirtualHostNameMapping(
        host,
        directory.path,
        WebviewHostResourceAccessKind.deny,
      );
      if (_finished) return;
      await _controller.loadUrl(wrapperUrl);
      if (!mounted || _finished) return;
      setState(() => _ready = true);
      _timeout = Timer(const Duration(minutes: 5), () => _finish(null));
      _poll = Timer.periodic(
        const Duration(milliseconds: 250),
        (_) => unawaited(_pollToken()),
      );
    } catch (_) {
      _finish(null);
    }
  }

  String _wrapperHtml(Uri challenge) {
    String quote(String value) => jsonEncode(value).replaceAll('<', r'\u003c');

    final source = quote(challenge.toString());
    final expectedOrigin = quote(challenge.origin);
    return '''<!doctype html>
<html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="Content-Security-Policy" content="default-src 'none'; script-src 'unsafe-inline'; style-src 'unsafe-inline'; frame-src https:;">
<style>html,body,iframe{margin:0;width:100%;height:100%;border:0}body{background:#fff}</style>
</head><body><iframe id="challenge" title="Account verification" sandbox="allow-scripts allow-same-origin allow-forms"></iframe>
<script>(()=>{const frame=document.getElementById('challenge');
window.addEventListener('message',event=>{
  if(event.source!==frame.contentWindow||event.origin!==$expectedOrigin)return;
  try{
    const data=typeof event.data==='string'?JSON.parse(event.data):event.data;
    if(!data||typeof data!=='object')return;
    const value=typeof data.token==='string'?JSON.parse(data.token):data.token;
    if(value&&typeof value.cap_token==='string'&&value.cap_token.length>0&&value.cap_token.length<=16384)
      result=value.cap_token;
  }catch(_){}
});
let result=null;
window.takeAccountToken=()=>{const value=result;result=null;return value};
frame.src=$source;
})();</script></body></html>''';
  }

  void _handleUrl(String url) {
    _currentUrl = url;
    if (_wrapperUrl != null && url.isNotEmpty && url != _wrapperUrl) {
      _finish(null);
    }
  }

  String? _currentUrl;

  Future<void> _pollToken() async {
    if (_finished || !_ready || _polling || _currentUrl != _wrapperUrl) return;
    _polling = true;
    try {
      final token = await _controller.executeScript(
        'window.takeAccountToken&&window.takeAccountToken()',
      );
      if (token is String && token.isNotEmpty && token.length <= 16384) {
        _finish(token);
      }
    } catch (_) {
      return;
    } finally {
      _polling = false;
    }
  }

  void _finish(String? token) {
    if (_finished) return;
    _finished = true;
    _timeout?.cancel();
    _poll?.cancel();
    if (mounted) widget.onFinished(token);
  }

  @override
  void dispose() {
    _finished = true;
    _timeout?.cancel();
    _poll?.cancel();
    unawaited(_urls?.cancel());
    unawaited(_controller.dispose());
    final directory = _wrapperDirectory;
    if (directory != null) {
      unawaited(directory.delete(recursive: true).then((_) {}));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ready
      ? Webview(
          _controller,
          permissionRequested: (_, _, _) async =>
              WebviewPermissionDecision.deny,
        )
      : Center(
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.appLocalizations.loading),
                const SizedBox(height: 16),
                const LinearProgressIndicator(),
              ],
            ),
          ),
        );
}
