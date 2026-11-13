import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import 'proxy_command.dart';

class MacosProxy {
  final ProxyCommandRunner _commandRunner;
  final Map<String, _MacosProxySnapshot> _snapshots = {};
  final Map<String, Set<int>> _ownedPorts = {};
  final Map<String, List<List<String>>> _ownedBypassDomains = {};
  final Future<File> Function() _snapshotFile;
  bool _loaded = false;
  bool _needsRecovery = false;

  MacosProxy({
    required ProxyCommandRunner commandRunner,
    Future<File> Function()? snapshotFile,
  }) : _commandRunner = commandRunner,
       _snapshotFile = snapshotFile ?? _defaultSnapshotFile;

  Future<bool> start(int port, List<String> bypassDomain) async {
    if (!await _loadSnapshots()) return false;
    if (_needsRecovery) {
      if (_snapshots.isNotEmpty && !await _restoreSnapshots()) return false;
      _needsRecovery = false;
    }

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
    final priorOwnedPorts = {
      for (final entry in _ownedPorts.entries) entry.key: {...entry.value},
    };
    final priorOwnedBypassDomains = {
      for (final entry in _ownedBypassDomains.entries)
        entry.key: entry.value.map(List<String>.of).toList(),
    };
    for (final service in services) {
      (_ownedPorts[service] ??= {}).add(port);
      final ownedBypasses = _ownedBypassDomains[service] ??= [];
      if (!_containsDomains(ownedBypasses, bypassDomain)) {
        ownedBypasses.add(List.of(bypassDomain));
      }
    }
    if (!await _persistSnapshots()) {
      for (final service in services) {
        if (pendingSnapshots.containsKey(service)) _snapshots.remove(service);
        final previous = priorOwnedPorts[service];
        if (previous == null) {
          _ownedPorts.remove(service);
        } else {
          _ownedPorts[service] = previous;
        }
        final previousBypasses = priorOwnedBypassDomains[service];
        if (previousBypasses == null) {
          _ownedBypassDomains.remove(service);
        } else {
          _ownedBypassDomains[service] = previousBypasses;
        }
      }
      return false;
    }

    final started = await _commandRunner.run(
      services.expand(
        (service) => MacosProxyCommands.buildStart(service, port, bypassDomain),
      ),
    );
    if (started) {
      for (final service in services) {
        _ownedPorts[service] = {port};
        _ownedBypassDomains[service] = [List.of(bypassDomain)];
      }
      if (await _persistSnapshots()) return true;
    }

    // A partial networksetup sequence must not leave some services routed
    // through YunDu while others retain their previous settings.
    await _restoreSnapshots();
    return false;
  }

  Future<bool> stop() async {
    if (!await _loadSnapshots()) return false;
    return _restoreSnapshots();
  }

  static Future<File> _defaultSnapshotFile() async {
    final home = Platform.environment['HOME'];
    if (home == null || home.isEmpty) {
      throw const FileSystemException(
        'Unable to locate the macOS home directory',
      );
    }
    return File(
      join(
        home,
        'Library',
        'Application Support',
        'FlClash',
        'system-proxy-state.json',
      ),
    );
  }

  Future<bool> _loadSnapshots() async {
    if (_loaded) return true;
    try {
      final file = await _snapshotFile();
      if (!await file.exists()) {
        _loaded = true;
        return true;
      }
      final decoded = jsonDecode(await file.readAsString());
      if (decoded is! Map<String, dynamic>) return false;
      final state = decoded;
      if (state['version'] != 1) return false;
      final services = state['services'] as Map?;
      if (services == null) return false;
      for (final entry in services.entries) {
        if (entry.key is! String || entry.value is! Map) return false;
        final serviceState = Map<String, dynamic>.from(entry.value as Map);
        final ports = serviceState.remove('ownedPorts') as List?;
        if (ports == null) return false;
        final bypasses =
            serviceState.remove('ownedBypassDomains') as List? ?? const [];
        final ownedPorts = <int>{};
        for (final value in ports) {
          if (value is! int || value < 1 || value > 65535) return false;
          ownedPorts.add(value);
        }
        final service = entry.key as String;
        final ownedBypasses = <List<String>>[];
        for (final value in bypasses) {
          if (value is! List || value.any((domain) => domain is! String)) {
            return false;
          }
          ownedBypasses.add(value.cast<String>().toList());
        }
        _ownedPorts[service] = ownedPorts;
        _ownedBypassDomains[service] = ownedBypasses;
        _snapshots[service] = _MacosProxySnapshot.fromJson(serviceState);
      }
      _needsRecovery = true;
      _loaded = true;
      return true;
    } on FileSystemException {
      return false;
    } on FormatException {
      return false;
    } on TypeError {
      return false;
    }
  }

