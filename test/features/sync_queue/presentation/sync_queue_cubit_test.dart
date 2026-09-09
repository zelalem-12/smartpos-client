import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/sync_queue/domain/entities/sync_queue_entry.dart';
import 'package:smartpos_client/features/sync_queue/domain/repositories/sync_queue_repository.dart';
import 'package:smartpos_client/features/sync_queue/domain/usecases/get_sync_queue.dart';
import 'package:smartpos_client/features/sync_queue/domain/usecases/retry_sync_entry.dart';
import 'package:smartpos_client/features/sync_queue/domain/usecases/sync_all_entries.dart';
import 'package:smartpos_client/features/sync_queue/presentation/cubit/sync_queue_cubit.dart';
import 'package:smartpos_client/features/sync_queue/presentation/cubit/sync_queue_state.dart';

class MockSyncQueueRepository extends Mock implements SyncQueueRepository {}

class MockConnectivity extends Mock implements Connectivity {}

class FakeSyncSummary extends Fake implements SyncSummary {}

void main() {
  late MockSyncQueueRepository repository;
  late MockConnectivity connectivity;

  final entry = SyncQueueEntry(
    id: 1,
    invoiceId: 10,
    operation: 'CREATE_INVOICE',
    status: 'FAILED',
    payload: '{}',
    retryCount: 2,
    lastError: 'timeout',
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2025, 1, 2),
  );

  setUpAll(() {
    registerFallbackValue(FakeSyncSummary());
    registerFallbackValue(const Stream<List<ConnectivityResult>>.empty());
  });

  setUp(() {
    repository = MockSyncQueueRepository();
    connectivity = MockConnectivity();

    when(() => connectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(() => connectivity.onConnectivityChanged)
        .thenAnswer((_) => const Stream<List<ConnectivityResult>>.empty());

    when(() => repository.isOnline()).thenAnswer((_) async => true);
    when(() => repository.oldestUnsyncedAge())
        .thenAnswer((_) async => const Duration(days: 1));
    when(() => repository.getQueue(newestFirst: true))
        .thenAnswer((_) async => [entry]);
    when(() => repository.getActionableEntries())
        .thenAnswer((_) async => [entry]);
    when(() => repository.retry(any())).thenAnswer((_) async {});
    when(() => repository.syncAll())
        .thenAnswer((_) async => const SyncSummary(processed: 1, failed: 0));
  });

  SyncQueueCubit cubitFactory() => SyncQueueCubit(
    getSyncQueue: GetSyncQueue(repository),
    getOldestUnsyncedAge: GetOldestUnsyncedAge(repository),
    retrySyncEntry: RetrySyncEntry(repository),
    syncAll: SyncAllEntries(repository),
    connectivity: connectivity,
  );

  blocTest<SyncQueueCubit, SyncQueueState>(
    'emits entries and online status on load',
    build: cubitFactory,
    act: (c) => c.load(),
    expect: () => [
      isA<SyncQueueState>().having((s) => s.loading, 'loading', isTrue),
      isA<SyncQueueState>()
          .having((s) => s.loading, 'loading', isFalse)
          .having((s) => s.entries.length, 'entries', 1)
          .having((s) => s.isOnline, 'online', isTrue)
          .having((s) => s.showDowntimeAlert, 'downtime', isFalse),
    ],
  );

  blocTest<SyncQueueCubit, SyncQueueState>(
    'shows downtime alert when oldest unsynced is 7 or more days',
    setUp: () {
      when(() => repository.oldestUnsyncedAge())
          .thenAnswer((_) async => const Duration(days: 7));
    },
    build: cubitFactory,
    act: (c) => c.load(),
    expect: () => [
      isA<SyncQueueState>().having((s) => s.loading, 'loading', isTrue),
      isA<SyncQueueState>()
          .having((s) => s.loading, 'loading', isFalse)
          .having((s) => s.showDowntimeAlert, 'downtime', isTrue),
    ],
  );

  blocTest<SyncQueueCubit, SyncQueueState>(
    'retry is blocked when offline',
    setUp: () {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      when(() => repository.getQueue(newestFirst: true))
          .thenAnswer((_) async => []);
      when(() => repository.oldestUnsyncedAge()).thenAnswer((_) async => null);
    },
    build: cubitFactory,
    act: (c) async {
      await c.load();
      await c.retry(1);
    },
    verify: (c) {
      expect(c.state.showOfflineMessage, isTrue);
      expect(c.state.isOnline, isFalse);
    },
  );

  blocTest<SyncQueueCubit, SyncQueueState>(
    'syncAll processes entries and reloads',
    build: cubitFactory,
    act: (c) => c.syncAll(),
    verify: (c) {
      verify(() => repository.syncAll()).called(1);
    },
  );

  blocTest<SyncQueueCubit, SyncQueueState>(
    'connectivity stream updates online flag',
    setUp: () {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream.fromIterable([
          [ConnectivityResult.mobile],
          [ConnectivityResult.none],
        ]),
      );
    },
    build: cubitFactory,
    wait: const Duration(milliseconds: 50),
    expect: () => [
      isA<SyncQueueState>()
          .having((s) => s.isOnline, 'online', isFalse)
          .having((s) => s.showOfflineMessage, 'offlineMessage', isTrue),
      isA<SyncQueueState>()
          .having((s) => s.isOnline, 'online', isTrue)
          .having((s) => s.showOfflineMessage, 'offlineMessage', isFalse),
      isA<SyncQueueState>()
          .having((s) => s.isOnline, 'online', isFalse)
          .having((s) => s.showOfflineMessage, 'offlineMessage', isTrue),
    ],
  );

  test('closes connectivity subscription on dispose', () async {
    final sub = StreamController<List<ConnectivityResult>>.broadcast();
    when(() => connectivity.onConnectivityChanged)
        .thenAnswer((_) => sub.stream);
    final c = cubitFactory();
    await c.close();
    expect(sub.hasListener, isFalse);
  });
}
