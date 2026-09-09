import '../repositories/sync_queue_repository.dart';

/// Attempt to sync all actionable sync queue entries.
class SyncAllEntries {
  final SyncQueueRepository repository;
  const SyncAllEntries(this.repository);

  Future<SyncSummary> call() => repository.syncAll();
}
