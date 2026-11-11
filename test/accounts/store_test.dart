import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/store.dart';
import 'package:fl_clash/common/backup.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

void main() {
  test(
    'protected store round trips complete session and keeps metadata separate',
    () async {
      final metadata = FakeMetadata();
      final secrets = FakeSecrets();
      final store = ProtectedAccountStore(secrets: secrets, metadata: metadata);
      final identity = await store.installIdentity();
      final epoch = await store.beginSession();
      await store.writeSession(testSnapshot(2, 1), epoch);
      final restored = await store.readSession();
      expect(
        restored!.snapshot.toPrivateJson()['session'],
        testSnapshot(2, 1).toPrivateJson()['session'],
      );
      expect(metadata.values.toString(), isNot(contains('synthetic-token')));
      await store.beginSession();
      await store.clearSession();
      expect(await store.installIdentity(), identity);
      final next = ProtectedAccountStore(secrets: secrets, metadata: metadata);
      expect(await next.installIdentity(), identity);
    },
  );
  test(
    'logout epoch blocks old session even when secret deletion fails',
    () async {
      final secrets = FakeSecrets();
      final store = ProtectedAccountStore(
        secrets: secrets,
        metadata: FakeMetadata(),
      );
      final epoch = await store.beginSession();
      await store.writeSession(testSnapshot(1, 1), epoch);
      await store.beginSession();
      secrets.fail = true;
      await expectLater(store.clearSession(), throwsA(isA<AccountFailure>()));
      expect(await store.readSession(), isNull);
      await expectLater(
        store.writeSession(testSnapshot(2, 1), epoch),
        throwsA(
          isA<AccountFailure>().having(
            (error) => error.kind,
            'kind',
            'superseded',
          ),
        ),
      );
    },
  );
  test('missing and corrupt secrets produce distinct safe outcomes', () async {
    final secrets = FakeSecrets();
    final store = ProtectedAccountStore(
      secrets: secrets,
      metadata: FakeMetadata(),
    );
    expect(await store.readSession(), isNull);
    secrets.value = 'synthetic-secret malformed JSON';
    await expectLater(
      store.readSession(),
      throwsA(
        isA<AccountFailure>().having(
          (error) => error.kind,
          'kind',
          'corrupt_storage',
        ),
      ),
    );
  });
  test(
    'store failure and silent write loss have no plaintext fallback',
    () async {
      final metadata = FakeMetadata();
      final secrets = FakeSecrets();
      final store = ProtectedAccountStore(secrets: secrets, metadata: metadata);
      final epoch = await store.beginSession();
      for (final failure in [true, false]) {
        secrets.fail = failure;
        secrets.dropWrite = !failure;
        await expectLater(
          store.writeSession(testSnapshot(1, 1), epoch),
          throwsA(
            isA<AccountFailure>().having(
              (error) => error.toString(),
              'redaction',
              isNot(contains('synthetic-secret')),
            ),
          ),
        );
        expect(secrets.value, isNull);
        expect(metadata.values.toString(), isNot(contains('synthetic-token')));
      }
    },
  );
  test('session payload bounds fail before platform storage', () async {
    final secrets = FakeSecrets();
    final store = ProtectedAccountStore(
      secrets: secrets,
      metadata: FakeMetadata(),
    );
    final epoch = await store.beginSession();
    final huge = testSnapshot(1, 1, 'x' * accountSessionLimit);
    await expectLater(
      store.writeSession(huge, epoch),
      throwsA(
        isA<AccountFailure>().having(
          (error) => error.kind,
          'kind',
          'size_limit',
        ),
      ),
    );
    expect(secrets.value, isNull);
  });
  test(
    'private profiles are registered before ordinary backup enumeration',
    () async {
      final store = ProtectedAccountStore(
        secrets: FakeSecrets(),
        metadata: FakeMetadata(),
      );
      await store.registerPrivateProfile(7);
      await store.registerPrivateProfile(9);
      final entries = BackupEntries.of(
        profileIds: [1, 7, 9],
        privateProfileIds: await store.privateProfileIds(),
        scriptIds: [],
        providers: [],
      );
      expect(entries, [BackupEntries.profile(1)]);
    },
  );
}
