import 'package:equatable/equatable.dart';

/// Domain representation of a sync queue job.
class SyncQueueEntry extends Equatable {
  final int id;
  final int invoiceId;
  final String operation;
  final String status;
  final String payload;
  final int retryCount;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastAttemptAt;
  final DateTime? syncedAt;

  const SyncQueueEntry({
    required this.id,
    required this.invoiceId,
    required this.operation,
    required this.status,
    required this.payload,
    required this.retryCount,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
    this.lastAttemptAt,
    this.syncedAt,
  });

  bool get isPending => status == 'PENDING';
  bool get isProcessing => status == 'PROCESSING';
  bool get isFailed => status == 'FAILED';
  bool get isSynced => status == 'SYNCED';
  bool get isActionable => isPending || isFailed;

  @override
  List<Object?> get props => [
    id,
    invoiceId,
    operation,
    status,
    payload,
    retryCount,
    lastError,
    createdAt,
    updatedAt,
    lastAttemptAt,
    syncedAt,
  ];
}
