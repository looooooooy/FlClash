import 'dart:async';

import 'package:flutter/foundation.dart';

import 'models.dart';
import 'rpc.dart';
import 'store.dart';

class AccountStatus {
  final AccountState state;
  final bool restoring;
  final bool persisted;
  final String? failure;
  const AccountStatus({
    this.state = const AccountState(),
    this.restoring = false,
    this.persisted = false,
    this.failure,
  });
}

typedef AccountOwnedCleanup = Future<void> Function();

class AccountService {
  final AccountGateway gateway;
  final AccountSessionStore store;
  final ValueNotifier<AccountStatus> status = ValueNotifier(
    const AccountStatus(),
  );
  AccountOwnedCleanup? clearOwnedResources;
  Future<void>? _initialization;
  Future<void> _writes = Future.value();
  Future<void>? _watching;
  Future<void>? _reconnecting;
  int _generation = 0;
  String? _epoch;
  bool _disposed = false;
  bool _mutating = false;
  bool _ready = false;
  AccountState _state = const AccountState();
  int? _persistedRevision;
  int? _persistedGeneration;

  AccountService({
    required this.gateway,
    required this.store,
    this.clearOwnedResources,
  });
  Future<void> initialize() {
    final active = _initialization;
    if (active != null) return active;
    final generation = _generation;
    late final Future<void> operation;
    operation = _initialize(generation).whenComplete(() {
      if (identical(_initialization, operation) && !_ready) {
        _initialization = null;
      }
    });
    _initialization = operation;
    return operation;
  }

  Future<void> _initialize(int generation) async {
    _publish(restoring: true);
    try {
      final identity = await store.installIdentity();
      if (!_current(generation)) return;
      final state = await gateway.initialize(identity);
      if (!_current(generation)) return;
      _state = state;
      _ready = true;
      final saved = await store.readSession();
      if (!_current(generation)) return;
      if (saved != null) {
        _epoch = saved.epoch;
        if (!_state.authenticated) {
          final result = await gateway.restore(saved.snapshot);
          if (!_current(generation)) return;
          _state = result.state;
        }
        await _persist(generation);
      } else if (_state.authenticated) {
        final state = await gateway.logout();
        if (!_current(generation)) return;
        _state = state;
      }
      if (!_current(generation)) return;
      _publish();
      unawaited(_discover());
    } catch (error) {
      if (_current(generation) && _ready) {
        try {
          final state = await gateway.logout();
          if (_current(generation)) _state = state;
        } catch (_) {}
      }
      if (_current(generation)) _publish(failure: _safeKind(error));
    } finally {
      if (_ready && !_disposed) _watching ??= _watch();
    }
  }

  Future<void> _discover() async {
    try {
      await gateway.discover();
    } catch (_) {}
  }

  bool _current(int generation) => !_disposed && generation == _generation;
  String _safeKind(Object error) => error is AccountFailure
      ? error.kind
      : error is AccountChallengeRequired
      ? 'captcha_required'
      : 'account_unavailable';
  void _publish({bool restoring = false, String? failure}) {
    if (_disposed) return;
    status.value = AccountStatus(
      state: _state,
      restoring: restoring,
      persisted:
          _state.authenticated &&
          _persistedRevision == _state.revision &&
          _persistedGeneration == _state.generation,
      failure: failure,
    );
  }

