import '../repositories/sync_queue_repository.dart';

/// Retry a single sync queue entry by its local ID.
class RetrySyncEntry {
  final SyncQueueRepository repository;
  const RetrySyncEntry(this.repository);

  Future<void> call(int id) => repository.retry(id);
}
