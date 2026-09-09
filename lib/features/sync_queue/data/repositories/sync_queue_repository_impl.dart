import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sync_queue_entry.dart';
import '../../domain/repositories/sync_queue_repository.dart';

class SyncQueueRepositoryImpl implements SyncQueueRepository {
  final AppDatabase _db;
  final Dio _dio;
  final NetworkInfo _networkInfo;

  SyncQueueRepositoryImpl(this._db, this._dio, this._networkInfo);

  @override
  Future<List<SyncQueueEntry>> getQueue({bool newestFirst = true}) async {
    final rows = await _db.getAllSyncQueue(newestFirst: newestFirst);
    return rows.map(_mapRow).toList();
  }

  @override
  Future<List<SyncQueueEntry>> getActionableEntries() async {
    final rows = await _db.getActionableSyncQueue();
    return rows.map(_mapRow).toList();
  }

  @override
  Future<void> retry(int id) async {
    if (!await isOnline()) {
      throw StateError(
        'Device is offline. Sync is disabled until connectivity is restored.',
      );
    }
    final row = await _db.getSyncQueueById(id);
    if (row == null) return;
    if (row.status != 'PENDING' && row.status != 'FAILED') return;
    await _processRow(row);
  }

  @override
  Future<SyncSummary> syncAll() async {
    final online = await isOnline();
    if (!online) {
      return const SyncSummary(
        processed: 0,
        failed: 0,
        error: 'Device is offline. Sync is disabled until connectivity is restored.',
      );
    }

    final entries = await getActionableEntries();
    if (entries.isEmpty) {
      return const SyncSummary(processed: 0, failed: 0);
    }

    var processed = 0;
    var failed = 0;
    String? lastError;

    for (final entry in entries) {
      try {
        await _processRow(_toData(entry));
        processed++;
      } on Exception catch (e) {
        failed++;
        lastError = e.toString();
      }
    }

    return SyncSummary(processed: processed, failed: failed, error: lastError);
  }

  @override
  Future<bool> isOnline() => _networkInfo.isOnline;

  @override
  Future<Duration?> oldestUnsyncedAge() async {
    final oldest = await _db.getOldestUnsynced();
    if (oldest == null) return null;
    return DateTime.now().difference(oldest.createdAt);
  }

  Future<void> _processRow(SyncQueueData row) async {
    final now = DateTime.now();

    // Mark as processing before the network call.
    await _db.updateSyncQueueById(
      row.id,
      SyncQueueCompanion(
        status: const Value('PROCESSING'),
        updatedAt: Value(now),
        lastAttemptAt: Value(now),
      ),
    );

    try {
      await _dio.post(
        ApiEndpoints.sync,
        data: jsonEncode({'operation': row.operation, 'payload': row.payload}),
      );

      await _db.updateSyncQueueById(
        row.id,
        SyncQueueCompanion(
          status: const Value('SYNCED'),
          retryCount: Value(row.retryCount),
          lastError: const Value(null),
          updatedAt: Value(DateTime.now()),
          syncedAt: Value(DateTime.now()),
        ),
      );
    } on Exception catch (e) {
      await _db.updateSyncQueueById(
        row.id,
        SyncQueueCompanion(
          status: const Value('FAILED'),
          retryCount: Value(row.retryCount + 1),
          lastError: Value(_errorMessage(e)),
          updatedAt: Value(DateTime.now()),
        ),
      );
      rethrow;
    }
  }

  static SyncQueueEntry _mapRow(SyncQueueData row) => SyncQueueEntry(
    id: row.id,
    invoiceId: row.invoiceId,
    operation: row.operation,
    status: row.status,
    payload: row.payload,
    retryCount: row.retryCount,
    lastError: row.lastError,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    lastAttemptAt: row.lastAttemptAt,
    syncedAt: row.syncedAt,
  );

  static SyncQueueData _toData(SyncQueueEntry entry) => SyncQueueData(
    id: entry.id,
    invoiceId: entry.invoiceId,
    operation: entry.operation,
    status: entry.status,
    payload: entry.payload,
    retryCount: entry.retryCount,
    lastError: entry.lastError,
    createdAt: entry.createdAt,
    updatedAt: entry.updatedAt,
    lastAttemptAt: entry.lastAttemptAt,
    syncedAt: entry.syncedAt,
  );

  static String _errorMessage(Object e) {
    if (e is DioException) {
      return e.message ?? 'Network request failed';
    }
    return e.toString();
  }
}
