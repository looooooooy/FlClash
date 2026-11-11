import 'dart:convert';

import 'package:fl_clash/accounts/device_name.dart';
import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/rpc.dart';
import 'package:fl_clash/core/desktop/model.dart';
import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/core/lib.dart';
import 'package:fl_clash/core/method.dart';
import 'package:fl_clash/core/spill.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:flutter_test/flutter_test.dart';

class RecordingCore extends CoreHandlerInterface {
  final List<({CoreMethod method, Object? arguments, Duration? timeout})>
  calls = [];
  Object? result;
  bool fail = false;
  @override
  Future<Object?> invokeMethod({
    required CoreMethod method,
    Object? arguments,
    Duration? timeout,
  }) async {
    calls.add((method: method, arguments: arguments, timeout: timeout));
    if (fail) throw const FormatException('synthetic-private-token');
    return result;
  }

  @override
  Future<CoreLifecycleResult> start() =>
      throw StateError('account must not start lifecycle');
  @override
  Future<CoreLifecycleResult> restart() => start();
  @override
  Future<CoreLifecycleResult> stop() => start();
  @override
  Future<CoreLifecycleResult> close() => start();
}

class UnstartedService extends Fake implements Service {
  int invocations = 0;
  @override
  Future<CoreMethodResponse> invokeMethod(CoreMethodCall call) async {
    invocations++;
    return const CoreMethodResponse(result: {'value': true});
  }
}

void main() {
  test(
    'account bootstrap uses existing RPC without network lifecycle commands',
    () async {
      final core = RecordingCore()
        ..result = {
          'value': {
            'lease': 1,
            'state': {'revision': 0, 'generation': 0, 'authenticated': false},
          },
        };
      final gateway = CoreAccountGateway(
        core,
        platform: 'android',
        deviceName: () async => '我的 vivo X200 Ultra',
      );
      await gateway.initialize('synthetic-install');
      expect(core.calls.single.method, CoreMethod.accountInitialize);
      expect(
        (core.calls.single.arguments as Map)['deviceId'],
        'synthetic-install',
      );
      expect(
        (core.calls.single.arguments as Map)['deviceName'],
        '我的 vivo X200 Ultra',
      );
      core.result = {
        'value': {
          'type': 'code',
          'code': 'synthetic-code',
          'state': {'revision': 1, 'generation': 1, 'authenticated': false},
        },
      };
      final event = await gateway.pollDevice('synthetic-flow');
      expect(core.calls.last.timeout, const Duration(seconds: 320));
      expect(event.toString(), isNot(contains('synthetic-code')));
    },
  );
  test('device name stays within the Core limit without splitting Unicode', () {
    final name = normalizedAccountDeviceName('云' * 100, 'windows');
    expect(name, '云' * 85);
    expect(utf8.encode(name).length, lessThanOrEqualTo(256));
    expect(normalizedAccountDeviceName('  \n', 'windows'), 'windows');
  });
  test(
    'Android account RPC works before Core start or VPN permission',
    () async {
      final service = UnstartedService();
      final core = CoreLib.scoped(service);
      final response = await core.invokeAccountMethod(
        method: CoreMethod.accountState,
        arguments: {},
      );
      expect(response, {'value': true});
      expect(service.invocations, 1);
    },
  );
  test('transport exceptions never expose private values', () async {
    final core = RecordingCore()..fail = true;
    final gateway = CoreAccountGateway(core, platform: 'android');
    await expectLater(
      gateway.login('synthetic@example.test', 'synthetic-password'),
      throwsA(
        isA<AccountFailure>().having(
          (error) => error.toString(),
          'redacted',
          isNot(contains('synthetic')),
        ),
      ),
    );
  });
  test(
    'captcha is typed separately and never in safe error formatting',
    () async {
      final core = RecordingCore()
        ..result = {
          'failure': {'kind': 'captcha_required'},
          'challenge': {
            'id': 'pending',
            'url': 'https://example.test/?secret=synthetic-token',
            'operation': 'login',
          },
        };
      final gateway = CoreAccountGateway(core, platform: 'android');
      await expectLater(
        gateway.catalog(''),
        throwsA(
          isA<AccountChallengeRequired>()
              .having(
                (error) => error.toString(),
                'redacted',
                isNot(contains('synthetic-token')),
              )
              .having(
                (error) => error.challenge.url.host,
                'private challenge',
                'example.test',
              ),
        ),
      );
    },
  );
  test('private response refuses generic spilled-file reading', () async {
    final response = await resolveSpilledResponse(
      const CoreMethodResponse(file: '/synthetic-private-path'),
      method: CoreMethod.accountSnapshot,
    );
    expect(response.error!.code, 'private_spill_refused');
    expect(response.error!.message, isNot(contains('/synthetic')));
  });
  test('closed Android Core refuses further private RPCs', () async {
    final service = UnstartedService();
    final core = CoreLib.scoped(service);
    await core.close();
    await expectLater(
      core.invokeAccountMethod(method: CoreMethod.accountState, arguments: {}),
      throwsA(isA<CoreMethodException>()),
    );
    expect(service.invocations, 0);
  });
}
