import 'dart:async';

import 'package:fl_clash/models/profile.dart';
import 'package:flutter/foundation.dart';

import 'models.dart';
import 'service.dart';

const managedRoot = 'HeySocks';
const managedRoutingRules = [
  'DOMAIN-SUFFIX,local,DIRECT',
  'DOMAIN-SUFFIX,lan,DIRECT',
  'GEOIP,LAN,DIRECT,no-resolve',
  'GEOSITE,cn,DIRECT',
  'GEOIP,CN,DIRECT',
  'MATCH,$managedRoot',
];

Map<String, dynamic> withManagedRouting(Map<String, dynamic> config) => {
  ...config,
  'rules': managedRoutingRules,
};
const managedCatalogAge = Duration(minutes: 30);
const managedTargetAge = Duration(minutes: 5);
const managedFullAge = Duration(hours: 12);

class ManagedSyncStatus {
  final bool syncing;
  final int total;
  final int completed;
  final int ready;
  final int unsupported;
  final int failed;
  final String? failure;
  const ManagedSyncStatus({
    this.syncing = false,
    this.total = 0,
    this.completed = 0,
    this.ready = 0,
    this.unsupported = 0,
    this.failed = 0,
    this.failure,
  });
}

typedef ManagedPublication = ({
  Map<String, dynamic> config,
  List<AccountNodeConfig> cache,
  ManagedProfileInfo info,
  Map<String, String> selections,
});

abstract interface class ManagedProfileRepository {
  Profile? get profile;
  bool get globalMode;
  AccountConfigOptions get options;
  Future<List<AccountNodeConfig>> readCache();
  Future<void> publish(ManagedPublication value, bool Function() isCurrent);
  Future<void> clear();
  Future<void> stop();
  Future<void> apply();
}

class ManagedAccount {
  final AccountService service;
  final ManagedProfileRepository repository;
  final DateTime Function() now;
  final Future<void> Function(Duration) delay;
  final ValueNotifier<ManagedSyncStatus> status = ValueNotifier(
    const ManagedSyncStatus(),
  );
  Map<String, AccountNodeConfig> _configs = {};
  Map<String, AccountNode> _nodes = {};
  Map<String, List<String>> _groups = {};
  Future<void>? _sync;
  Future<void>? _firstPublication;
  Future<void> _publications = Future.value();
  Future<void> _work = Future.value();
  int _generation = 0;
  int? _accountGeneration;
  bool _authenticated = false;
  bool _disposed = false;
  bool _cacheLoaded = false;
  bool _runningFull = false;
  bool _fullRequested = false;

  ManagedAccount({
    required this.service,
    required this.repository,
    DateTime Function()? now,
    Future<void> Function(Duration)? delay,
  }) : now = now ?? DateTime.now,
       delay = delay ?? Future<void>.delayed {
    service.status.addListener(_accountChanged);
    service.clearOwnedResources = clear;
    _accountChanged();
  }

  void _accountChanged() {
    final account = service.status.value.state;
    if (_authenticated &&
        (!account.authenticated || _accountGeneration != account.generation)) {
      _generation++;
      _nodes = {};
      _configs = {};
      _groups = {};
      _cacheLoaded = false;
      if (!account.authenticated) {
        unawaited(repository.stop().catchError((Object _) {}));
      }
    }
    _authenticated = account.authenticated;
    _accountGeneration = account.generation;
  }

  bool _current(int generation) =>
      !_disposed &&
      generation == _generation &&
      service.status.value.state.authenticated;

  void _check(int generation) {
    if (!_current(generation)) throw const AccountFailure('superseded');
  }

  Future<void> _serialized(Future<void> Function() work) {
    final result = _publications.then((_) => work());
    _publications = result.then<void>((_) {}, onError: (_) {});
    return result;
  }

  Future<void> clear() {
    _generation++;
    _sync = null;
    _firstPublication = null;
    _configs = {};
    _groups = {};
    _nodes = {};
    _cacheLoaded = false;
    status.value = const ManagedSyncStatus();
    return _serialized(() async {
      await repository.stop();
      await repository.clear();
    });
  }

