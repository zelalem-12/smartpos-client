import '../entities/sync_queue_entry.dart';
import '../repositories/sync_queue_repository.dart';

/// Lists all sync queue entries, newest first by default.
class GetSyncQueue {
  final SyncQueueRepository repository;
  const GetSyncQueue(this.repository);

  Future<List<SyncQueueEntry>> call({bool newestFirst = true}) =>
      repository.getQueue(newestFirst: newestFirst);
}

/// Exposes the current network status and connectivity changes.
class WatchSyncConnectivity {
  final SyncQueueRepository repository;
  const WatchSyncConnectivity(this.repository);

  Future<bool> get isOnline => repository.isOnline();
}

/// Returns the age of the oldest entry that has not been synced.
class GetOldestUnsyncedAge {
  final SyncQueueRepository repository;
  const GetOldestUnsyncedAge(this.repository);

  Future<Duration?> call() => repository.oldestUnsyncedAge();
}
