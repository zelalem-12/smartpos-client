import '../entities/sync_queue_entry.dart';

/// Repository for the pending backend sync queue.
abstract class SyncQueueRepository {
  /// List all queue entries.
  Future<List<SyncQueueEntry>> getQueue({bool newestFirst = true});

  /// Entries that can be retried or synced (PENDING or FAILED).
  Future<List<SyncQueueEntry>> getActionableEntries();

  /// Retry a single FAILED/PENDING entry by its local ID.
  Future<void> retry(int id);

  /// Process all actionable entries one by one.
  ///
  /// Returns a summary with processed and failed counts.
  Future<SyncSummary> syncAll();

  /// Whether the device is currently online.
  Future<bool> isOnline();

  /// The age of the oldest entry that has not reached SYNCED status.
  Future<Duration?> oldestUnsyncedAge();
}

/// Result of a bulk sync attempt.
class SyncSummary {
  final int processed;
  final int failed;
  final String? error;

  const SyncSummary({
    required this.processed,
    required this.failed,
    this.error,
  });

  bool get isSuccess => failed == 0 && processed > 0;
}