  Future<void> _restoreCache(int generation) async {
    if (_cacheLoaded) return;
    final cached = await repository.readCache();
    _check(generation);
    _configs = {for (final config in cached) config.node.stableId: config};
    _nodes = {for (final config in cached) config.node.stableId: config.node};
    if (cached.isNotEmpty) {
      final built = await service.buildProfile(cached);
      _check(generation);
      _groups = _groupMembers(built.toPrivateJson());
    }
    _cacheLoaded = true;
  }

  Future<void> refreshIfStale() async {
    if (repository.profile == null) return;
    await service.initialize();
    if (!service.status.value.state.authenticated ||
        repository.profile == null) {
      return;
    }
    final info = repository.profile?.managed;
    if (_stale(info?.catalogAt, managedCatalogAge) ||
        _stale(info?.fullRefreshAt, managedFullAge)) {
      await sync(full: _stale(info?.fullRefreshAt, managedFullAge));
    }
  }

  bool _stale(DateTime? time, Duration age) =>
      time == null || now().difference(time) >= age || time.isAfter(now());

  Future<void> _runWork(Future<void> Function() operation) {
    final result = _work.then((_) => operation());
    _work = result.then<void>((_) {}, onError: (_) {});
    return result;
  }

  Future<void> sync({bool full = true}) {
    if (full && !_runningFull) _fullRequested = true;
    if (_sync case final active?) return active;
    final generation = _generation;
    late final Future<void> operation;
    operation =
        _runWork(() async {
          await service.initialize();
          do {
            _check(generation);
            final refreshAll = _fullRequested;
            _fullRequested = false;
            _runningFull = refreshAll;
            await _synchronize(full: refreshAll);
          } while (_fullRequested);
        }).whenComplete(() {
          _runningFull = false;
          if (identical(_sync, operation)) {
            _sync = null;
            _firstPublication = null;
          }
        });
    return _sync = operation;
  }

  Future<void> _synchronize({required bool full}) async {
    await service.initialize();
    if (!service.status.value.state.authenticated) {
      throw const AccountFailure('unauthenticated');
    }
    final generation = _generation;
    try {
      await _restoreCache(generation);
      status.value = const ManagedSyncStatus(syncing: true);
      final catalog = await service.catalog(isp: repository.options.isp);
      _check(generation);
      final nodes = {for (final node in catalog.nodes) node.stableId: node};
      final configs = Map<String, AccountNodeConfig>.of(_configs)
        ..removeWhere((key, _) => !nodes.containsKey(key));
      final checked = Map<String, DateTime>.of(
        repository.profile?.managed?.checkedAt ?? {},
      )..removeWhere((key, _) => !nodes.containsKey(key));
      final targets = nodes.values
          .where((node) => full || !configs.containsKey(node.stableId))
          .toList();
      final firstSync = repository.profile == null;
      var cursor = 0;
      var completed = 0;
      var ready = 0;
      var unsupported = 0;
      var failed = 0;
      Future<void> worker() async {
        while (cursor < targets.length) {
          _check(generation);
          final node = targets[cursor++];
          try {
            final config = await _fetch(node, generation);
            _check(generation);
            checked[node.stableId] = now();
            if (config.usable) {
              configs[node.stableId] = config;
              ready++;
            } else {
              configs.remove(node.stableId);
              unsupported++;
            }
          } on AccountFailure catch (error) {
            _check(generation);
            if (_abortsRefresh(error)) {
              rethrow;
            }
            if (!_transientFailure(error)) {
              configs.remove(node.stableId);
              checked.remove(node.stableId);
            }
            failed++;
          }
          _check(generation);
          completed++;
          status.value = ManagedSyncStatus(
            syncing: true,
            total: targets.length,
            completed: completed,
            ready: ready,
            unsupported: unsupported,
            failed: failed,
          );
          if (firstSync &&
              configs.isNotEmpty &&
              completed < targets.length &&
              _firstPublication == null) {
            _nodes = nodes;
            final publication = _publish(
              Map.of(configs),
              Map.of(checked),
              generation,
              catalogAt: now(),
            );
            _firstPublication = publication;
            await publication;
          }
          if (cursor < targets.length) {
            await delay(const Duration(milliseconds: 180));
          }
        }
      }

      await Future.wait([worker(), worker()]);
      _check(generation);
      _nodes = nodes;
      if (configs.isEmpty) {
        if (_configs.isNotEmpty) {
          await _serialized(() async {
            _check(generation);
            await repository.stop();
            await repository.publish((
              config: {
                'proxies': <Object>[],
                'proxy-groups': [
                  {
                    'name': managedRoot,
                    'type': 'select',
                    'proxies': ['REJECT'],
                  },
                ],
                'rules': managedRoutingRules,
              },
              cache: [],
              info: ManagedProfileInfo(
                catalogAt: now(),
                selectionRequired: true,
                requiresLogin: false,
              ),
              selections: {'GLOBAL': managedRoot, managedRoot: 'REJECT'},
            ), () => _current(generation));
            _configs = {};
          });
        }
        throw const AccountFailure('unavailable');
      }
      await _publish(
        configs,
        checked,
        generation,
        catalogAt: now(),
        fullAt: full && failed == 0
            ? now()
            : repository.profile?.managed?.fullRefreshAt,
      );
      _check(generation);
      status.value = ManagedSyncStatus(
        total: targets.length,
        completed: completed,
        ready: ready,
        unsupported: unsupported,
        failed: failed,
      );
    } catch (error) {
      if (_current(generation)) {
        final previous = status.value;
        status.value = ManagedSyncStatus(
          total: previous.total,
          completed: previous.completed,
          ready: previous.ready,
          unsupported: previous.unsupported,
          failed: previous.failed,
          failure: accountFailureKind(error),
        );
      }
      rethrow;
    }
  }

