import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/settings/presentation/cubit/cashier_management_cubit.dart';
import 'package:smartpos_client/features/settings/presentation/cubit/cashier_management_state.dart';
import 'package:smartpos_client/features/settings/presentation/pages/settings_page.dart';

class MockCashierManagementCubit extends MockCubit<CashierManagementState>
    implements CashierManagementCubit {}

class _FakeSessionService implements SessionService {
  @override
  Session? get currentSession =>
      const Session(id: 'u1', name: 'Abebe', role: 'MANAGER');

  @override
  bool get isAuthenticated => true;

  @override
  bool get isManager => true;

  @override
  String? get currentUserName => currentSession?.name;

  @override
  String? get currentUserRole => currentSession?.role;

  @override
  String? get homeRoute => AppRoutes.manager;

  @override
  void setUser(String id, String name, String role) {}

  @override
  void clear() {}

  @override
  bool canAccess(String path) => true;

  @override
  Future<String?> evaluateRedirect(String path) async => null;
}

void main() {
  late MockCashierManagementCubit mockCubit;

  setUp(() {
    mockCubit = MockCashierManagementCubit();
    when(() => mockCubit.state).thenReturn(const CashierManagementLoaded([]));
    when(() => mockCubit.loadUsers()).thenAnswer((_) async {});

    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
    sl.registerLazySingleton<SessionService>(() => _FakeSessionService());
  });

  tearDown(() {
    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
  });

  Widget buildSubject() {
    final router = GoRouter(
      initialLocation: AppRoutes.settings,
      routes: [
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) =>
              BlocProvider<CashierManagementCubit>.value(
                value: mockCubit,
                child: const SettingsPage(),
              ),
        ),
        GoRoute(
          path: AppRoutes.manager,
          builder: (context, state) => const Scaffold(body: Text('Dashboard')),
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  group('SettingsPage', () {
    testWidgets('renders settings title and cashier management header', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Cashier Management'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('shows empty state when no users are loaded', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('No active users found'), findsOneWidget);
    });

    testWidgets('lists users when loaded', (tester) async {
      final now = DateTime(2026, 9, 8);
      when(() => mockCubit.state).thenReturn(
        CashierManagementLoaded([
          User(
            id: 'csh-001',
            username: 'selam_t',
            fullName: 'Selam Teshale',
            role: 'CASHIER',
            passwordHash: 'hash',
            isActive: true,
            createdAt: now,
          ),
        ]),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Selam Teshale'), findsOneWidget);
      expect(find.text('@selam_t · CASHIER'), findsOneWidget);
      expect(find.text('Deactivate'), findsOneWidget);
    });

    testWidgets('manager rows do not show deactivate button', (tester) async {
      final now = DateTime(2026, 9, 8);
      when(() => mockCubit.state).thenReturn(
        CashierManagementLoaded([
          User(
            id: 'mgr-001',
            username: 'abebe_m',
            fullName: 'Abebe Mulu',
            role: 'MANAGER',
            passwordHash: 'hash',
            isActive: true,
            createdAt: now,
          ),
        ]),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Abebe Mulu'), findsOneWidget);
      expect(find.text('Deactivate'), findsNothing);
      expect(find.text('Activate'), findsNothing);
    });
  });
}
