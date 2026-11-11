import 'dart:async';

import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/rpc.dart';
import 'package:fl_clash/accounts/store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

AccountSnapshot testSnapshot(
  int revision,
  int generation, [
  String token = 'synthetic-token',
]) => AccountSnapshot.fromPrivateJson({
  'revision': revision,
  'generation': generation,
  'session': {
    'payload': {
      'token': {'token': token},
      'vendorMetadata': 'preserved',
    },
  },
});

class FakeGateway extends Fake implements AccountGateway {
  AccountState current = const AccountState();
  Completer<AccountState>? waiting;
  Completer<void>? fetchGate;
  int restores = 0;
  int initializations = 0;
  String? identity;
  int get revision => current.revision;
  void update(bool authenticated, {bool newGeneration = false}) {
    current = AccountState(
      revision: current.revision + 1,
      generation: current.generation + (newGeneration ? 1 : 0),
      authenticated: authenticated,
    );
    final pending = waiting;
    waiting = null;
    pending?.complete(current);
  }

  @override
  Future<AccountState> initialize(String deviceId) async {
    initializations++;
    identity = deviceId;
    return current;
  }

  @override
  Future<void> discover() async {}
  @override
  Future<AccountAuthResult> login(String email, String password) async {
    update(true, newGeneration: true);
    return AccountAuthResult(current);
  }

  @override
  Future<AccountAuthResult> restore(AccountSnapshot snapshot) async {
    restores++;
    update(true, newGeneration: true);
    return AccountAuthResult(current);
  }

  @override
  Future<AccountState> state() async => current;
  @override
  Future<AccountState> watch(int revision) {
    if (revision != current.revision) return Future.value(current);
    return (waiting ??= Completer<AccountState>()).future;
  }

  @override
  Future<AccountSnapshot> snapshot() async => testSnapshot(
    current.revision,
    current.generation,
    'synthetic-revision-${current.revision}',
  );
  @override
  Future<AccountCatalog> catalog(String isp) async {
    await fetchGate?.future;
    return const AccountCatalog([]);
  }

  @override
  Future<AccountState> refresh() async =>
      throw const AccountFailure('canceled');
  @override
  Future<AccountState> logout() async {
    update(false, newGeneration: true);
    return current;
  }

  @override
  Future<AccountState> suspend() async {
    update(current.authenticated, newGeneration: true);
    return current;
  }

  @override
  Future<void> cancelPending() async {
    final pending = waiting;
    waiting = null;
    pending?.completeError(const AccountFailure('canceled'));
  }
}

class FakeStore implements AccountSessionStore {
  StoredAccountSession? stored;
  String epoch = 'epoch-0';
  int epochSequence = 0;
  int writes = 0;
  bool failWrite = false;
  Completer<void>? writeGate;
  Completer<void>? writeEntered;
  @override
  Future<String> installIdentity() async => 'stable-install';
  @override
  Future<StoredAccountSession?> readSession() async =>
      stored?.epoch == epoch ? stored : null;
  @override
  Future<String> beginSession() async => epoch = 'epoch-${++epochSequence}';
  @override
  Future<void> writeSession(AccountSnapshot snapshot, String epoch) async {
    writes++;
    if (writeEntered?.isCompleted == false) writeEntered!.complete();
    await writeGate?.future;
    if (failWrite) throw const AccountFailure('storage_failure');
    stored = (epoch: epoch, snapshot: snapshot);
  }

  @override
  Future<void> clearSession() async {
    stored = null;
  }
}

class FakeMetadata extends Fake implements SharedPreferencesAsync {
  final Map<String, Object> values = {};
  final bool fail;
  FakeMetadata({this.fail = false});
  @override
  Future<String?> getString(String key) async => values[key] as String?;
  @override
  Future<void> setString(String key, String value) async {
    if (fail) throw StateError('synthetic-secret-must-not-escape');
    values[key] = value;
  }

  @override
  Future<List<String>?> getStringList(String key) async =>
      values[key] as List<String>?;
  @override
  Future<void> setStringList(String key, List<String> value) async {
    values[key] = value;
  }
}

class FakeSecrets implements AccountSecretStorage {
  String? value;
  bool fail = false;
  bool dropWrite = false;
  @override
  Future<String?> read() async => value;
  @override
  Future<void> write(String value) async {
    if (fail) throw StateError('synthetic-secret-must-not-escape');
    if (!dropWrite) this.value = value;
  }

  @override
  Future<void> delete() async {
    if (fail) throw StateError('synthetic-secret-must-not-escape');
    value = null;
  }
}
