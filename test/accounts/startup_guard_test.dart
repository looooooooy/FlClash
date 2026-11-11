import 'dart:async';

import 'package:fl_clash/accounts/service.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import '../helpers/test_profiles.dart';
import 'fakes.dart';

class _GatedStore extends FakeStore {
  final entered = Completer<void>();
  final release = Completer<void>();
  @override
  Future<String> installIdentity() async {
    entered.complete();
    await release.future;
    return 'synthetic-install';
  }
}

class _GuardedSetup extends SetupAction {
  final calls = <bool>[];
  @override
  Future<void> setCoreRunning(bool running) async {
    calls.add(running);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'cached managed auto-start waits for restoration and refuses absent session',
    () async {
      await AppLocalizations.load(const Locale('en'));
      final store = _GatedStore();
      final service = AccountService(gateway: FakeGateway(), store: store);
      final setup = _GuardedSetup();
      final container = ProviderContainer(
        overrides: [
          profilesProvider.overrideWith(
            () => TestProfiles([
              const Profile(
                id: 77,
                type: ProfileType.heysocks,
                autoUpdateDuration: Duration.zero,
                managed: ManagedProfileInfo(requiresLogin: false),
              ),
            ]),
          ),
          currentProfileIdProvider.overrideWithBuild((_, _) => 77),
          accountSessionServiceProvider.overrideWith((_) => service),
          setupActionProvider.overrideWith(() => setup),
        ],
      );
      globalState.container = container;
      final start = container
          .read(setupActionProvider.notifier)
          .setRunning(true, initialize: true);
      final assertion = expectLater(start, throwsA(isA<MessageException>()));
      await store.entered.future;
      expect(setup.calls, isEmpty);
      store.release.complete();
      await assertion;
      expect(setup.calls, isEmpty);
      expect(container.read(isStartProvider), isFalse);
      container.dispose();
      await service.dispose();
    },
  );
}
