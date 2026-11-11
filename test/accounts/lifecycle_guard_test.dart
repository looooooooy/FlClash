import 'dart:async';
import 'dart:io';

import 'package:fl_clash/accounts/managed.dart';
import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/service.dart';
import 'package:fl_clash/accounts/store.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import '../helpers/app_paths.dart';
import '../helpers/preferences.dart';
import '../helpers/test_profiles.dart';
import 'fakes.dart';

const _profile = Profile(
  id: 71,
  type: ProfileType.heysocks,
  autoUpdateDuration: Duration.zero,
  managed: ManagedProfileInfo(requiresLogin: false),
  selectedMap: {'GLOBAL': 'b', managedRoot: 'A', 'A': 'a', 'B': 'b'},
);
const _state = SetupState(
  profileId: 71,
  profileLastUpdateDate: null,
  profileType: ProfileType.heysocks,
  extendType: ExtendType.standard,
  rules: [],
  proxyGroups: [],
  addedRules: [],
  script: null,
  overrides: ProfileOverrides(),
);

class _UnusedRepository extends Fake implements ManagedProfileRepository {}

class _ModeManager extends ManagedAccount {
  final modes = <bool?>[];
  Completer<void>? gate;
  AccountFailure? failure;
  _ModeManager(AccountService service)
    : super(service: service, repository: _UnusedRepository());
  @override
  Future<void> ensureUsable({
    String? group,
    String? target,
    bool? globalMode,
  }) async {
    modes.add(globalMode);
    await gate?.future;
    if (failure case final error?) throw error;
  }
}

class _QuietCommon extends CommonAction {
  @override
  Future<void> updateTraffic() async {}
}

class _ModeSetup extends SetupAction {
  final modesAtApply = <Mode>[];
  Completer<void>? applyGate;
  Completer<void>? applyEntered;
  @override
  Future<bool> applyProfile({
    bool silence = false,
    bool force = false,
    Future<void> Function()? preloadInvoke,
  }) async {
    modesAtApply.add(ref.read(patchClashConfigProvider).mode);
    applyEntered?.complete();
    await applyGate?.future;
    await preloadInvoke?.call();
    return true;
  }

  @override
  Future<void> setCoreRunning(bool running) async {}
  @override
  void resetCoreTraffic() {}
}

class _Registry extends Fake implements ProtectedAccountStore {
  final ids = <int>{71};
  @override
  Future<Set<int>> privateProfileIds() async => {...ids};
  @override
  Future<void> registerPrivateProfile(int id) async {
    ids.add(id);
  }
}

class _GatedCore extends Fake implements CoreHandlerInterface {
  final entered = Completer<void>();
  final release = Completer<void>();
  var calls = 0;
  @override
  Future<void> setupConfig(SetupParams params) async {
    calls++;
    entered.complete();
    await release.future;
    // Emulate Core completing its runtime-file write after logout begins.
    await File(
      await appPath.configFilePath,
    ).writeAsString('synthetic-managed-config');
  }

  @override
  Future<void> clearEffect(int id) async {}
}

class _CleanupSetup extends SetupAction {
  final cleanupRequested = Completer<void>();
  final buildEntered = Completer<void>();
  final writeEntered = Completer<void>();
  Completer<void>? buildGate;
  Completer<void>? writeGate;
  var stops = 0;
  @override
  Future<void> setCoreRunning(bool running) async {
    if (!running) stops++;
  }

  @override
  void resetCoreTraffic() {}
  @override
  Future<void> writeRuntimeConfig(String path, String yaml) async {
    if (writeGate != null) {
      writeEntered.complete();
      await writeGate!.future;
    }
    await super.writeRuntimeConfig(path, yaml);
  }

  @override
  Future<BuiltProfile> getProfile({
    required SetupState setupState,
    required PatchClashConfig patchConfig,
  }) async {
    buildEntered.complete();
    await buildGate?.future;
    return (
      yaml: 'synthetic-managed-config',
      md5: 'synthetic-managed-digest',
      counts: configCountsOf(const {}),
      base: null,
    );
  }

