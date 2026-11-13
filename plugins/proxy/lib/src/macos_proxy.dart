import 'dart:async';
import 'dart:io';

import 'proxy_command.dart';

class MacosProxy {
  final ProxyCommandRunner _commandRunner;
  final Map<String, _MacosProxySnapshot> _snapshots = {};

  MacosProxy({required ProxyCommandRunner commandRunner})
    : _commandRunner = commandRunner;

  Future<bool> start(int port, List<String> bypassDomain) async {
    final services = await _networkServices();
    if (services.isEmpty) return false;

    // Capture every service before changing any of them. networksetup does
    // not expose an existing authenticated proxy password, so refuse to
    // replace one whose original settings could not be restored exactly.
    final pendingSnapshots = <String, _MacosProxySnapshot>{};
    for (final service in services) {
      if (_snapshots.containsKey(service)) continue;
      final snapshot = await _capture(service);
      if (snapshot == null) return false;
      pendingSnapshots[service] = snapshot;
    }
    _snapshots.addAll(pendingSnapshots);

    final started = await _commandRunner.run(
      services.expand(
        (service) => MacosProxyCommands.buildStart(
          service,
          port,
          bypassDomain,
        ),
      ),
    );
    if (started) return true;

    // A partial networksetup sequence must not leave some services routed
    // through YunDu while others retain their previous settings.
    await _restoreSnapshots();
    return false;
  }

  Future<bool> stop() async {
    return _restoreSnapshots();
  }

  Future<_MacosProxySnapshot?> _capture(String service) async {
    final web = await _readProxySetting('-getwebproxy', service);
    final secure = await _readProxySetting('-getsecurewebproxy', service);
    final socks = await _readProxySetting('-getsocksfirewallproxy', service);
    late final ProcessResult bypass;
    try {
      bypass = await _commandRunner.process('/usr/sbin/networksetup', [
        '-getproxybypassdomains',
        service,
      ]);
    } on ProcessException {
      return null;
    } on TimeoutException {
      return null;
    }
    if (web == null ||
        secure == null ||
        socks == null ||
        bypass.exitCode != 0 ||
        web.authenticated ||
        secure.authenticated ||
        socks.authenticated) {
      return null;
    }
    final bypassDomains = bypass.stdout
        .toString()
        .split('\n')
        .map((line) => line.trim())
        .where(
          (line) =>
              line.isNotEmpty &&
              !line.startsWith("There aren't any bypass domains set"),
        )
        .toList();
    return _MacosProxySnapshot(
      web: web,
      secure: secure,
      socks: socks,
      bypassDomains: bypassDomains,
    );
  }

  Future<_MacosProxySetting?> _readProxySetting(
    String command,
    String service,
  ) async {
    try {
      final result = await _commandRunner.process('/usr/sbin/networksetup', [
        command,
        service,
      ]);
      if (result.exitCode != 0) return null;
      return MacosProxyCommands._parseProxySetting(result.stdout.toString());
    } on ProcessException {
      return null;
    } on TimeoutException {
      return null;
    }
  }

  Future<bool> _restoreSnapshots() async {
    if (_snapshots.isEmpty) return true;
    var succeeded = true;
    for (final entry in _snapshots.entries.toList().reversed) {
      for (final command in MacosProxyCommands._buildRestore(
        entry.key,
        entry.value,
      )) {
        final restored = await _commandRunner.run([command]);
        succeeded = restored && succeeded;
      }
    }
    if (succeeded) _snapshots.clear();
    return succeeded;
  }

  Future<List<String>> _networkServices() async {
    try {
      final result = await _commandRunner.process('/usr/sbin/networksetup', [
        '-listallnetworkservices',
      ]);
      if (result.exitCode != 0) {
        return [];
      }
      return MacosProxyCommands.parseNetworkServices(result.stdout.toString());
    } on ProcessException {
      return [];
    } on TimeoutException {
      return [];
    }
  }
}

