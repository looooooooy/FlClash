import 'dart:io';

import 'package:fl_clash/common/file.dart';

import 'models.dart';

Future<void> publishManagedFiles({
  required int id,
  required File target,
  required File cache,
  required String yaml,
  required String cacheJson,
  required Future<void> Function(int id) register,
  required Future<String?> Function(String path) validate,
  required Future<void> Function() expose,
  required bool Function() isCurrent,
}) async {
  final staging = File('${cache.path}.staging');
  final oldTarget = File('${cache.path}.previous-yaml');
  final oldCache = File('${cache.path}.previous-cache');
  var replaced = false;
  var hadTarget = false;
  var hadCache = false;
  void check() {
    if (!isCurrent()) throw const AccountFailure('superseded');
  }

  try {
    await register(id);
    check();
    await staging.parent.create(recursive: true);
    await staging.writeAsString(yaml, flush: true);
    if (await validate(staging.path) != null) {
      throw const AccountFailure('invalid_config');
    }
    check();
    hadTarget = await target.exists();
    hadCache = await cache.exists();
    if (hadTarget) await target.copy(oldTarget.path);
    if (hadCache) await cache.copy(oldCache.path);
    check();
    replaced = true;
    await cache.writeAsStringAtomically(cacheJson);
    check();
    await target.parent.create(recursive: true);
    await staging.rename(target.path);
    check();
    await expose();
    check();
  } catch (_) {
    if (replaced) {
      if (hadTarget) {
        await oldTarget.rename(target.path);
      } else {
        await target.safeDelete();
      }
      if (hadCache) {
        await oldCache.rename(cache.path);
      } else {
        await cache.safeDelete();
      }
    }
    rethrow;
  } finally {
    await staging.safeDelete();
    await oldTarget.safeDelete();
    await oldCache.safeDelete();
  }
}