  Future<void> _watch() async {
    while (!_disposed) {
      if (!_ready || _mutating) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
        continue;
      }
      final generation = _generation;
      try {
        final state = await gateway.watch(_state.revision);
        if (!_current(generation) || _mutating) {
          if (!_disposed) {
            await Future<void>.delayed(const Duration(milliseconds: 100));
          }
          continue;
        }
        _state = state;
        if (state.authenticated && _epoch != null) await _persist(generation);
        if (_current(generation)) {
          _publish(failure: state.authenticated ? null : status.value.failure);
        }
      } catch (error) {
        if (_current(generation) &&
            !_mutating &&
            error is AccountFailure &&
            error.kind == 'superseded') {
          await reconnect();
          continue;
        }
        if (_current(generation) && !_mutating) {
          _publish(failure: _safeKind(error));
        }
        if (!_disposed) await Future<void>.delayed(const Duration(seconds: 1));
      }
    }
  }

  Future<T> _enqueue<T>(Future<T> Function() run) {
    final result = _writes.then((_) => run());
    _writes = result.then<void>((_) {}, onError: (_) {});
    return result;
  }

  Future<void> _persist(int generation) => _enqueue(() async {
    while (_current(generation) && _epoch != null && _state.authenticated) {
      final snapshot = await gateway.snapshot();
      if (!_current(generation)) return;
      if (_persistedRevision == snapshot.revision &&
          _persistedGeneration == snapshot.generation) {
        return;
      }
      final epoch = _epoch!;
      await store.writeSession(snapshot, epoch);
      if (!_current(generation)) {
        if (epoch != _epoch) await store.clearSession();
        return;
      }
      final latest = await gateway.state();
      if (!_current(generation)) {
        if (epoch != _epoch) await store.clearSession();
        return;
      }
      _state = latest;
      if (!latest.authenticated) {
        await store.clearSession();
        return;
      }
      if (latest.revision != snapshot.revision ||
          latest.generation != snapshot.generation) {
        continue;
      }
      _persistedRevision = snapshot.revision;
      _persistedGeneration = snapshot.generation;
      return;
    }
  });

  Future<int> _begin() async {
    await initialize();
    if (_disposed) throw const AccountFailure('canceled');
    if (!_ready) throw const AccountFailure('account_unavailable');
    final generation = ++_generation;
    _mutating = true;
    _persistedRevision = null;
    _epoch = null;
    _state = const AccountState();
    _publish();
    try {
      final epoch = await store.beginSession();
      if (!_current(generation)) throw const AccountFailure('superseded');
      _epoch = epoch;
      await clearOwnedResources?.call();
      if (!_current(generation)) throw const AccountFailure('superseded');
      return generation;
    } catch (error) {
      if (_current(generation)) {
        _mutating = false;
        _publish(failure: _safeKind(error));
      }
      throw AccountFailure(_safeKind(error));
    }
  }

  Future<T> _run<T>(
    int generation,
    Future<T> Function() work, {
    AccountState? Function(T value)? stateOf,
  }) async {
    try {
      final result = await work();
      if (!_current(generation)) throw const AccountFailure('superseded');
      _mutating = false;
      _state = stateOf?.call(result) ?? await gateway.state();
      if (!_current(generation)) throw const AccountFailure('superseded');
      if (_state.authenticated) await _persist(generation);
      if (!_current(generation)) throw const AccountFailure('superseded');
      _publish();
      return result;
    } catch (error) {
      if (_current(generation)) {
        _mutating = false;
        _publish(failure: _safeKind(error));
      }
      if (error is AccountFailure || error is AccountChallengeRequired) rethrow;
      throw AccountFailure(_safeKind(error));
    }
  }

  Future<AccountAuthResult> login(String email, String password) async {
    final generation = await _begin();
    return _run(
      generation,
      () => gateway.login(email, password),
      stateOf: (result) => result.state,
    );
  }

  Future<AccountAuthResult> captcha(String id, String token) => _run(
    _generation,
    () => gateway.captcha(id, token),
    stateOf: (result) => result.state,
  );
  Future<void> validateCaptcha(String token) => gateway.validateCaptcha(token);
  Future<AccountDeviceFlow> startDevice() async {
    final generation = await _begin();
    return _run(generation, gateway.startDevice);
  }

  Future<AccountDeviceEvent> pollDevice(String id) => _run(
    _generation,
    () => gateway.pollDevice(id),
    stateOf: (result) => result.state,
  );
  Future<void> cancelDevice(String id) => gateway.cancelDevice(id);
  Future<AccountState> refresh() =>
      _run(_generation, gateway.refresh, stateOf: (state) => state);
  Future<AccountCatalog> catalog({String isp = ''}) =>
      _run(_generation, () => gateway.catalog(isp));
  Future<AccountNodeConfig> config(
    AccountNode node,
    AccountConfigOptions options,
  ) => _run(_generation, () => gateway.config(node, options));
  Future<AccountProfile> buildProfile(List<AccountNodeConfig> configs) =>
      _run(_generation, () => gateway.buildProfile(configs));

  Future<void> logout() async {
    final generation = ++_generation;
    _mutating = true;
    _epoch = null;
    _persistedRevision = null;
    _state = const AccountState();
    _publish();
    Object? failure;
    Future<void> attempt(Future<void> Function() run) async {
      try {
        await run();
      } catch (error) {
        failure ??= error;
      }
    }

    await Future.wait([
      attempt(() async {
        await store.beginSession();
      }),
      attempt(() async {
        final state = await gateway.logout();
        if (_current(generation)) _state = state;
      }),
    ]);
    await attempt(
      () => _enqueue(() async {
        if (_current(generation)) await store.clearSession();
      }),
    );
    await attempt(() async {
      if (_current(generation)) await clearOwnedResources?.call();
    });
    if (_current(generation)) {
      _mutating = false;
      _publish(failure: failure == null ? null : _safeKind(failure!));
    }
    if (failure != null) throw AccountFailure(_safeKind(failure!));
  }

  Future<void> reconnect() => _reconnecting ??= _reconnect().whenComplete(() {
    _reconnecting = null;
  });

  Future<void> _reconnect() async {
    if (_disposed) return;
    _generation++;
    _ready = false;
    _mutating = true;
    await gateway.cancelPending();
    await _writes;
    _state = const AccountState();
    _persistedRevision = null;
    _persistedGeneration = null;
    _initialization = null;
    await initialize();
    _mutating = false;
  }

  Future<void> shutdown() async {
    if (_disposed) return;
    _mutating = true;
    AccountFailure? failure;
    if (_ready) {
      try {
        _state = await gateway.suspend();
        await flush();
      } catch (error) {
        failure = AccountFailure(_safeKind(error));
        _publish(failure: failure.kind);
      }
    }
    await dispose();
    if (failure != null) throw failure;
  }

  Future<void> flush() => _persist(_generation);
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _generation++;
    await gateway.cancelPending();
    await _watching;
    await _writes;
    status.dispose();
  }
}
