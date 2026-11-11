import 'dart:async';

import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/service.dart';
import 'package:fl_clash/accounts/store.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

Future<void> waitFor(bool Function() condition) async {
  for (var attempt = 0; attempt < 200; attempt++) {
    if (condition()) return;
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
  fail('account condition did not settle');
}

class GatedInitializationStore extends FakeStore {
  final bool gateIdentity;
  final entered = Completer<void>();
  final release = Completer<void>();
  bool gated = false;
  GatedInitializationStore({required this.gateIdentity});

  Future<void> _gate(bool identity) async {
    if (identity != gateIdentity || gated) return;
    gated = true;
    entered.complete();
    await release.future;
  }

  @override
  Future<String> installIdentity() async {
    await _gate(true);
    return super.installIdentity();
  }

  @override
  Future<StoredAccountSession?> readSession() async {
    await _gate(false);
    return super.readSession();
  }
}

void main() {
  test(
    'session restores across service restart with the same identity',
    () async {
      final store = FakeStore();
      final firstGateway = FakeGateway();
      final first = AccountService(gateway: firstGateway, store: store);
      await first.initialize();
      await first.login('synthetic@example.test', 'synthetic-password');
      expect(first.status.value.persisted, isTrue);
      await first.shutdown();
      expect(store.stored, isNotNull);
      final secondGateway = FakeGateway();
      final second = AccountService(gateway: secondGateway, store: store);
      addTearDown(second.dispose);
      await second.initialize();
      expect(secondGateway.restores, 1);
      expect(secondGateway.identity, firstGateway.identity);
      expect(second.status.value.state.authenticated, isTrue);
      expect(second.status.value.persisted, isTrue);
    },
  );

  test('missing session stays signed out', () async {
    final gateway = FakeGateway();
    final service = AccountService(gateway: gateway, store: FakeStore());
    addTearDown(service.dispose);
    await service.initialize();
    expect(gateway.restores, 0);
    expect(service.status.value.state.authenticated, isFalse);
  });

  test('store failure is visible and never claims persistence', () async {
    final store = FakeStore()..failWrite = true;
    final service = AccountService(gateway: FakeGateway(), store: store);
    addTearDown(service.dispose);
    await service.initialize();
    await expectLater(
      service.login('synthetic@example.test', 'synthetic'),
      throwsA(isA<AccountFailure>()),
    );
    expect(service.status.value.failure, 'storage_failure');
    expect(service.status.value.persisted, isFalse);
    expect(store.stored, isNull);
  });

  test(
    'late refresh after canceled caller persists through revision watch',
    () async {
      final gateway = FakeGateway();
      final store = FakeStore();
      final service = AccountService(gateway: gateway, store: store);
      addTearDown(service.dispose);
      await service.initialize();
      await service.login('synthetic@example.test', 'synthetic');
      await expectLater(service.refresh(), throwsA(isA<AccountFailure>()));
      gateway.update(true);
      final revision = gateway.revision;
      await waitFor(
        () =>
            store.stored?.snapshot.revision == revision &&
            service.status.value.persisted,
      );
      expect(store.stored!.snapshot.revision, revision);
    },
  );

  test(
    'logout during fetch rejects late result and removes owned caches',
    () async {
      final gateway = FakeGateway()..fetchGate = Completer<void>();
      final store = FakeStore();
      var cleared = 0;
      final service = AccountService(
        gateway: gateway,
        store: store,
        clearOwnedResources: () async {
          cleared++;
        },
      );
      addTearDown(service.dispose);
      await service.initialize();
      await service.login('synthetic@example.test', 'synthetic');
      final fetch = service.catalog();
      final assertion = expectLater(
        fetch,
        throwsA(
          isA<AccountFailure>().having(
            (error) => error.kind,
            'kind',
            'superseded',
          ),
        ),
      );
      await service.logout();
      gateway.fetchGate!.complete();
      await assertion;
      expect(store.stored, isNull);
      expect(cleared, 2);
      expect(service.status.value.state.authenticated, isFalse);
    },
  );

  test(
    'logout during a secure write cannot resurrect stored session',
    () async {
      final gateway = FakeGateway();
      final store = FakeStore()
        ..writeGate = Completer<void>()
        ..writeEntered = Completer<void>();
      final service = AccountService(gateway: gateway, store: store);
      addTearDown(service.dispose);
      await service.initialize();
      final login = service.login('synthetic@example.test', 'synthetic');
      final assertion = expectLater(login, throwsA(isA<AccountFailure>()));
      await store.writeEntered!.future;
      final logout = service.logout();
      await waitFor(() => store.epochSequence == 2);
      store.writeGate!.complete();
      await Future.wait([logout, assertion]);
      expect(store.stored, isNull);
      expect(await store.readSession(), isNull);
    },
  );

  test('rotation during secure write commits newest revision', () async {
    final gateway = FakeGateway();
    final store = FakeStore()
      ..writeGate = Completer<void>()
      ..writeEntered = Completer<void>();
    final service = AccountService(gateway: gateway, store: store);
    addTearDown(service.dispose);
    await service.initialize();
    final login = service.login('synthetic@example.test', 'synthetic');
    await store.writeEntered!.future;
    gateway.update(true);
    final latest = gateway.revision;
    store.writeGate!.complete();
    await login;
    expect(store.stored!.snapshot.revision, latest);
    expect(service.status.value.persisted, isTrue);
  });
  test('new login supersedes pending logout cleanup', () async {
    final gateway = FakeGateway();
    final store = FakeStore()
      ..writeGate = Completer<void>()
      ..writeEntered = Completer<void>();
    final service = AccountService(gateway: gateway, store: store);
    addTearDown(service.dispose);
    await service.initialize();
    final first = service.login('first@example.test', 'synthetic');
    final firstAssertion = expectLater(first, throwsA(isA<AccountFailure>()));
    await store.writeEntered!.future;
    final logout = service.logout();
    await waitFor(() => store.epochSequence == 2);
    final second = service.login('second@example.test', 'synthetic');
    await waitFor(() => store.epochSequence == 3);
    store.writeGate!.complete();
    await Future.wait([logout, firstAssertion, second]);
    expect((await store.readSession())?.epoch, 'epoch-3');
    expect(service.status.value.state.authenticated, isTrue);
    expect(service.status.value.persisted, isTrue);
  });
  test(
    'reattaching Flutter saves a newer session already held by Core',
    () async {
      final store = FakeStore()
        ..stored = (epoch: 'epoch-0', snapshot: testSnapshot(1, 1));
      final gateway = FakeGateway()
        ..current = const AccountState(
          revision: 4,
          generation: 1,
          authenticated: true,
        );
      final service = AccountService(gateway: gateway, store: store);
      addTearDown(service.dispose);
      await service.initialize();
      expect(gateway.restores, 0);
      expect(store.stored!.snapshot.revision, 4);
    },
  );
  test('a restarted Core restores through the existing connection', () async {
    final gateway = FakeGateway();
    final store = FakeStore();
    final service = AccountService(gateway: gateway, store: store);
    addTearDown(service.dispose);
    await service.initialize();
    await service.login('synthetic@example.test', 'synthetic');
    await waitFor(() => gateway.waiting != null);
    gateway.current = const AccountState();
    final previousWatch = gateway.waiting!;
    gateway.waiting = null;
    previousWatch.completeError(const AccountFailure('superseded'));
    await waitFor(
      () => gateway.restores == 1 && service.status.value.persisted,
    );
    expect(service.status.value.state.authenticated, isTrue);
  });
  for (final gateIdentity in [true, false]) {
    test(
      'logout during ${gateIdentity ? 'identity' : 'session'} initialization allows login and late refresh persistence',
      () async {
        final gateway = FakeGateway();
        final store = GatedInitializationStore(gateIdentity: gateIdentity);
        final service = AccountService(gateway: gateway, store: store);
        addTearDown(service.dispose);
        final initializing = service.initialize();
        await store.entered.future;
        await service.logout();
        store.release.complete();
        await initializing;
        await service.login('synthetic@example.test', 'synthetic');
        expect(gateway.initializations, 1);
        expect(service.status.value.persisted, isTrue);
        await expectLater(service.refresh(), throwsA(isA<AccountFailure>()));
        gateway.update(true);
        final revision = gateway.revision;
        await waitFor(
          () =>
              store.stored?.snapshot.revision == revision &&
              service.status.value.persisted,
        );
        expect(store.stored!.snapshot.revision, revision);
      },
    );
  }
}