  @override
  Future<void> clearManagedSetup(Future<void> Function(bool) clear) {
    final result = super.clearManagedSetup(clear);
    cleanupRequested.complete();
    return result;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  late AccountService service;
  setUp(() async {
    directory = Directory.systemTemp.createTempSync('managed-lifecycle-test');
    await useAppPaths(directory);
    await mockPreferences();
    await AppLocalizations.load(const Locale('en'));
    globalState.lastConfigMd5 = null;
    service = AccountService(gateway: FakeGateway(), store: FakeStore());
    await service.login('synthetic@example.test', 'synthetic');
  });
  tearDown(() async {
    await service.dispose();
    globalState.lastConfigMd5 = null;
    directory.deleteSync(recursive: true);
  });

  for (final scenario in [
    'success',
    'cycle',
    'failure',
    'newer-mode',
    'newer-apply',
    'stop',
  ]) {
    test(
      'running mode switch $scenario preflights before changing active mode',
      () async {
        final successful = scenario == 'success' || scenario == 'cycle';
        final manager = _ModeManager(service);
        final setup = _ModeSetup();
        final container = ProviderContainer(
          overrides: [
            profilesProvider.overrideWith(() => TestProfiles([_profile])),
            currentProfileIdProvider.overrideWithBuild((_, _) => 71),
            accountSessionServiceProvider.overrideWith((_) => service),
            managedAccountProvider.overrideWith((_) => manager),
            setupActionProvider.overrideWith(() => setup),
            commonActionProvider.overrideWith(_QuietCommon.new),
            safeModeProvider.overrideWithValue(true),
          ],
        );
        globalState.container = container;
        container.read(setupActionProvider.notifier);
        await setup.setRunning(true, initialize: true);
        manager.modes.clear();
        setup.modesAtApply.clear();
        manager.gate = Completer<void>();
        final switching = scenario == 'cycle'
            ? container.read(commonActionProvider.notifier).updateMode()
            : setup.changeMode(Mode.global);
        await Future<void>.delayed(Duration.zero);
        expect(manager.modes, [true]);
        expect(container.read(patchClashConfigProvider).mode, Mode.rule);
        expect(setup.modesAtApply, isEmpty);
        if (scenario == 'failure') {
          manager.failure = const AccountFailure('invalid_response');
        }
        if (scenario == 'newer-mode') await setup.changeMode(Mode.direct);
        if (scenario == 'stop') await setup.setRunning(false);
        if (successful || scenario == 'newer-apply') {
          setup.applyGate = Completer<void>();
          setup.applyEntered = Completer<void>();
        }
        manager.gate!.complete();
        if (setup.applyGate != null) {
          await setup.applyEntered!.future;
          expect(container.read(patchClashConfigProvider).mode, Mode.rule);
          if (scenario == 'newer-apply') await setup.changeMode(Mode.direct);
          setup.applyGate!.complete();
        }
        await switching;
        expect(
          container.read(patchClashConfigProvider).mode,
          successful
              ? Mode.global
              : scenario == 'newer-mode' || scenario == 'newer-apply'
              ? Mode.direct
              : Mode.rule,
        );
        expect(
          setup.modesAtApply,
          successful || scenario == 'newer-apply' ? [Mode.rule] : isEmpty,
        );
        await setup.setRunning(false);
        container.dispose();
        manager.dispose();
      },
    );
  }

  for (final phase in [
    'build',
    'core',
    'core-with-static-selected',
    'write-with-static-selected',
    'adopted-with-static-selected',
  ]) {
    test(
      'logout drains $phase setup before final private runtime cleanup',
      () async {
        final core = _GatedCore();
        final setup = _CleanupSetup();
        if (phase == 'build') setup.buildGate = Completer<void>();
        if (phase == 'write-with-static-selected') {
          setup.writeGate = Completer<void>();
        }
        const staticProfile = Profile(
          id: 99,
          autoUpdateDuration: Duration.zero,
        );
        final registry = _Registry();
        final container = ProviderContainer(
          overrides: [
            profilesProvider.overrideWith(
              () => TestProfiles([_profile, staticProfile]),
            ),
            currentProfileIdProvider.overrideWithBuild((_, _) => 71),
            accountSessionServiceProvider.overrideWith((_) => service),
            privateAccountStoreProvider.overrideWith((_) => registry),
            setupActionProvider.overrideWith(() => setup),
            commonActionProvider.overrideWith(_QuietCommon.new),
            setupStateProvider.overrideWith((_, _) => _state),
            coreHandlerProvider.overrideWithValue(CoreController.scoped(core)),
          ],
        );
        globalState.container = container;
        container.listen(currentProfileProvider, (_, _) {});
        container.read(managedAccountProvider);
        final adopted = phase == 'adopted-with-static-selected';
        if (adopted) {
          globalState.lastConfigMd5 = 'synthetic-managed-digest';
          await File(
            await appPath.configFilePath,
          ).writeAsString('synthetic-managed-config');
        }
        final applying = container
            .read(setupActionProvider.notifier)
            .applyProfile(force: !adopted);
        if (adopted) {
          expect(await applying, isTrue);
        } else if (phase == 'build') {
          await setup.buildEntered.future;
        } else if (setup.writeGate != null) {
          await setup.writeEntered.future;
        } else {
          await core.entered.future;
        }
        if (phase.endsWith('static-selected')) {
          container.read(currentProfileIdProvider.notifier).value = 99;
        }
        var loggedOut = false;
        final logout = service.logout().then((_) {
          loggedOut = true;
        });
        await setup.cleanupRequested.future;
        if (!adopted) expect(loggedOut, isFalse);
        if (phase == 'build') {
          setup.buildGate!.complete();
        } else if (setup.writeGate != null) {
          setup.writeGate!.complete();
        } else if (!adopted) {
          core.release.complete();
        }
        expect(await applying, adopted);
        await logout;
        expect(core.calls, phase.startsWith('core') ? 1 : 0);
        expect(await File(await appPath.configFilePath).exists(), isFalse);
        expect(globalState.lastConfigMd5, isNull);
        expect(await preferences.getAppliedConfigMd5(), isNull);
        expect(container.read(profilesProvider).map((p) => p.id), [99]);
        expect(registry.ids, contains(71));
        expect(
          container.read(currentProfileIdProvider),
          phase.endsWith('static-selected') ? 99 : null,
        );
        expect(setup.stops, greaterThan(0));
        container.dispose();
      },
    );
  }
}
