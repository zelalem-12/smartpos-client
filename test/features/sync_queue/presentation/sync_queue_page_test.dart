import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/sync_queue/domain/entities/sync_queue_entry.dart';
import 'package:smartpos_client/features/sync_queue/presentation/cubit/sync_queue_cubit.dart';
import 'package:smartpos_client/features/sync_queue/presentation/cubit/sync_queue_state.dart';
import 'package:smartpos_client/features/sync_queue/presentation/pages/sync_queue_page.dart';

class MockSyncQueueCubit extends MockCubit<SyncQueueState>
    implements SyncQueueCubit {}

class MockStoreConfigRepository extends Mock implements StoreConfigRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void _registerSessionService() {
  if (sl.isRegistered<StoreConfigRepository>()) {
    sl.unregister<StoreConfigRepository>();
  }
  if (sl.isRegistered<UserRepository>()) sl.unregister<UserRepository>();
  if (sl.isRegistered<SessionService>()) sl.unregister<SessionService>();

  final storeRepo = MockStoreConfigRepository();
  final userRepo = MockUserRepository();
  when(() => storeRepo.isDeviceActivated()).thenAnswer((_) async => true);
  when(() => userRepo.hasManager()).thenAnswer((_) async => true);

  sl.registerSingleton<StoreConfigRepository>(storeRepo);
  sl.registerSingleton<UserRepository>(userRepo);
  sl.registerSingleton<SessionService>(SessionService(storeRepo, userRepo));
}

Widget wrapWithRouter(Widget child) => MaterialApp.router(
  routerConfig: GoRouter(
    routes: [GoRoute(path: '/', builder: (context, state) => child)],
  ),
);

void main() {
  setUp(_registerSessionService);

  final entries = [
    SyncQueueEntry(
      id: 1,
      invoiceId: 10,
      operation: 'CREATE_INVOICE',
      status: 'FAILED',
      payload: '{}',
      retryCount: 2,
      lastError: 'timeout',
      createdAt: DateTime(2025, 1, 1),
      updatedAt: DateTime(2025, 1, 2),
    ),
    SyncQueueEntry(
      id: 2,
      invoiceId: 11,
      operation: 'CREATE_CREDIT_NOTE',
      status: 'PENDING',
      payload: '{}',
      retryCount: 0,
      createdAt: DateTime(2025, 1, 2),
      updatedAt: DateTime(2025, 1, 2),
    ),
  ];

  testWidgets('renders status chips, list and sync all button', (tester) async {
    final cubit = MockSyncQueueCubit();
    when(() => cubit.state)
        .thenReturn(SyncQueueState(entries: entries, isOnline: true));
    when(() => cubit.load()).thenAnswer((_) async {});
    when(() => cubit.syncAll()).thenAnswer((_) async {});
    when(() => cubit.retry(any())).thenAnswer((_) async {});

    await tester.pumpWidget(wrapWithRouter(SyncQueuePage(cubit: cubit)));

    expect(find.text('Total: 2'), findsOneWidget);
    expect(find.text('Pending: 1'), findsOneWidget);
    expect(find.text('Failed: 1'), findsOneWidget);
    expect(find.textContaining('CREATE_INVOICE'), findsOneWidget);
    expect(find.textContaining('CREATE_CREDIT_NOTE'), findsOneWidget);
    expect(find.text('Retries: 2'), findsOneWidget);
    expect(find.textContaining('timeout'), findsOneWidget);
    expect(find.text('Sync All (2)'), findsOneWidget);
  });

  testWidgets('offline banner disables sync all and shows message', (
    tester,
  ) async {
    final cubit = MockSyncQueueCubit();
    when(() => cubit.state).thenReturn(
      const SyncQueueState(
        entries: [],
        isOnline: false,
        showOfflineMessage: true,
      ),
    );
    when(() => cubit.load()).thenAnswer((_) async {});
    when(() => cubit.syncAll()).thenAnswer((_) async {});
    when(() => cubit.dismissOfflineMessage()).thenAnswer((_) async {});

    await tester.pumpWidget(wrapWithRouter(SyncQueuePage(cubit: cubit)));

    expect(find.textContaining('offline'), findsOneWidget);
    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Sync All (0)'),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('downtime alert is shown when threshold met', (tester) async {
    final cubit = MockSyncQueueCubit();
    when(() => cubit.state).thenReturn(
      const SyncQueueState(
        entries: [],
        isOnline: true,
        showDowntimeAlert: true,
      ),
    );
    when(() => cubit.load()).thenAnswer((_) async {});

    await tester.pumpWidget(wrapWithRouter(SyncQueuePage(cubit: cubit)));

    expect(find.textContaining('7 or more days'), findsOneWidget);
  });
}
