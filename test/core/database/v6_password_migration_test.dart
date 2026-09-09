import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  group('Schema v6 password-column migration regression', () {
    late Directory tempDir;
    late File dbFile;
    late AppDatabase db;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('v6_migration_test');
      dbFile = File('${tempDir.path}/pre_v6.db');

      // Build a users table that predates the v6 password columns, plus the
      // minimum tables Drift expects to open the database, and mark the file
      // as user_version=5 so the v6 onUpgrade branch would normally be
      // skipped. The beforeOpen self-repair must still add the columns.
      final raw = sqlite.sqlite3.open(dbFile.path);
      raw.execute('''
        CREATE TABLE users (
          id TEXT PRIMARY KEY,
          username TEXT NOT NULL UNIQUE,
          full_name TEXT NOT NULL,
          role TEXT NOT NULL,
          password_hash TEXT NOT NULL,
          is_active INTEGER NOT NULL DEFAULT 1,
          created_at INTEGER NOT NULL,
          updated_at INTEGER
        )
      ''');
      raw.execute('PRAGMA user_version = 5');
      raw.execute('''
        INSERT INTO users (id, username, full_name, role, password_hash, is_active, created_at)
        VALUES ('legacy-1', 'legacy', 'Legacy User', 'CASHIER', 'oldsha256hash', 1, 0)
      ''');
      raw.close();

      db = AppDatabase(NativeDatabase(dbFile));
    });

    tearDown(() async {
      await db.close();
      await tempDir.delete(recursive: true);
    });

    test('beforeOpen adds password_salt and password_iterations', () async {
      final columns =
          (await db.customSelect("PRAGMA table_info('users')").get())
              .map((r) => r.read<String>('name'))
              .toSet();
      expect(columns, contains('password_salt'));
      expect(columns, contains('password_iterations'));

      // The legacy row must be preserved and the new columns must be null.
      final user = await db.getUserById('legacy-1');
      expect(user, isNotNull);
      expect(user!.username, 'legacy');
      expect(user.passwordHash, 'oldsha256hash');
      expect(user.passwordSalt, isNull);
      expect(user.passwordIterations, isNull);
    });
  });
}
