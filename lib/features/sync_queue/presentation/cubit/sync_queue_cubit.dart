import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/error_message.dart';
import '../../domain/usecases/get_sync_queue.dart';
import '../../domain/usecases/retry_sync_entry.dart';
import '../../domain/usecases/sync_all_entries.dart';
import 'sync_queue_state.dart';

class SyncQueueCubit extends Cubit<SyncQueueState> {
  final GetSyncQueue _getSyncQueue;
  final GetOldestUnsyncedAge _getOldestUnsyncedAge;
  final RetrySyncEntry _retrySyncEntry;
  final SyncAllEntries _syncAll;
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  SyncQueueCubit({
    required this._getSyncQueue,
    required this._getOldestUnsyncedAge,
    required this._retrySyncEntry,
    required this._syncAll,
    required this._connectivity,
  }) : super(const SyncQueueState()) {
    _initConnectivity();
  }

  void _initConnectivity() {
    _connectivity.checkConnectivity().then(_updateOnlineStatus);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateOnlineStatus,
      cancelOnError: true,
    );
  }

  void _updateOnlineStatus(List<ConnectivityResult> results) {
    final online = results.any((r) => r != ConnectivityResult.none);
    emit(state.copyWith(isOnline: online, showOfflineMessage: !online));
  }

  Future<void> load() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final entries = await _getSyncQueue();
      final age = await _getOldestUnsyncedAge();
      final showAlert = age != null && age.inDays >= 7;
      emit(
        state.copyWith(
          loading: false,
          entries: entries,
          showDowntimeAlert: showAlert,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: sanitizeErrorMessage(e)));
    }
  }

  Future<void> retry(int id) async {
    if (!state.isOnline) {
      emit(state.copyWith(showOfflineMessage: true));
      return;
    }
    emit(state.copyWith(loading: true, error: null));
    try {
      await _retrySyncEntry(id);
      await load();
    } catch (e) {
      emit(state.copyWith(loading: false, error: sanitizeErrorMessage(e)));
      await load();
    }
  }

  Future<void> syncAll() async {
    if (!state.isOnline) {
      emit(state.copyWith(showOfflineMessage: true));
      return;
    }
    emit(state.copyWith(loading: true, error: null));
    try {
      final summary = await _syncAll();
      if (summary.error != null && summary.processed == 0) {
        emit(state.copyWith(loading: false, error: summary.error));
      } else {
        emit(state.copyWith(loading: false));
      }
      await load();
    } catch (e) {
      emit(state.copyWith(loading: false, error: sanitizeErrorMessage(e)));
      await load();
    }
  }

  void dismissOfflineMessage() {
    emit(state.copyWith(showOfflineMessage: false));
  }

  @override
  Future<void> close() async {
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    return super.close();
  }
}
