import 'dart:io';

import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/core/method.dart';

import 'models.dart';

abstract interface class AccountGateway {
  Future<AccountState> initialize(String deviceId);
  Future<void> discover();
  Future<AccountAuthResult> login(String email, String password);
  Future<AccountAuthResult> restore(AccountSnapshot snapshot);
  Future<AccountAuthResult> captcha(String id, String token);
  Future<void> validateCaptcha(String token);
  Future<AccountState> refresh();
  Future<AccountState> state();
  Future<AccountState> watch(int revision);
  Future<AccountSnapshot> snapshot();
  Future<AccountDeviceFlow> startDevice();
  Future<AccountDeviceEvent> pollDevice(String id);
  Future<void> cancelDevice(String id);
  Future<AccountCatalog> catalog(String isp);
  Future<AccountNodeConfig> config(
    AccountNode node,
    AccountConfigOptions options,
  );
  Future<AccountProfile> buildProfile(List<AccountNodeConfig> configs);
  Future<AccountState> suspend();
  Future<AccountState> logout();
  Future<void> cancelPending();
}

class CoreAccountGateway implements AccountGateway {
  final CoreHandlerInterface core;
  final String platform;
  int _lease = 0;
  int _intent = 0;
  int _sequence = 0;
  final Set<String> _pending = {};
  CoreAccountGateway(this.core, {String? platform})
    : platform = platform ?? Platform.operatingSystem;

  Future<Object?> _request(
    CoreMethod method, [
    Map<String, Object?> arguments = const {},
    Duration timeout = const Duration(seconds: 60),
  ]) async {
    final requestId = '${++_sequence}';
    final intent = _intent;
    _pending.add(requestId);
    try {
      final result = accountMap(
        await core.invokeAccountMethod(
          method: method,
          arguments: {
            'lease': _lease,
            'intent': intent,
            'requestId': requestId,
            ...arguments,
          },
          timeout: timeout,
        ),
      );
      if (intent != _intent) throw const AccountFailure('superseded');
      if (result['failure'] != null) {
        final failure = AccountFailure.fromJson(accountMap(result['failure']));
        if (result['challenge'] != null) {
          throw AccountChallengeRequired(
            failure,
            AccountChallenge.fromJson(accountMap(result['challenge'])),
          );
        }
        throw failure;
      }
      return result['value'];
    } on AccountFailure {
      rethrow;
    } on AccountChallengeRequired {
      rethrow;
    } on CoreMethodException catch (error) {
      try {
        await core.invokeAccountMethod(
          method: CoreMethod.accountCancel,
          arguments: {'lease': _lease, 'intent': intent, 'id': requestId},
          timeout: const Duration(seconds: 5),
        );
      } catch (_) {}
      throw AccountFailure(
        error.code == 'size_limit' ? 'size_limit' : 'transport_unavailable',
      );
    } catch (_) {
      throw const AccountFailure('invalid_response');
    } finally {
      _pending.remove(requestId);
    }
  }

  @override
  Future<AccountState> initialize(String deviceId) async {
    final value = accountMap(
      await _request(CoreMethod.accountInitialize, {
        'platform': platform,
        'deviceId': deviceId,
        'deviceName': 'FlClash HeySocks',
        'language': 'en',
      }),
    );
    _lease = value['lease'] as int;
    _intent = 0;
    return AccountState.fromJson(accountMap(value['state']));
  }

  @override
  Future<void> discover() async {
    await _request(CoreMethod.accountDiscover);
  }

  @override
  Future<AccountAuthResult> login(String email, String password) async {
    _intent++;
    return AccountAuthResult.fromJson(
      accountMap(
        await _request(CoreMethod.accountLogin, {
          'credentials': {'email': email, 'password': password},
        }),
      ),
    );
  }

  @override
  Future<AccountAuthResult> restore(AccountSnapshot snapshot) async {
    _intent++;
    return AccountAuthResult.fromJson(
      accountMap(
        await _request(CoreMethod.accountRestore, {
          'snapshot': snapshot.toPrivateJson(),
        }),
      ),
    );
  }

  @override
  Future<AccountAuthResult> captcha(String id, String token) async =>
      AccountAuthResult.fromJson(
        accountMap(
          await _request(CoreMethod.accountCaptcha, {
            'id': id,
            'captchaToken': token,
          }),
        ),
      );
  @override
  Future<void> validateCaptcha(String token) async {
    await _request(CoreMethod.accountValidateCaptcha, {'captchaToken': token});
  }

  @override
  Future<AccountState> refresh() async => AccountState.fromJson(
    accountMap(await _request(CoreMethod.accountRefresh)),
  );
  @override
  Future<AccountState> state() async => AccountState.fromJson(
    accountMap(await _request(CoreMethod.accountState)),
  );
  @override
  Future<AccountState> watch(int revision) async => AccountState.fromJson(
    accountMap(
      await _request(CoreMethod.accountWatch, {
        'revision': revision,
      }, const Duration(seconds: 35)),
    ),
  );
  @override
  Future<AccountSnapshot> snapshot() async => AccountSnapshot.fromPrivateJson(
    accountMap(await _request(CoreMethod.accountSnapshot)),
  );
  @override
  Future<AccountDeviceFlow> startDevice() async {
    _intent++;
    return AccountDeviceFlow.fromJson(
      accountMap(
        await _request(
          CoreMethod.accountDeviceStart,
          const {},
          const Duration(seconds: 60),
        ),
      ),
    );
  }

  @override
  Future<AccountDeviceEvent> pollDevice(String id) async =>
      AccountDeviceEvent.fromJson(
        accountMap(
          await _request(CoreMethod.accountDevicePoll, {
            'id': id,
          }, const Duration(seconds: 320)),
        ),
      );
  @override
  Future<void> cancelDevice(String id) async {
    await _request(CoreMethod.accountDeviceCancel, {'id': id});
  }

  @override
  Future<AccountCatalog> catalog(String isp) async =>
      AccountCatalog.fromPrivateJson(
        accountMap(await _request(CoreMethod.accountCatalog, {'isp': isp})),
      );
  @override
  Future<AccountNodeConfig> config(
    AccountNode node,
    AccountConfigOptions options,
  ) async => AccountNodeConfig.fromPrivateJson(
    accountMap(
      await _request(CoreMethod.accountConfig, {
        'node': node.toPrivateJson(),
        'options': options.toJson(),
      }),
    ),
  );
  @override
  Future<AccountProfile> buildProfile(List<AccountNodeConfig> configs) async =>
      AccountProfile.fromPrivateJson(
        accountMap(
          await _request(CoreMethod.accountBuildProfile, {
            'configs': configs.map((item) => item.toPrivateJson()).toList(),
          }),
        ),
      );
  @override
  Future<AccountState> suspend() async {
    _intent++;
    return AccountState.fromJson(
      accountMap(await _request(CoreMethod.accountSuspend)),
    );
  }

  @override
  Future<AccountState> logout() async {
    _intent++;
    return AccountState.fromJson(
      accountMap(await _request(CoreMethod.accountLogout)),
    );
  }

  @override
  Future<void> cancelPending() async {
    for (final id in _pending.toList()) {
      try {
        await _request(CoreMethod.accountCancel, {'id': id});
      } catch (_) {}
    }
  }
}