  Future<AccountNodeConfig> _fetch(AccountNode node, int generation) async {
    for (var attempt = 0; ; attempt++) {
      try {
        return await service.config(node, repository.options);
      } on AccountFailure catch (error) {
        _check(generation);
        if (attempt >= 1 || !_transientFailure(error)) {
          rethrow;
        }
        await delay(const Duration(seconds: 1));
        _check(generation);
      }
    }
  }

  Future<void> ensureUsable({
    String? group,
    String? target,
    bool? globalMode,
  }) async {
    await service.initialize();
    if (!service.status.value.state.authenticated ||
        repository.profile?.managed?.requiresLogin == true) {
      throw const AccountFailure('unauthenticated');
    }
    final generation = _generation;
    final explicitSelection = group != null && target != null;
    // The first sync can keep checking the rest of the catalog after a
    // validated config is visible. Fresh lines need no work on that queue.
    if (_firstPublication case final publication?) {
      await publication;
      if (await _ensureTarget(
        generation,
        group: group,
        target: target,
        globalMode: globalMode,
        freshOnly: true,
      )) {
        return;
      }
    }
    await _restoreCache(generation);
    var catalogRefreshUnavailable = false;
    if (_configs.isEmpty) {
      await sync();
    } else {
      try {
        await refreshIfStale();
      } on AccountFailure catch (error) {
        if (!explicitSelection || !_transientFailure(error)) rethrow;
        // Keep an explicit switch responsive while the account service is
        // unreachable; the cached target is still checked below.
        catalogRefreshUnavailable = true;
      }
    }
    _check(generation);
    if (_sync != null) {
      try {
        await _sync;
      } on AccountFailure catch (error) {
        if (!explicitSelection || !_transientFailure(error)) rethrow;
        catalogRefreshUnavailable = true;
      }
    }
    await _runWork(() async {
      await _ensureTarget(
        generation,
        group: group,
        target: target,
        globalMode: globalMode,
        allowCachedOnTransientFailure: explicitSelection,
        skipTargetRefresh: catalogRefreshUnavailable,
      );
    });
  }

