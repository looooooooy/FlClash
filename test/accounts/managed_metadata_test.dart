import 'dart:convert';
import 'package:drift/native.dart';
import 'package:fl_clash/common/backup.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  test(
    'legacy profile JSON stays compatible and managed metadata round trips',
    () {
      final legacy = const Profile(
        id: 1,
        autoUpdateDuration: Duration.zero,
      ).toJson()..remove('managed');
      expect(Profile.fromJson(jsonDecode(jsonEncode(legacy))).managed, isNull);
      const managed = Profile(
        id: 2,
        type: ProfileType.heysocks,
        autoUpdateDuration: Duration(hours: 12),
        managed: ManagedProfileInfo(
          lineNames: {'stable': 'Line'},
          countryNames: {'ZZ': 'Country'},
        ),
      );
      expect(
        Profile.fromJson(jsonDecode(jsonEncode(managed.toJson()))),
        managed,
      );
      expect(
        BackupEntries.ofData(const MigrationData(profiles: [managed])),
        isEmpty,
      );
    },
  );
  test(
    'schema 23 upgrades with safe null metadata and preserves static profiles',
    () async {
      final raw = sqlite.sqlite3.openInMemory();
      final original = Database(
        NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
      );
      await original.profiles.put(
        const Profile(id: 1, autoUpdateDuration: Duration.zero).toCompanion(),
      );
      await original.close();
      raw.execute('ALTER TABLE profiles DROP COLUMN managed');
      raw.execute('PRAGMA user_version = 23');
      final upgraded = Database(NativeDatabase.opened(raw));
      final profile = await upgraded.profilesDao.get(1);
      expect(profile!.type, ProfileType.file);
      expect(profile.managed, isNull);
      final managed = profile.copyWith(
        type: ProfileType.heysocks,
        managed: const ManagedProfileInfo(),
      );
      await upgraded.profiles.put(managed.toCompanion());
      expect(await upgraded.profilesDao.get(1), managed);
      expect(upgraded.schemaVersion, 24);
      await upgraded.close();
    },
  );
}
