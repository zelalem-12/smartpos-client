import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  group('Phase 10 column migration regression', () {
    late Directory tempDir;
    late File dbFile;
    late AppDatabase db;
    late int legacyCreatedAtSeconds;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('phase10_migration_test');
      dbFile = File('${tempDir.path}/pre_v5.db');

      // Create a file-backed legacy schema with PRAGMA user_version=5 but
      // without the Phase 10 columns added to sync_queue and audit_logs.
      final raw = sqlite.sqlite3.open(dbFile.path);
      raw.execute('''
        CREATE TABLE sync_queue (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          invoice_id INTEGER NOT NULL,
          operation TEXT NOT NULL,
          status TEXT NOT NULL DEFAULT 'PENDING',
          payload TEXT NOT NULL,
          retry_count INTEGER NOT NULL DEFAULT 0,
          created_at INTEGER NOT NULL
        )
      ''');
      raw.execute('''
        CREATE TABLE audit_logs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          action TEXT NOT NULL,
          invoice_id INTEGER,
          user_id TEXT NOT NULL,
          details TEXT NOT NULL,
          previous_hash TEXT NOT NULL,
          current_hash TEXT NOT NULL,
          created_at INTEGER NOT NULL
        )
      ''');
      raw.execute('PRAGMA user_version = 5');

      // Drift stores dateTime() columns as Unix timestamps in seconds.
      legacyCreatedAtSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      raw.execute('''
        INSERT INTO sync_queue (invoice_id, operation, status, payload, retry_count, created_at)
        VALUES (1, 'CREATE_INVOICE', 'PENDING', '{"number":1}', 0, $legacyCreatedAtSeconds)
      ''');
      raw.close();

      // Opening AppDatabase on this file should trigger beforeOpen and add the
      // missing columns (last_error, updated_at, last_attempt_at, synced_at,
      // payload) even though user_version is already 5.
      db = AppDatabase(NativeDatabase(dbFile));
    });

    tearDown(() async {
      await db.close();
      await tempDir.delete(recursive: true);
    });

    test('beforeOpen repairs missing columns and getAllSyncQueue preserves the row', () async {
      final syncColumns =
          (await db.customSelect("PRAGMA table_info('sync_queue')").get())
              .map((r) => r.read<String>('name'))
              .toSet();
      expect(syncColumns, contains('last_error'));
      expect(syncColumns, contains('updated_at'));
      expect(syncColumns, contains('last_attempt_at'));
      expect(syncColumns, contains('synced_at'));

      final auditColumns =
          (await db.customSelect("PRAGMA table_info('audit_logs')").get())
              .map((r) => r.read<String>('name'))
              .toSet();
      expect(auditColumns, contains('payload'));

      // This call exercises every new sync_queue column; it must not throw.
      final queue = await db.getAllSyncQueue();
      expect(queue, hasLength(1));

      final row = queue.first;
      expect(row.operation, 'CREATE_INVOICE');
      expect(row.status, 'PENDING');
      expect(row.payload, '{"number":1}');
      expect(row.retryCount, 0);
      expect(
        row.createdAt.millisecondsSinceEpoch,
        legacyCreatedAtSeconds * 1000,
      );

      // updated_at should have been back-filled from created_at.
      expect(
        row.updatedAt.millisecondsSinceEpoch,
        legacyCreatedAtSeconds * 1000,
      );
      expect(row.lastError, isNull);
      expect(row.lastAttemptAt, isNull);
      expect(row.syncedAt, isNull);
    });
  });
}
