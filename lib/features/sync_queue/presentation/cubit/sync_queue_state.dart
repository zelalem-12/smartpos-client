import 'package:equatable/equatable.dart';

import '../../domain/entities/sync_queue_entry.dart';

/// UI state for the sync queue page.
class SyncQueueState extends Equatable {
  final bool loading;
  final List<SyncQueueEntry> entries;
  final bool isOnline;
  final bool showOfflineMessage;
  final bool showDowntimeAlert;
  final String? error;

  const SyncQueueState({
    this.loading = false,
    this.entries = const [],
    this.isOnline = true,
    this.showOfflineMessage = false,
    this.showDowntimeAlert = false,
    this.error,
  });

  SyncQueueState copyWith({
    bool? loading,
    List<SyncQueueEntry>? entries,
    bool? isOnline,
    bool? showOfflineMessage,
    bool? showDowntimeAlert,
    String? error,
  }) {
    return SyncQueueState(
      loading: loading ?? this.loading,
      entries: entries ?? this.entries,
      isOnline: isOnline ?? this.isOnline,
      showOfflineMessage: showOfflineMessage ?? this.showOfflineMessage,
      showDowntimeAlert: showDowntimeAlert ?? this.showDowntimeAlert,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    entries,
    isOnline,
    showOfflineMessage,
    showDowntimeAlert,
    error,
  ];
}