  Future<bool> _ensureTarget(
    int generation, {
    String? group,
    String? target,
    bool? globalMode,
    bool freshOnly = false,
    bool allowCachedOnTransientFailure = false,
    bool skipTargetRefresh = false,
  }) async {
    _check(generation);
    final profile = repository.profile;
    if (profile == null) throw const AccountFailure('unauthenticated');
    final selection = {
      ...profile.selectedMap,
      if (group != null && target != null) group: target,
    };
    final info = profile.managed!;
    final useGlobal = globalMode ?? repository.globalMode;
    var current = group ?? (useGlobal ? 'GLOBAL' : managedRoot);
    final visited = <String>{};
    while (current == 'GLOBAL' || _groups.containsKey(current)) {
      if (!visited.add(current)) {
        throw const AccountFailure('selection_required');
      }
      final next =
          selection[current] ?? (current == 'GLOBAL' ? managedRoot : null);
      if (next == null || next == 'REJECT') {
        // A removed line can be recovered by choosing its country, then line.
        if (target == current && info.countryNames.containsValue(target)) {
          return true;
        }
        throw const AccountFailure('selection_required');
      }
      if (current != 'GLOBAL' && !_groups[current]!.contains(next)) {
        throw const AccountFailure('selection_required');
      }
      current = next;
    }
    if (current == 'DIRECT' && (group == 'GLOBAL' || useGlobal)) {
      return true;
    }
    final entry = info.lineNames.entries
        .where(
          (entry) =>
              entry.value == current ||
              (_groups[entry.value]?.contains(current) ?? false),
        )
        .firstOrNull;
    if (entry == null || !_nodes.containsKey(entry.key)) {
      throw const AccountFailure('selection_required');
    }
    if (_stale(info.checkedAt[entry.key], managedTargetAge)) {
      if (freshOnly) return false;
      final cached = _configs[entry.key];
      if (skipTargetRefresh && cached?.usable == true) return true;
      final node = _nodes[entry.key]!;
      late final AccountNodeConfig config;
      try {
        config = await _fetch(node, generation);
        _check(generation);
        if (!config.usable) throw const AccountFailure('selection_required');
      } on AccountFailure catch (error) {
        _check(generation);
        if (_abortsRefresh(error)) rethrow;
        if (allowCachedOnTransientFailure &&
            _transientFailure(error) &&
            cached?.usable == true) {
          return true;
        }
        if (!_transientFailure(error)) {
          final remaining = Map<String, AccountNodeConfig>.of(_configs)
            ..remove(entry.key);
          final checked = Map<String, DateTime>.of(info.checkedAt)
            ..remove(entry.key);
          if (remaining.isNotEmpty) {
            await _publish(
              remaining,
              checked,
              generation,
              catalogAt: info.catalogAt,
              fullAt: info.fullRefreshAt,
            );
          } else {
            await _serialized(() async {
              _check(generation);
              await repository.stop();
              await repository.publish((
                config: {
                  'proxies': <Object>[],
                  'proxy-groups': [
                    {
                      'name': managedRoot,
                      'type': 'select',
                      'proxies': ['REJECT'],
                    },
                  ],
                  'rules': managedRoutingRules,
                },
                cache: [],
                info: ManagedProfileInfo(
                  catalogAt: info.catalogAt,
                  selectionRequired: true,
                  requiresLogin: false,
                ),
                selections: {'GLOBAL': managedRoot, managedRoot: 'REJECT'},
              ), () => _current(generation));
              _configs = {};
            });
          }
        }
        rethrow;
      }
      await _publish(
        {..._configs, entry.key: config},
        {...info.checkedAt, entry.key: now()},
        generation,
        catalogAt: info.catalogAt,
        fullAt: info.fullRefreshAt,
      );
      // A fresh config can remove an individual connection within a line.
      return _ensureTarget(
        generation,
        group: group,
        target: target,
        globalMode: globalMode,
        allowCachedOnTransientFailure: allowCachedOnTransientFailure,
        skipTargetRefresh: skipTargetRefresh,
      );
    }
    _check(generation);
    return true;
  }

