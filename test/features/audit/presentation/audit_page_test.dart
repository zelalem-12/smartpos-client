import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/audit/domain/entities/audit_log_entry.dart';
import 'package:smartpos_client/features/audit/presentation/cubit/audit_cubit.dart';
import 'package:smartpos_client/features/audit/presentation/cubit/audit_state.dart';
import 'package:smartpos_client/features/audit/presentation/pages/audit_page.dart';

class MockAuditCubit extends MockCubit<AuditState> implements AuditCubit {}

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
    AuditLogEntry(
      id: 1,
      action: 'INVOICE_CREATED',
      userId: 'csh-001',
      details: 'Invoice #1',
      payload: '{"n":1}',
      previousHash: '',
      currentHash: 'firsthash',
      createdAt: DateTime(2025, 1, 1),
      integrityStatus: AuditIntegrityStatus.valid,
    ),
    AuditLogEntry(
      id: 2,
      action: 'CREDIT_NOTE_CREATED',
      userId: 'mgr-001',
      details: 'Credit note',
      payload: '{"n":2}',
      previousHash: 'firsthash',
      currentHash: 'secondhash',
      createdAt: DateTime(2025, 1, 2),
      integrityStatus: AuditIntegrityStatus.tampered,
    ),
  ];

  testWidgets('renders list, export buttons, and chain status', (tester) async {
    final cubit = MockAuditCubit();
    when(() => cubit.state).thenReturn(
      AuditState(entries: entries, chainValid: false, firstBrokenId: 2),
    );
    when(() => cubit.load()).thenAnswer((_) async {});
    when(() => cubit.refresh()).thenAnswer((_) async {});
    when(() => cubit.exportCsv()).thenAnswer((_) async {});
    when(() => cubit.exportJson()).thenAnswer((_) async {});

    await tester.pumpWidget(wrapWithRouter(AuditPage(cubit: cubit)));

    expect(find.text('INVOICE_CREATED'), findsOneWidget);
    expect(find.text('CREDIT_NOTE_CREATED'), findsOneWidget);
    expect(find.text('Export CSV'), findsOneWidget);
    expect(find.text('Export JSON'), findsOneWidget);
    expect(find.textContaining('broken'), findsOneWidget);
  });

  testWidgets('tapping audit row opens detail dialog', (tester) async {
    final cubit = MockAuditCubit();
    when(() => cubit.state).thenReturn(AuditState(entries: [entries.first]));
    when(() => cubit.load()).thenAnswer((_) async {});

    await tester.pumpWidget(wrapWithRouter(AuditPage(cubit: cubit)));

    await tester.tap(find.text('INVOICE_CREATED'));
    await tester.pumpAndSettle();

    expect(find.text('INVOICE_CREATED'), findsWidgets);
    expect(find.textContaining('Current Hash:'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
