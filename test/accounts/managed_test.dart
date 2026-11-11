import 'dart:async';

import 'package:fl_clash/accounts/managed.dart';
import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/service.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

AccountNode node(String id, String country) => AccountNode.fromPrivateJson({
  'stableId': id,
  'name': id,
  'country_code': country,
  'countryName': country,
  'categoryName': 'Standard',
});

class CatalogGateway extends FakeGateway {
  List<AccountNode> nodes = [node('a', 'A'), node('b', 'B'), node('c', 'B')];
  Set<String> unsupported = {};
  Set<String> failures = {};
  Set<String> unauthorized = {};
  Map<String, AccountFailure> configFailures = {};
  Map<String, int> connectionCounts = {};
  final fetchedNodes = <String>[];
  int catalogCalls = 0;
  int active = 0;
  int maxActive = 0;
  int configCalls = 0;
  Completer<void>? configGate;
  final configGates = <String, Completer<void>>{};
  @override
  Future<AccountCatalog> catalog(String isp) async {
    catalogCalls++;
    return AccountCatalog(nodes);
  }

  @override
  Future<AccountNodeConfig> config(
    AccountNode node,
    AccountConfigOptions options,
  ) async {
    configCalls++;
    fetchedNodes.add(node.stableId);
    active++;
    if (active > maxActive) maxActive = active;
    try {
      await configGate?.future;
      await configGates[node.stableId]?.future;
      await Future<void>.delayed(Duration.zero);
      if (configFailures[node.stableId] case final failure?) throw failure;
      if (failures.contains(node.stableId)) {
        throw const AccountFailure('request_rejected');
      }
      if (unauthorized.contains(node.stableId)) {
        throw const AccountFailure('request_rejected', httpStatus: 403);
      }
      return AccountNodeConfig.fromPrivateJson({
        'node': node.toPrivateJson(),
        'connections': unsupported.contains(node.stableId)
            ? []
            : [
                for (var i = 0; i < (connectionCounts[node.stableId] ?? 1); i++)
                  {'name': node.stableId, 'type': 'heysocks-xhttp'},
              ],
      });
    } finally {
      active--;
    }
  }

  @override
  Future<AccountProfile> buildProfile(List<AccountNodeConfig> configs) async {
    final sorted = configs.toList()
      ..sort((a, b) => a.node.stableId.compareTo(b.node.stableId));
    final countries = sorted.map((c) => c.node.countryCode).toSet().toList()
      ..sort();
    List<String> connections(AccountNodeConfig config) {
      final count = (config.toPrivateJson()['connections'] as List).length;
      return count == 1
          ? [config.node.stableId]
          : [for (var i = 0; i < count; i++) '${config.node.stableId}-$i'];
    }

    return AccountProfile.fromPrivateJson({
      'proxies': [
        for (final config in sorted)
          for (final connection in connections(config))
            {'name': connection, 'type': 'heysocks-xhttp'},
      ],
      'proxy-groups': [
        {'name': managedRoot, 'type': 'select', 'proxies': countries},
        for (final country in countries)
          {
            'name': country,
            'type': 'select',
            'proxies': [
              for (final config in sorted)
                if (config.node.countryCode == country) config.node.stableId,
            ],
          },
        for (final config in sorted)
          if (connections(config).length > 1)
            {
              'name': config.node.stableId,
              'type': 'select',
              'hidden': true,
              'proxies': connections(config),
            },
      ],
    });
  }
}

