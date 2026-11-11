part of '../action.dart';

@Riverpod(keepAlive: true)
ProtectedAccountStore privateAccountStore(Ref ref) => accountStore;

@Riverpod(keepAlive: true)
AccountService accountSessionService(Ref ref) => accountService;

@Riverpod(keepAlive: true)
ManagedAccount managedAccount(Ref ref) {
  final account = ManagedAccount(
    service: ref.read(accountSessionServiceProvider),
    repository: _ManagedRepository(ref),
  );
  ref.onDispose(account.dispose);
  ref.listen(appVisibleProvider, (_, visible) {
    if (visible) unawaited(account.refreshIfStale().catchError((Object _) {}));
  });
  return account;
}

class _ManagedRepository implements ManagedProfileRepository {
  final Ref ref;
  _ManagedRepository(this.ref);

  @override
  Profile? get profile => ref
      .read(profilesProvider)
      .where((profile) => profile.type == ProfileType.heysocks)
      .firstOrNull;

  @override
  bool get globalMode => ref.read(patchClashConfigProvider).mode == Mode.global;

  @override
  AccountConfigOptions get options => AccountConfigOptions(
    nameservers: ref.read(patchClashConfigProvider).dns.nameserver,
  );

  Future<File> _cache(int id) async =>
      File(join(await appPath.homeDirPath, 'heysocks-private', '$id.json'));

  @override
  Future<List<AccountNodeConfig>> readCache() async {
    final current = profile;
    if (current == null || current.managed?.requiresLogin != false) return [];
    try {
      final file = await _cache(current.id);
      if (!await file.exists()) return [];
      final value = accountMap(jsonDecode(await file.readAsString()));
      final yaml = File(await appPath.getProfilePath(current.id.toString()));
      if (!await yaml.exists() ||
          (await yaml.readAsString()).toMd5() != value['digest']) {
        return [];
      }
      return (value['configs'] as List)
          .map((item) => AccountNodeConfig.fromPrivateJson(accountMap(item)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> publish(
    ManagedPublication value,
    bool Function() isCurrent,
  ) async {
    final existing = profile;
    final id = existing?.id ?? snowflake.id;
    final cache = await _cache(id);
    final target = File(await appPath.getProfilePath(id.toString()));
    try {
      final yaml = await encodeYamlTask(value.config);
      final encoded = await compute(_encodeManagedCache, (
        yaml: yaml,
        configs: [for (final config in value.cache) config.toPrivateJson()],
      ));
      await publishManagedFiles(
        id: id,
        target: target,
        cache: cache,
        yaml: yaml,
        cacheJson: encoded,
        register: ref.read(privateAccountStoreProvider).registerPrivateProfile,
        validate: (path) =>
            ref.read(coreHandlerProvider).validateProfile(path, ''),
        isCurrent: isCurrent,
        expose: () async {
          final latest = profile;
          final selections = latest == null
              ? value.selections
              : preserveManagedSelection(
                  latest,
                  value.info.countryNames,
                  value.info.lineNames,
                  (value.config['proxy-groups'] as List)
                      .map(accountMap)
                      .toList(),
                );
          final info = value.info.copyWith(
            selectionRequired: managedSelectionRequired(
              selections,
              globalMode: globalMode,
            ),
          );
          final updated =
              (latest ??
                      Profile(
                        id: id,
                        type: ProfileType.heysocks,
                        label: managedRoot,
                        autoUpdate: false,
                        autoUpdateDuration: managedFullAge,
                      ))
                  .copyWith(
                    managed: info,
                    selectedMap: selections,
                    lastUpdateDate: DateTime.now(),
                  );
          await ref.read(profilesProvider.notifier).putManaged(updated);
        },
      );
      if (ref.read(currentProfileIdProvider) == null) {
        ref.read(currentProfileIdProvider.notifier).value = id;
      } else if (ref.read(currentProfileIdProvider) == id) {
        ref
            .read(setupActionProvider.notifier)
            .applyProfileDebounce(silence: true);
      }
    } on AccountFailure {
      rethrow;
    } catch (_) {
      throw const AccountFailure('publication_failed');
    }
  }

  @override
  Future<void> stop() async {
    if (ref.read(currentProfileProvider)?.type == ProfileType.heysocks) {
      await ref.read(setupActionProvider.notifier).setRunning(false);
    }
  }

  @override
  Future<void> apply() async {
    if (ref.read(currentProfileProvider)?.type == ProfileType.heysocks) {
      await ref.read(setupActionProvider.notifier).applyProfile(force: true);
    }
  }

  @override
  Future<void> clear() =>
      ref.read(setupActionProvider.notifier).clearManagedSetup(_clear);

  Future<void> _clear(bool ownedRuntime) async {
    final managed = ref
        .read(profilesProvider)
        .where((profile) => profile.type == ProfileType.heysocks)
        .toList();
    final ids = await ref.read(privateAccountStoreProvider).privateProfileIds();
    ids.addAll(managed.map((profile) => profile.id));
    final currentOwned = ids.contains(ref.read(currentProfileIdProvider));
    for (final id in ids) {
      await ref.read(privateAccountStoreProvider).registerPrivateProfile(id);
      await ref.read(profilesProvider.notifier).del(id);
      await ref.read(profilesActionProvider.notifier).clearEffect(id);
    }
    await Directory(
      join(await appPath.homeDirPath, 'heysocks-private'),
    ).safeDelete(recursive: true);
    if (currentOwned) {
      ref.read(currentProfileIdProvider.notifier).value = null;
    }
    if (currentOwned || ownedRuntime) {
      await File(await appPath.configFilePath).safeDelete();
      globalState.lastConfigMd5 = null;
      await preferences.saveAppliedConfigMd5(null);
      await preferences.saveShareState(ref.read(sharedStateProvider));
    }
  }
}

String _encodeManagedCache(
  ({String yaml, List<Map<String, dynamic>> configs}) value,
) => jsonEncode({'digest': value.yaml.toMd5(), 'configs': value.configs});
