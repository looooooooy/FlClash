import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

const accountSessionLimit = 3 * 1024 * 1024;
const _sessionKey = 'heysocks_session_v1';
const _identityKey = 'heysocks.install.v1';
const _epochKey = 'heysocks.session_epoch.v1';
const _profilesKey = 'heysocks.private_profiles.v1';

typedef StoredAccountSession = ({String epoch, AccountSnapshot snapshot});

abstract interface class AccountSessionStore {
  Future<String> installIdentity();
  Future<StoredAccountSession?> readSession();
  Future<String> beginSession();
  Future<void> writeSession(AccountSnapshot snapshot, String epoch);
  Future<void> clearSession();
}

abstract interface class AccountSecretStorage {
  Future<String?> read();
  Future<void> write(String value);
  Future<void> delete();
}

class PlatformAccountSecretStorage implements AccountSecretStorage {
  final FlutterSecureStorage storage;
  final String installationId;
  const PlatformAccountSecretStorage({
    required this.installationId,
    this.storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        resetOnError: false,
        storageNamespace: 'heysocks_account_v1',
      ),
      mOptions: MacOsOptions(
        accountName: 'FlClash.HeySocks.account.v1',
        usesDataProtectionKeychain: false,
        synchronizable: false,
      ),
    ),
  });
  @override
  Future<String?> read() => storage.read(key: '${_sessionKey}_$installationId');
  @override
  Future<void> write(String value) =>
      storage.write(key: '${_sessionKey}_$installationId', value: value);
  @override
  Future<void> delete() =>
      storage.delete(key: '${_sessionKey}_$installationId');
}

class ProtectedAccountStore implements AccountSessionStore {
  final AccountSecretStorage? _configuredSecrets;
  AccountSecretStorage? _platformSecrets;
  final SharedPreferencesAsync metadata;
  Future<void> _metadataWrites = Future.value();
  Future<String>? _identity;
  ProtectedAccountStore({
    AccountSecretStorage? secrets,
    SharedPreferencesAsync? metadata,
  }) : _configuredSecrets = secrets,
       metadata = metadata ?? SharedPreferencesAsync();

  Future<AccountSecretStorage> _secretStorage() async =>
      _configuredSecrets ??
      (_platformSecrets ??= PlatformAccountSecretStorage(
        installationId: await installIdentity(),
      ));

  static String _randomId() {
    final random = Random.secure();
    return List.generate(
      32,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  static bool _validId(String? value) =>
      value != null && RegExp(r'^[a-f0-9]{64}$').hasMatch(value);

  @override
  Future<String> installIdentity() =>
      _identity ??= _loadIdentity().onError((error, stack) {
        _identity = null;
        throw error is AccountFailure
            ? error
            : const AccountFailure('storage_failure');
      });
  Future<String> _loadIdentity() async {
    try {
      final previous = await metadata.getString(_identityKey);
      if (previous != null) {
        if (!_validId(previous)) throw const AccountFailure('corrupt_storage');
        return previous;
      }
      final identity = _randomId();
      await metadata.setString(_identityKey, identity);
      if (await metadata.getString(_identityKey) != identity) {
        throw const AccountFailure('storage_failure');
      }
      return identity;
    } on AccountFailure {
      rethrow;
    } catch (_) {
      throw const AccountFailure('storage_failure');
    }
  }

  @override
  Future<String> beginSession() {
    final result = _metadataWrites.then((_) async {
      final epoch = _randomId();
      try {
        await metadata.setString(_epochKey, epoch);
        if (await metadata.getString(_epochKey) != epoch) {
          throw const AccountFailure('storage_failure');
        }
        return epoch;
      } catch (_) {
        throw const AccountFailure('storage_failure');
      }
    });
    _metadataWrites = result.then<void>((_) {}, onError: (_) {});
    return result;
  }

  @override
  Future<StoredAccountSession?> readSession() async {
    try {
      final epoch = await metadata.getString(_epochKey);
      final encoded = await (await _secretStorage()).read();
      if (encoded == null) return null;
      if (utf8.encode(encoded).length > accountSessionLimit) {
        throw const AccountFailure('size_limit');
      }
      final value = accountMap(jsonDecode(encoded));
      if (!_validId(epoch) || value['epoch'] != epoch) return null;
      if (value['version'] != 1) throw const AccountFailure('corrupt_storage');
      return (
        epoch: epoch!,
        snapshot: AccountSnapshot.fromPrivateJson(
          accountMap(value['snapshot']),
        ),
      );
    } on AccountFailure {
      rethrow;
    } on FormatException {
      throw const AccountFailure('corrupt_storage');
    } catch (_) {
      throw const AccountFailure('storage_failure');
    }
  }

  @override
  Future<void> writeSession(AccountSnapshot snapshot, String epoch) async {
    final encoded = jsonEncode({
      'version': 1,
      'epoch': epoch,
      'snapshot': snapshot.toPrivateJson(),
    });
    if (utf8.encode(encoded).length > accountSessionLimit) {
      throw const AccountFailure('size_limit');
    }
    try {
      if (await metadata.getString(_epochKey) != epoch) {
        throw const AccountFailure('superseded');
      }
      await (await _secretStorage()).write(encoded);
      if (await (await _secretStorage()).read() != encoded) {
        throw const AccountFailure('storage_failure');
      }
    } on AccountFailure {
      rethrow;
    } catch (_) {
      throw const AccountFailure('storage_failure');
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await (await _secretStorage()).delete();
      if (await (await _secretStorage()).read() != null) {
        throw const AccountFailure('storage_failure');
      }
    } catch (_) {
      throw const AccountFailure('storage_failure');
    }
  }

  Future<Set<int>> privateProfileIds() async {
    final values = await metadata.getStringList(_profilesKey) ?? const [];
    return values.map(int.parse).toSet();
  }

  Future<void> registerPrivateProfile(int id) async {
    final result = _metadataWrites.then((_) async {
      final ids = await privateProfileIds()
        ..add(id);
      await metadata.setStringList(
        _profilesKey,
        ids.map((id) => '$id').toList(),
      );
    });
    _metadataWrites = result.then<void>((_) {}, onError: (_) {});
    await result;
  }
}