class MacosProxyCommands {
  static const _proxyKinds = [
    ('web', '-setwebproxy', '-setwebproxystate'),
    ('secure', '-setsecurewebproxy', '-setsecurewebproxystate'),
    ('socks', '-setsocksfirewallproxy', '-setsocksfirewallproxystate'),
  ];

  static List<ProxyCommand> buildStart(
    String service,
    int port,
    List<String> bypassDomain,
  ) {
    return [
      ProxyCommand('/usr/sbin/networksetup', [
        '-setwebproxy',
        service,
        proxyHost,
        '$port',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsecurewebproxy',
        service,
        proxyHost,
        '$port',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsocksfirewallproxy',
        service,
        proxyHost,
        '$port',
      ]),
      buildProxyBypass(service, bypassDomain),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setwebproxystate',
        service,
        'on',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsecurewebproxystate',
        service,
        'on',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsocksfirewallproxystate',
        service,
        'on',
      ]),
    ];
  }

  static List<ProxyCommand> buildStop(String service) {
    return [
      ProxyCommand('/usr/sbin/networksetup', [
        '-setwebproxystate',
        service,
        'off',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsecurewebproxystate',
        service,
        'off',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsocksfirewallproxystate',
        service,
        'off',
      ]),
    ];
  }

  static List<ProxyCommand> _buildRestore(
    String service,
    _MacosProxySnapshot snapshot,
  ) {
    final settings = {
      'web': snapshot.web,
      'secure': snapshot.secure,
      'socks': snapshot.socks,
    };
    return [
      for (final (kind, setCommand, _) in _proxyKinds)
        ProxyCommand('/usr/sbin/networksetup', [
          setCommand,
          service,
          settings[kind]!.server,
          settings[kind]!.port,
          'off',
        ]),
      buildProxyBypass(service, snapshot.bypassDomains),
      for (final (kind, _, stateCommand) in _proxyKinds)
        ProxyCommand('/usr/sbin/networksetup', [
          stateCommand,
          service,
          settings[kind]!.enabled ? 'on' : 'off',
        ]),
    ];
  }

  static _MacosProxySetting? _parseProxySetting(String output) {
    final values = <String, String>{};
    for (final line in output.split('\n')) {
      final separator = line.indexOf(':');
      if (separator < 0) continue;
      values[line.substring(0, separator).trim().toLowerCase()] =
          line.substring(separator + 1).trim();
    }
    final enabled = _parseEnabled(values['enabled']);
    final authenticated = _parseEnabled(
      values['authenticated proxy enabled'],
    );
    final server = values['server'];
    final port = values['port'];
    if (enabled == null ||
        authenticated == null ||
        server == null ||
        port == null) {
      return null;
    }
    return _MacosProxySetting(
      enabled: enabled,
      server: server,
      port: port,
      authenticated: authenticated,
    );
  }

  static bool? _parseEnabled(String? value) => switch (value?.toLowerCase()) {
    'yes' || 'on' || '1' => true,
    'no' || 'off' || '0' => false,
    _ => null,
  };

  static ProxyCommand buildProxyBypass(
    String service,
    List<String> bypassDomain,
  ) {
    return ProxyCommand('/usr/sbin/networksetup', [
      '-setproxybypassdomains',
      service,
      if (bypassDomain.isEmpty) 'Empty' else ...bypassDomain,
    ]);
  }

  static List<String> parseNetworkServices(String stdout) {
    return stdout
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .where((line) => !line.startsWith('*'))
        .where((line) => !line.startsWith('An asterisk '))
        .toList();
  }
}

class _MacosProxySnapshot {
  const _MacosProxySnapshot({
    required this.web,
    required this.secure,
    required this.socks,
    required this.bypassDomains,
  });

  final _MacosProxySetting web;
  final _MacosProxySetting secure;
  final _MacosProxySetting socks;
  final List<String> bypassDomains;
}

class _MacosProxySetting {
  const _MacosProxySetting({
    required this.enabled,
    required this.server,
    required this.port,
    required this.authenticated,
  });

  final bool enabled;
  final String server;
  final String port;
  final bool authenticated;
}
