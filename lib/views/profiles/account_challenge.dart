import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/platform/windows_account_challenge.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/ui/ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AccountChallengeView extends StatefulWidget {
  final AccountChallenge challenge;
  const AccountChallengeView({super.key, required this.challenge});

  @override
  State<AccountChallengeView> createState() => _AccountChallengeViewState();
}

class _AccountChallengeViewState extends State<AccountChallengeView> {
  MethodChannel? _channel;
  bool _finished = false;

  void _created(int id) {
    final channel = MethodChannel('com.follow.clash/account-challenge/$id');
    _channel = channel;
    channel.setMethodCallHandler((call) async {
      if (!mounted || _finished) return;
      final args = call.arguments;
      if (args is! Map || args['flow'] != widget.challenge.id) return;
      if (call.method == 'token') {
        final token = args['token'];
        if (token is! String || token.isEmpty || token.length > 16384) return;
        _finished = true;
        Navigator.of(context).pop(token);
      } else if (call.method == 'expired' || call.method == 'invalid') {
        _finished = true;
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _finished = true;
    _channel?.setMethodCallHandler(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.challenge.url;
    final valid =
        url.scheme == 'https' && url.host.isNotEmpty && url.userInfo.isEmpty;
    return Scaffold(
      title: context.appLocalizations.heysocksVerification,
      body: !valid
          ? Center(child: Text(context.appLocalizations.heysocksError))
          : system.isAndroid
          ? AndroidView(
              viewType: 'com.follow.clash/account-challenge',
              creationParams: {
                'flow': widget.challenge.id,
                'url': url.toString(),
              },
              creationParamsCodec: const StandardMessageCodec(),
              onPlatformViewCreated: _created,
            )
          : system.isMacOS
          ? AppKitView(
              viewType: 'com.follow.clash/account-challenge/macos',
              creationParams: {
                'flow': widget.challenge.id,
                'url': url.toString(),
              },
              creationParamsCodec: const StandardMessageCodec(),
              onPlatformViewCreated: _created,
            )
          : system.isWindows
          ? WindowsAccountChallengeView(
              url: url,
              flow: widget.challenge.id,
              onFinished: (token) {
                if (!mounted || _finished) return;
                _finished = true;
                Navigator.of(context).pop(token);
              },
            )
          : Center(child: Text(context.appLocalizations.heysocksError)),
    );
  }
}