class MemoryRepository implements ManagedProfileRepository {
  @override
  bool globalMode = false;
  @override
  Profile? profile;
  List<AccountNodeConfig> cache = [];
  ManagedPublication? last;
  int publications = 0;
  int stops = 0;
  Completer<void>? publishing;
  Completer<void>? entered;
  final firstPublished = Completer<void>();
  AccountFailure? publicationFailure;
  @override
  AccountConfigOptions get options => const AccountConfigOptions();
  @override
  Future<List<AccountNodeConfig>> readCache() async => cache;
  @override
  Future<void> publish(
    ManagedPublication value,
    bool Function() isCurrent,
  ) async {
    entered?.complete();
    await publishing?.future;
    if (!isCurrent()) throw const AccountFailure('superseded');
    if (publicationFailure case final failure?) throw failure;
    publications++;
    last = value;
    cache = value.cache;
    profile = Profile(
      id: 7,
      type: ProfileType.heysocks,
      autoUpdateDuration: managedFullAge,
      managed: value.info,
      selectedMap: value.selections,
    );
    if (!firstPublished.isCompleted) firstPublished.complete();
  }

  @override
  Future<void> clear() async {
    profile = null;
    cache = [];
    last = null;
  }

  @override
  Future<void> stop() async {
    stops++;
  }

  @override
  Future<void> apply() async {}
}

