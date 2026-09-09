import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/sync_queue_table.dart';

part 'sync_queue_dao.g.dart';

/// Data access for the sync queue table.
@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<List<SyncQueueData>> getAllSyncQueue({bool newestFirst = true}) {
    return (select(syncQueue)..orderBy([
          (s) => OrderingTerm(
            expression: s.createdAt,
            mode: newestFirst ? OrderingMode.desc : OrderingMode.asc,
          ),
          (s) => OrderingTerm(
            expression: s.id,
            mode: newestFirst ? OrderingMode.desc : OrderingMode.asc,
          ),
        ]))
        .get();
  }

  Future<List<SyncQueueData>> getActionableSyncQueue() {
    return (select(syncQueue)
          ..where((q) => q.status.equals('PENDING') | q.status.equals('FAILED'))
          ..orderBy([
            (q) => OrderingTerm.asc(q.createdAt),
            (q) => OrderingTerm.asc(q.id),
          ]))
        .get();
  }

  Future<SyncQueueData?> getSyncQueueById(int id) {
    return (select(syncQueue)..where((q) => q.id.equals(id))).getSingleOrNull();
  }

  Future<SyncQueueData?> getOldestUnsynced() {
    return (select(syncQueue)
          ..where((q) => q.status.equals('SYNCED').not())
          ..orderBy([(q) => OrderingTerm.asc(q.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> updateSyncQueueById(int id, SyncQueueCompanion companion) {
    return (update(syncQueue)..where((q) => q.id.equals(id))).write(companion);
  }

  Future<int> countSyncQueueByStatus(String status) async {
    final count = syncQueue.id.count();
    final row =
        await (selectOnly(syncQueue)
              ..where(syncQueue.status.equals(status))
              ..addColumns([count]))
            .getSingle();
    return row.read(count) ?? 0;
  }
}