  Future<bool> _persistSnapshots() async {
    final file = await _snapshotFile();
    if (_snapshots.isEmpty) {
      _ownedPorts.clear();
      _ownedBypassDomains.clear();
      try {
        if (await file.exists()) await file.delete();
        _loaded = true;
        return true;
      } on FileSystemException {
        return false;
      }
    }
    final temporary = File('${file.path}.tmp');
    try {
      await file.parent.create(recursive: true);
      await temporary.writeAsString(
        jsonEncode({
          'version': 1,
          'services': {
            for (final entry in _snapshots.entries)
              entry.key: {
                ...entry.value.toJson(),
                'ownedPorts': _ownedPorts[entry.key]?.toList() ?? const <int>[],
                'ownedBypassDomains':
                    _ownedBypassDomains[entry.key] ?? const <List<String>>[],
              },
          },
        }),
        flush: true,
      );
      await temporary.rename(file.path);
      _loaded = true;
      return true;
    } on FileSystemException {
      return false;
    }
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
    final services = (await _networkServices()).toSet();
    var succeeded = true;
    for (final entry in _snapshots.entries.toList().reversed) {
      if (!services.contains(entry.key)) {
        _snapshots.remove(entry.key);
        _ownedPorts.remove(entry.key);
        _ownedBypassDomains.remove(entry.key);
        succeeded = await _persistSnapshots() && succeeded;
        continue;
      }
      final current = await _capture(entry.key);
      if (current == null) {
        succeeded = false;
        continue;
      }
      final commands = _buildOwnedRestore(entry.key, entry.value, current);
      if (commands.isEmpty) {
        _snapshots.remove(entry.key);
        _ownedPorts.remove(entry.key);
        _ownedBypassDomains.remove(entry.key);
        succeeded = await _persistSnapshots() && succeeded;
        continue;
      }
      final restored = await _commandRunner.run(commands);
      if (!restored) {
        succeeded = false;
        continue;
      }
      _snapshots.remove(entry.key);
      _ownedPorts.remove(entry.key);
      _ownedBypassDomains.remove(entry.key);
      succeeded = await _persistSnapshots() && succeeded;
    }
    if (_snapshots.isEmpty) succeeded = await _persistSnapshots() && succeeded;
    return succeeded;
  }

  List<ProxyCommand> _buildOwnedRestore(
    String service,
    _MacosProxySnapshot original,
    _MacosProxySnapshot current,
  ) {
    final originals = {
      'web': original.web,
      'secure': original.secure,
      'socks': original.socks,
    };
    final currents = {
      'web': current.web,
      'secure': current.secure,
      'socks': current.socks,
    };
    final commands = <ProxyCommand>[];
    for (final (kind, setCommand, stateCommand)
        in MacosProxyCommands._proxyKinds) {
      final setting = currents[kind]!;
      final originalSetting = originals[kind]!;
      final owned =
          setting.server == proxyHost &&
          (_ownedPorts[service]?.contains(int.tryParse(setting.port)) ?? false);
      if (!owned) continue;
      commands.add(
        ProxyCommand('/usr/sbin/networksetup', [
          setCommand,
          service,
          originalSetting.server,
          originalSetting.port,
          'off',
        ]),
      );
      commands.add(
        ProxyCommand('/usr/sbin/networksetup', [
          stateCommand,
          service,
          originalSetting.enabled ? 'on' : 'off',
        ]),
      );
    }
    if (_containsDomains(
      _ownedBypassDomains[service] ?? const [],
      current.bypassDomains,
    )) {
      commands.add(
        MacosProxyCommands.buildProxyBypass(service, original.bypassDomains),
      );
    }
    return commands;
  }

  bool _containsDomains(List<List<String>> values, List<String> domains) =>
      values.any(
        (value) =>
            value.length == domains.length &&
            value.indexed.every((entry) => entry.$2 == domains[entry.$1]),
      );

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

  static _MacosProxySetting? _parseProxySetting(String output) {
    final values = <String, String>{};
    for (final line in output.split('\n')) {
      final separator = line.indexOf(':');
      if (separator < 0) continue;
      values[line.substring(0, separator).trim().toLowerCase()] = line
          .substring(separator + 1)
          .trim();
    }
    final enabled = _parseEnabled(values['enabled']);
    final authenticated = _parseEnabled(values['authenticated proxy enabled']);
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

  factory _MacosProxySnapshot.fromJson(Map<String, dynamic> json) =>
      _MacosProxySnapshot(
        web: _MacosProxySetting.fromJson(json['web']),
        secure: _MacosProxySetting.fromJson(json['secure']),
        socks: _MacosProxySetting.fromJson(json['socks']),
        bypassDomains: (json['bypassDomains'] as List).cast<String>(),
      );

  Map<String, Object> toJson() => {
    'web': web.toJson(),
    'secure': secure.toJson(),
    'socks': socks.toJson(),
    'bypassDomains': bypassDomains,
  };
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

  factory _MacosProxySetting.fromJson(Object? json) {
    if (json is! Map) throw const FormatException('Invalid proxy snapshot');
    final values = Map<String, dynamic>.from(json);
    if (values['enabled'] is! bool ||
        values['server'] is! String ||
        values['port'] is! String ||
        values['authenticated'] is! bool ||
        values['authenticated'] == true) {
      throw const FormatException('Invalid proxy snapshot');
    }
    return _MacosProxySetting(
      enabled: values['enabled'] as bool,
      server: values['server'] as String,
      port: values['port'] as String,
      authenticated: false,
    );
  }

  Map<String, Object> toJson() => {
    'enabled': enabled,
    'server': server,
    'port': port,
    'authenticated': authenticated,
  };
}