void main() {
  late CatalogGateway gateway;
  late AccountService service;
  late MemoryRepository repository;
  late ManagedAccount manager;
  var clock = DateTime(2026, 1, 1);
  setUp(() async {
    gateway = CatalogGateway();
    service = AccountService(gateway: gateway, store: FakeStore());
    repository = MemoryRepository();
    manager = ManagedAccount(
      service: service,
      repository: repository,
      now: () => clock,
      delay: (_) async {},
    );
    await service.login('synthetic@example.test', 'synthetic');
  });
  tearDown(() async {
    manager.dispose();
    await service.dispose();
  });

  test('sync is bounded, coalesced and routes the selector', () async {
    await Future.wait([manager.sync(), manager.sync()]);
    expect(gateway.catalogCalls, 1);
    expect(gateway.maxActive, 2);
    expect(repository.last!.config['rules'], managedRoutingRules);
    expect(repository.profile!.selectedMap['GLOBAL'], managedRoot);
    expect(manager.status.value.ready, 3);
  });
  test(
    'first verified line is usable while other lines are still syncing',
    () async {
      final slow = Completer<void>();
      gateway.configGates.addAll({'b': slow, 'c': slow});
      final sync = manager.sync();
      try {
        await repository.firstPublished.future.timeout(
          const Duration(seconds: 3),
        );
        expect(repository.profile!.managed!.lineNames.keys, ['a']);
        expect(manager.status.value.syncing, isTrue);
        await manager
            .ensureUsable(group: managedRoot, target: 'A')
            .timeout(const Duration(seconds: 3));
      } finally {
        slow.complete();
        await sync;
      }
      expect(repository.profile!.managed!.lineNames.keys, ['a', 'b', 'c']);
      expect(repository.profile!.selectedMap[managedRoot], 'A');
    },
  );
  test('partial success excludes unsupported and failed lines', () async {
    gateway.unsupported = {'b'};
    gateway.failures = {'c'};
    await manager.sync();
    expect(manager.status.value.ready, 1);
    expect(manager.status.value.unsupported, 1);
    expect(manager.status.value.failed, 1);
    expect(repository.profile!.managed!.lineNames.keys, ['a']);
  });
  test('transient failure retains the previous supported line', () async {
    await manager.sync();
    gateway.configFailures = {'a': const AccountFailure('network_unavailable')};
    await manager.sync();
    expect(repository.profile!.managed!.lineNames, contains('a'));
    expect(manager.status.value.failed, 1);
  });
  for (final failure in const [
    AccountFailure('invalid_response'),
    AccountFailure('config_authentication_failed'),
    AccountFailure('size_limit'),
    AccountFailure('request_rejected'),
    AccountFailure('request_rejected', httpStatus: 400),
    AccountFailure('request_rejected', httpStatus: 410),
  ]) {
    for (final full in [true, false]) {
      test(
        'permanent ${failure.kind}/${failure.httpStatus} ${full ? 'sync' : 'target'} invalidates GLOBAL selection',
        () async {
          await manager.sync();
          repository.globalMode = true;
          repository.profile = repository.profile!.copyWith(
            selectedMap: {...repository.profile!.selectedMap, 'GLOBAL': 'b'},
          );
          clock = clock.add(const Duration(minutes: 6));
          gateway.configFailures['b'] = failure;
          gateway.fetchedNodes.clear();
          if (full) {
            await manager.sync();
            expect(manager.status.value.failed, 1);
          } else {
            await expectLater(
              manager.ensureUsable(),
              throwsA(isA<AccountFailure>()),
            );
          }
          expect(gateway.fetchedNodes.where((node) => node == 'b').length, 1);
          expect(repository.profile!.managed!.lineNames, isNot(contains('b')));
          expect(
            repository.cache.map((config) => config.node.stableId),
            isNot(contains('b')),
          );
          expect(repository.profile!.selectedMap['GLOBAL'], 'REJECT');
          expect(repository.profile!.managed!.selectionRequired, isTrue);
          expect(repository.stops, greaterThan(0));
        },
      );
    }
  }
  for (final failure in const [
    AccountFailure('network_unavailable'),
    AccountFailure('transport_unavailable'),
    AccountFailure('timeout'),
    AccountFailure('request_rejected', httpStatus: 408),
    AccountFailure('request_rejected', httpStatus: 429),
    AccountFailure('request_rejected', httpStatus: 503),
  ]) {
    for (final full in [true, false]) {
      test(
        'transient ${failure.kind}/${failure.httpStatus} ${full ? 'sync' : 'target'} retains last valid config without renewing freshness',
        () async {
          await manager.sync();
          final checked = repository.profile!.managed!.checkedAt['a'];
          clock = clock.add(const Duration(minutes: 6));
          gateway.configFailures['a'] = failure;
          gateway.fetchedNodes.clear();
          if (full) {
            await manager.sync();
          } else {
            await expectLater(
              manager.ensureUsable(),
              throwsA(isA<AccountFailure>()),
            );
          }
          expect(gateway.fetchedNodes.where((node) => node == 'a').length, 2);
          expect(repository.profile!.managed!.lineNames, contains('a'));
          expect(repository.profile!.managed!.checkedAt['a'], checked);
          expect(repository.profile!.managed!.selectionRequired, isFalse);
        },
      );
    }
  }
  for (final kind in ['canceled', 'superseded']) {
    for (final full in [true, false]) {
      test(
        '$kind ${full ? 'sync' : 'target'} aborts without publication or invalidation',
        () async {
          await manager.sync();
          final profile = repository.profile;
          final publications = repository.publications;
          clock = clock.add(const Duration(minutes: 6));
          gateway.configFailures['a'] = AccountFailure(kind);
          gateway.fetchedNodes.clear();
          await expectLater(
            full ? manager.sync() : manager.ensureUsable(),
            throwsA(
              isA<AccountFailure>().having((error) => error.kind, 'kind', kind),
            ),
          );
          expect(gateway.fetchedNodes.where((node) => node == 'a').length, 1);
          expect(repository.profile, profile);
          expect(repository.publications, publications);
        },
      );
    }
  }
  test(
    'local publication failure does not invalidate a supported target',
    () async {
      await manager.sync();
      final profile = repository.profile;
      clock = clock.add(const Duration(minutes: 6));
      repository.publicationFailure = const AccountFailure(
        'publication_failed',
      );
      await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
      expect(repository.profile, profile);
      expect(
        repository.cache.map((config) => config.node.stableId),
        contains('a'),
      );
    },
  );
  test('selected country and line survive reorder and refresh', () async {
    await manager.sync();
    repository.profile = repository.profile!.copyWith(
      selectedMap: {'GLOBAL': managedRoot, managedRoot: 'B', 'B': 'c'},
    );
    gateway.nodes = gateway.nodes.reversed.toList();
    await manager.sync();
    expect(repository.profile!.selectedMap[managedRoot], 'B');
    expect(repository.profile!.selectedMap['B'], 'c');
  });
  test('removed selected country blocks instead of changing country', () async {
    await manager.sync();
    repository.profile = repository.profile!.copyWith(
      selectedMap: {managedRoot: 'A', 'A': 'a'},
    );
    gateway.nodes.removeWhere((n) => n.countryCode == 'A');
    await manager.sync();
    expect(repository.profile!.selectedMap[managedRoot], 'REJECT');
    expect(repository.profile!.managed!.selectionRequired, isTrue);
    await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
    await manager.ensureUsable(group: managedRoot, target: 'B');
  });
  test('removed all lines publishes rejection and stops', () async {
    await manager.sync();
    gateway.nodes = [];
    await expectLater(manager.sync(), throwsA(isA<AccountFailure>()));
    expect(repository.profile!.managed!.selectionRequired, isTrue);
    expect(repository.last!.cache, isEmpty);
    expect(repository.last!.config['rules'], managedRoutingRules);
  });
  test(
    'fresh target skips fetch and five minute target refresh rechecks',
    () async {
      await manager.sync();
      final calls = gateway.configCalls;
      await manager.ensureUsable();
      expect(gateway.configCalls, calls);
      clock = clock.add(const Duration(minutes: 6));
      await manager.ensureUsable();
      expect(gateway.configCalls, calls + 1);
    },
  );
  test(
    'unsupported selected target becomes blocked until explicit selection',
    () async {
      await manager.sync();
      clock = clock.add(const Duration(minutes: 6));
      gateway.unsupported = {'a'};
      await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
      expect(repository.profile!.selectedMap[managedRoot], 'REJECT');
      expect(repository.profile!.managed!.selectionRequired, isTrue);
      gateway.unsupported = {};
      await manager.sync();
      expect(repository.profile!.selectedMap[managedRoot], 'REJECT');
      await manager.ensureUsable(group: managedRoot, target: 'B');
    },
  );

  for (final target in ['B', 'b', 'b-1']) {
    for (final starting in [false, true]) {
      test(
        'GLOBAL $target ${starting ? 'startup' : 'selection'} refreshes its owning line',
        () async {
          gateway.connectionCounts['b'] = 2;
          await manager.sync();
          repository.globalMode = true;
          if (starting) {
            repository.profile = repository.profile!.copyWith(
              selectedMap: {
                ...repository.profile!.selectedMap,
                'GLOBAL': target,
              },
            );
          }
          clock = clock.add(const Duration(minutes: 6));
          gateway.fetchedNodes.clear();
          await manager.ensureUsable(
            group: starting ? null : 'GLOBAL',
            target: starting ? null : target,
          );
          expect(gateway.fetchedNodes, ['b']);
          expect(repository.profile!.selectedMap[managedRoot], 'A');
          if (starting) {
            expect(repository.profile!.selectedMap['GLOBAL'], target);
          }
        },
      );
    }
  }

  for (final target in ['B', 'b', 'b-1']) {
    test('unauthorized GLOBAL $target blocks its effective chain', () async {
      gateway.connectionCounts['b'] = 2;
      await manager.sync();
      repository.globalMode = true;
      repository.profile = repository.profile!.copyWith(
        selectedMap: {...repository.profile!.selectedMap, 'GLOBAL': target},
      );
      clock = clock.add(const Duration(minutes: 6));
      gateway.unauthorized = {'b'};
      gateway.fetchedNodes.clear();
      await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
      expect(gateway.fetchedNodes, ['b']);
      expect(repository.profile!.managed!.selectionRequired, isTrue);
      expect(repository.profile!.selectedMap[managedRoot], 'A');
      expect(repository.stops, greaterThan(0));
      await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
      await manager.ensureUsable(group: 'GLOBAL', target: 'c');
      expect(repository.profile!.managed!.selectionRequired, isTrue);
    });
  }

  test(
    'removed direct GLOBAL connection blocks without discarding its valid line',
    () async {
      gateway.connectionCounts['b'] = 2;
      await manager.sync();
      repository.globalMode = true;
      repository.profile = repository.profile!.copyWith(
        selectedMap: {...repository.profile!.selectedMap, 'GLOBAL': 'b-1'},
      );
      clock = clock.add(const Duration(minutes: 6));
      gateway.connectionCounts['b'] = 1;
      await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
      expect(repository.profile!.selectedMap['GLOBAL'], 'REJECT');
      expect(repository.profile!.managed!.lineNames, contains('b'));
      expect(repository.profile!.managed!.selectionRequired, isTrue);
      await manager.ensureUsable(group: 'GLOBAL', target: 'b');
    },
  );

  test(
    'GLOBAL direct choice survives refresh independently of blocked root',
    () async {
      await manager.sync();
      repository.globalMode = true;
      repository.profile = repository.profile!.copyWith(
        selectedMap: {
          ...repository.profile!.selectedMap,
          'GLOBAL': 'b',
          managedRoot: 'REJECT',
        },
      );
      await manager.sync();
      expect(repository.profile!.selectedMap['GLOBAL'], 'b');
      expect(repository.profile!.managed!.selectionRequired, isFalse);
      await manager.ensureUsable();
      repository.globalMode = false;
      await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
    },
  );

  test(
    'restored cache resolves GLOBAL underlying connection ownership',
    () async {
      gateway.connectionCounts['b'] = 2;
      await manager.sync();
      repository.globalMode = true;
      repository.profile = repository.profile!.copyWith(
        selectedMap: {...repository.profile!.selectedMap, 'GLOBAL': 'b-1'},
      );
      manager.dispose();
      manager = ManagedAccount(
        service: service,
        repository: repository,
        now: () => clock,
        delay: (_) async {},
      );
      clock = clock.add(const Duration(minutes: 6));
      gateway.fetchedNodes.clear();
      await manager.ensureUsable();
      expect(gateway.fetchedNodes, ['b']);
      expect(repository.profile!.selectedMap['GLOBAL'], 'b-1');
    },
  );
  test(
    'destination mode preflight refreshes GLOBAL while rule mode remains active',
    () async {
      await manager.sync();
      repository.profile = repository.profile!.copyWith(
        selectedMap: {...repository.profile!.selectedMap, 'GLOBAL': 'b'},
      );
      clock = clock.add(const Duration(minutes: 6));
      gateway.fetchedNodes.clear();
      await manager.ensureUsable(globalMode: true);
      expect(gateway.fetchedNodes, ['b']);
      expect(repository.globalMode, isFalse);
      expect(repository.profile!.selectedMap[managedRoot], 'A');
    },
  );

  test('thirty minute catalog refresh does not refresh every target', () async {
    await manager.sync();
    final calls = gateway.configCalls;
    clock = clock.add(const Duration(minutes: 31));
    await manager.refreshIfStale();
    expect(gateway.catalogCalls, 2);
    expect(gateway.configCalls, calls);
    clock = clock.add(const Duration(hours: 12));
    await manager.refreshIfStale();
    expect(gateway.configCalls, calls + 3);
  });
  test('logout fences publication and leaves no cache or metadata', () async {
    repository.publishing = Completer();
    repository.entered = Completer();
    final sync = manager.sync();
    final result = expectLater(sync, throwsA(isA<AccountFailure>()));
    await repository.entered!.future;
    final logout = service.logout();
    repository.publishing!.complete();
    await result;
    await logout;
    expect(repository.profile, isNull);
    expect(repository.cache, isEmpty);
  });
  test('cached startup requires restored authentication', () async {
    await manager.sync();
    await service.logout();
    await expectLater(manager.ensureUsable(), throwsA(isA<AccountFailure>()));
    expect(gateway.configCalls, 3);
  });
}