  Future<void> _publish(
    Map<String, AccountNodeConfig> configs,
    Map<String, DateTime> checked,
    int generation, {
    DateTime? catalogAt,
    DateTime? fullAt,
  }) async {
    final built = await service.buildProfile(configs.values.toList());
    _check(generation);
    final payload = built.toPrivateJson();
    final groups = (payload['proxy-groups'] as List).map(accountMap).toList();
    final root = groups.firstWhere((group) => group['name'] == managedRoot);
    final countryNames = <String, String>{};
    final lineNames = <String, String>{};
    final ordered = configs.values.toList()
      ..sort((a, b) {
        final country = a.node.countryCode.compareTo(b.node.countryCode);
        return country != 0
            ? country
            : a.node.stableId.compareTo(b.node.stableId);
      });
    final codes = ordered.map((c) => c.node.countryCode).toSet().toList()
      ..sort();
    final countryGroups = (root['proxies'] as List).cast<String>();
    for (var i = 0; i < codes.length; i++) {
      final name = countryGroups[i];
      countryNames[codes[i]] = name;
      final lines =
          (groups.firstWhere((g) => g['name'] == name)['proxies'] as List)
              .cast<String>();
      final nodes = ordered
          .where((c) => c.node.countryCode == codes[i])
          .toList();
      for (var j = 0; j < nodes.length; j++) {
        lineNames[nodes[j].node.stableId] = lines[j];
      }
    }
    await _serialized(() async {
      _check(generation);
      final previous = repository.profile;
      final selection = preserveManagedSelection(
        previous,
        countryNames,
        lineNames,
        groups,
      );
      final selectionRequired = managedSelectionRequired(
        selection,
        globalMode: repository.globalMode,
      );
      if (selectionRequired) await repository.stop();
      _check(generation);
      for (final group in groups) {
        if (selection[group['name']] == 'REJECT') {
          group['proxies'] = ['REJECT', ...group['proxies'] as List];
        }
      }
      await repository.publish((
        config: {
          'proxies': payload['proxies'],
          'proxy-groups': groups,
          'rules': managedRoutingRules,
        },
        cache: configs.values.toList(),
        info: ManagedProfileInfo(
          catalogAt: catalogAt,
          fullRefreshAt: fullAt,
          lineNames: lineNames,
          countryNames: countryNames,
          checkedAt: checked,
          selectionRequired: selectionRequired,
          requiresLogin: false,
        ),
        selections: selection,
      ), () => _current(generation));
      _check(generation);
      _configs = configs;
      _groups = _groupMembers(payload);
    });
  }

  void dispose() {
    _disposed = true;
    _generation++;
    service.status.removeListener(_accountChanged);
    if (service.clearOwnedResources == clear) {
      service.clearOwnedResources = null;
    }
    status.dispose();
  }
}

bool _abortsRefresh(AccountFailure error) => const {
  'canceled',
  'superseded',
  'unauthenticated',
  'authentication_required',
}.contains(error.kind);

bool _transientFailure(AccountFailure error) {
  if (const {
    'network',
    'network_unavailable',
    'transport_unavailable',
    'timeout',
    'rate_limited',
    'operation_in_progress',
  }.contains(error.kind)) {
    return true;
  }
  final status = error.httpStatus;
  return error.kind == 'request_rejected' &&
      status != null &&
      (status == 408 || status == 429 || (status >= 500 && status < 600));
}

Map<String, List<String>> _groupMembers(Map<String, dynamic> payload) => {
  for (final group in (payload['proxy-groups'] as List).map(accountMap))
    group['name'] as String: (group['proxies'] as List).cast<String>(),
};

bool managedSelectionRequired(
  Map<String, String> selection, {
  required bool globalMode,
}) {
  var current = globalMode ? 'GLOBAL' : managedRoot;
  final visited = <String>{};
  while (selection.containsKey(current)) {
    if (!visited.add(current)) return true;
    current = selection[current]!;
    if (current == 'REJECT') return true;
  }
  return current == 'GLOBAL' || current == managedRoot;
}

String accountFailureKind(Object error) => error is AccountFailure
    ? error.kind
    : error is AccountChallengeRequired
    ? 'captcha_required'
    : 'account_unavailable';

Map<String, String> preserveManagedSelection(
  Profile? previous,
  Map<String, String> countries,
  Map<String, String> lines,
  List<Map<String, dynamic>> groups,
) {
  final previousInfo = previous?.managed;
  final rename = <String, String>{
    for (final entry in countries.entries)
      ?previousInfo?.countryNames[entry.key]: entry.value,
    for (final entry in lines.entries)
      ?previousInfo?.lineNames[entry.key]: entry.value,
  };
  final selections = <String, String>{'GLOBAL': managedRoot};
  for (final group in groups) {
    final name = group['name'] as String;
    final members = (group['proxies'] as List).cast<String>();
    final oldName =
        rename.entries.where((e) => e.value == name).firstOrNull?.key ?? name;
    final old = previous?.selectedMap[oldName];
    final next = rename[old] ?? old;
    selections[name] = next == null
        ? members.first
        : members.contains(next)
        ? next
        : 'REJECT';
  }
  if (previous?.selectedMap['GLOBAL'] case final global?) {
    final members = groups
        .expand((group) => (group['proxies'] as List).cast<String>())
        .toSet();
    selections['GLOBAL'] =
        global == 'DIRECT' || global == 'REJECT' || global == managedRoot
        ? global
        : rename[global] ?? (members.contains(global) ? global : 'REJECT');
  }
  return selections;
}
