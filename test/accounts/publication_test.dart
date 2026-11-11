import 'dart:async';
import 'dart:io';

import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/publication.dart';
import 'package:fl_clash/common/backup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory directory;
  late File target;
  late File cache;
  setUp(() {
    directory = Directory.systemTemp.createTempSync('managed-publication-');
    target = File('${directory.path}/profiles/7.yaml');
    cache = File('${directory.path}/private/7.json');
  });
  tearDown(() => directory.deleteSync(recursive: true));

  test(
    'registry is durable before row is visible to backup enumeration',
    () async {
      final registry = <int>{};
      final rows = <int>[];
      final entered = Completer<void>();
      final release = Completer<void>();
      final operation = publishManagedFiles(
        id: 7,
        target: target,
        cache: cache,
        yaml: 'synthetic-private',
        cacheJson: 'synthetic-cache',
        register: (id) async {
          entered.complete();
          await release.future;
          registry.add(id);
        },
        validate: (_) async => null,
        isCurrent: () => true,
        expose: () async {
          rows.add(7);
          expect(registry, contains(7));
          expect(
            BackupEntries.of(
              profileIds: rows,
              privateProfileIds: registry,
              scriptIds: [],
              providers: [],
            ),
            isEmpty,
          );
        },
      );
      await entered.future;
      expect(rows, isEmpty);
      expect(await target.exists(), isFalse);
      release.complete();
      await operation;
      expect(rows, [7]);
    },
  );
  test('validation failure retains previous valid config and cache', () async {
    target.parent.createSync(recursive: true);
    cache.parent.createSync(recursive: true);
    target.writeAsStringSync('previous');
    cache.writeAsStringSync('previous-cache');
    await expectLater(
      publishManagedFiles(
        id: 7,
        target: target,
        cache: cache,
        yaml: 'invalid',
        cacheJson: 'new-cache',
        register: (_) async {},
        validate: (_) async => 'sensitive parser detail',
        expose: () async {},
        isCurrent: () => true,
      ),
      throwsA(
        isA<AccountFailure>().having(
          (e) => e.kind,
          'safe kind',
          'invalid_config',
        ),
      ),
    );
    expect(target.readAsStringSync(), 'previous');
    expect(cache.readAsStringSync(), 'previous-cache');
  });
  test('database publication failure rolls back both private files', () async {
    target.parent.createSync(recursive: true);
    cache.parent.createSync(recursive: true);
    target.writeAsStringSync('previous');
    cache.writeAsStringSync('previous-cache');
    await expectLater(
      publishManagedFiles(
        id: 7,
        target: target,
        cache: cache,
        yaml: 'next',
        cacheJson: 'next-cache',
        register: (_) async {},
        validate: (_) async => null,
        expose: () async => throw StateError('database failure'),
        isCurrent: () => true,
      ),
      throwsStateError,
    );
    expect(target.readAsStringSync(), 'previous');
    expect(cache.readAsStringSync(), 'previous-cache');
    expect(cache.parent.listSync().length, 1);
  });
  test(
    'logout while validation is pending never exposes a row or YAML',
    () async {
      var current = true;
      var exposed = false;
      final entered = Completer<void>();
      final release = Completer<void>();
      final operation = publishManagedFiles(
        id: 7,
        target: target,
        cache: cache,
        yaml: 'synthetic-private',
        cacheJson: 'synthetic-cache',
        register: (_) async {},
        validate: (_) async {
          entered.complete();
          await release.future;
          return null;
        },
        expose: () async {
          exposed = true;
        },
        isCurrent: () => current,
      );
      final assertion = expectLater(operation, throwsA(isA<AccountFailure>()));
      await entered.future;
      current = false;
      release.complete();
      await assertion;
      expect(exposed, isFalse);
      expect(await target.exists(), isFalse);
    },
  );
}
