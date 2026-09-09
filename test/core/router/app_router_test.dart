import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/router/app_router.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/login_cubit.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/login_state.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_state.dart';
import 'package:smartpos_client/features/cancellation/presentation/cubit/cancellation_cubit.dart';
import 'package:smartpos_client/features/credit_notes/presentation/cubit/credit_note_cubit.dart';
import 'package:smartpos_client/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_entity.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_bloc.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_event.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_state.dart';
import 'package:smartpos_client/features/invoice/presentation/cubit/checkout_cubit.dart';
import 'package:smartpos_client/features/invoice/presentation/cubit/checkout_state.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_bloc.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_event.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_state.dart';
import 'package:smartpos_client/features/receipt/presentation/cubit/receipt_cubit.dart';
import 'package:smartpos_client/features/receipt/presentation/cubit/receipt_state.dart';
import 'package:smartpos_client/features/settings/presentation/cubit/cashier_management_cubit.dart';
import 'package:smartpos_client/features/settings/presentation/cubit/cashier_management_state.dart';

class MockStoreConfigRepository extends Mock implements StoreConfigRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {
  MockLoginCubit() {
    when(() => state).thenReturn(const LoginInitial());
  }
}

class MockCatalogBloc extends MockBloc<CatalogEvent, CatalogState>
    implements CatalogBloc {
  MockCatalogBloc() {
    when(() => state).thenReturn(
      const CatalogLoaded(categories: [], products: [], filteredProducts: []),
    );
  }
}

class MockPosBloc extends MockBloc<PosEvent, PosState> implements PosBloc {
  MockPosBloc() {
    when(() => state).thenReturn(
      const PosLoaded(categories: [], products: [], filteredProducts: []),
    );
  }
}

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {
  MockCartBloc() {
    when(() => state).thenReturn(const CartLoaded(CartEntity()));
  }
}

class MockCheckoutCubit extends MockCubit<CheckoutState>
    implements CheckoutCubit {
  MockCheckoutCubit() {
    when(() => state).thenReturn(CheckoutLoaded(cart: const CartEntity()));
  }
}

class MockReceiptCubit extends MockCubit<ReceiptState> implements ReceiptCubit {
  MockReceiptCubit() {
    when(() => state).thenReturn(const ReceiptLoading());
    when(() => stream).thenAnswer((_) => const Stream<ReceiptState>.empty());
    when(() => close()).thenAnswer((_) async {});
    when(() => load(any())).thenAnswer((_) async {});
  }
}

class MockCreditNoteCubit extends MockCubit<CreditNoteState>
    implements CreditNoteCubit {
  MockCreditNoteCubit() {
    when(() => state).thenReturn(const CreditNoteState());
  }
}

class MockCancellationCubit extends MockCubit<CancellationState>
    implements CancellationCubit {
  MockCancellationCubit() {
    when(() => state).thenReturn(const CancellationState());
  }
}

class MockReportsCubit extends MockCubit<ReportsState> implements ReportsCubit {
  MockReportsCubit() {
    when(() => state).thenReturn(const ReportsState());
    when(() => load()).thenAnswer((_) async {});
  }
}

class MockCashierManagementCubit extends MockCubit<CashierManagementState>
    implements CashierManagementCubit {
  MockCashierManagementCubit() {
    when(() => state).thenReturn(const CashierManagementLoaded([]));
    when(() => loadUsers()).thenAnswer((_) async {});
  }
}

void _safeUnregister<T extends Object>() {
  if (sl.isRegistered<T>()) {
    sl.unregister<T>();
  }
}

void _resetAndRegisterMocks() {
  _safeUnregister<StoreConfigRepository>();
  _safeUnregister<UserRepository>();
  _safeUnregister<SessionService>();
  _safeUnregister<LoginCubit>();
  _safeUnregister<CatalogBloc>();
  _safeUnregister<PosBloc>();
  _safeUnregister<CartBloc>();
  _safeUnregister<CashierManagementCubit>();
  _safeUnregister<CheckoutCubit>();
  _safeUnregister<ReceiptCubit>();
  _safeUnregister<CreditNoteCubit>();
  _safeUnregister<CancellationCubit>();
  _safeUnregister<ReportsCubit>();

  final storeRepo = MockStoreConfigRepository();
  final userRepo = MockUserRepository();

  when(() => storeRepo.isDeviceActivated()).thenAnswer((_) async => true);
  when(() => userRepo.hasManager()).thenAnswer((_) async => true);

  sl.registerLazySingleton<StoreConfigRepository>(() => storeRepo);
  sl.registerLazySingleton<UserRepository>(() => userRepo);
  sl.registerLazySingleton<SessionService>(
    () => SessionService(sl<StoreConfigRepository>(), sl<UserRepository>()),
  );

  sl.registerFactory<LoginCubit>(() => MockLoginCubit());
  sl.registerFactory<CatalogBloc>(() => MockCatalogBloc());
  sl.registerFactory<PosBloc>(() => MockPosBloc());
  sl.registerFactory<CartBloc>(() => MockCartBloc());
  sl.registerFactory<CashierManagementCubit>(
    () => MockCashierManagementCubit(),
  );
  sl.registerFactory<CheckoutCubit>(() => MockCheckoutCubit());
  sl.registerFactory<ReceiptCubit>(() => MockReceiptCubit());
  sl.registerFactory<CreditNoteCubit>(() => MockCreditNoteCubit());
  sl.registerFactory<CancellationCubit>(() => MockCancellationCubit());
  sl.registerFactory<ReportsCubit>(() => MockReportsCubit());
}

void _unregisterMocks() {
  _safeUnregister<StoreConfigRepository>();
  _safeUnregister<UserRepository>();
  _safeUnregister<SessionService>();
  _safeUnregister<LoginCubit>();
  _safeUnregister<CatalogBloc>();
  _safeUnregister<PosBloc>();
  _safeUnregister<CartBloc>();
  _safeUnregister<CashierManagementCubit>();
  _safeUnregister<CheckoutCubit>();
  _safeUnregister<ReceiptCubit>();
  _safeUnregister<CreditNoteCubit>();
  _safeUnregister<CancellationCubit>();
  _safeUnregister<ReportsCubit>();
}

void main() {
  setUp(_resetAndRegisterMocks);
  tearDown(_unregisterMocks);

  group('AppRouter', () {
    testWidgets(
      'manager tile push navigates to section and back returns to dashboard',
      (tester) async {
        sl<SessionService>().setUser('m1', 'Abebe', 'MANAGER');

        final router = createRouter();

        await tester.pumpWidget(MaterialApp.router(routerConfig: router));
        await tester.pumpAndSettle();

        router.go(AppRoutes.manager);
        await tester.pumpAndSettle();
        expect(router.state.matchedLocation, AppRoutes.manager);

        await tester.tap(find.text('Catalog'));
        await tester.pumpAndSettle();
        expect(router.state.matchedLocation, AppRoutes.catalog);

        router.pop();
        await tester.pumpAndSettle();
        expect(router.state.matchedLocation, AppRoutes.manager);
      },
    );

    testWidgets('New Sale tile pushes the POS screen', (tester) async {
      sl<SessionService>().setUser('m1', 'Abebe', 'MANAGER');

      final router = createRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.manager);
      await tester.pumpAndSettle();

      for (final label in [
        'New Sale',
        'Catalog',
        'Reports',
        'Sync Queue',
        'Credit Notes',
        'Invoice Cancellation',
        'Settings',
      ]) {
        expect(find.text(label), findsOneWidget);
      }

      await tester.tap(find.text('New Sale'));
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.pos);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.manager);

      await tester.tap(find.text('New Sale'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.manager);
    });

    testWidgets('cashier dashboard shows only sales entry and identity', (
      tester,
    ) async {
      sl<SessionService>().setUser('c1', 'Chala', 'CASHIER');
      final router = createRouter();
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.cashier);
      await tester.pumpAndSettle();

      expect(find.text('Welcome, Chala'), findsOneWidget);
      expect(find.text('CASHIER'), findsOneWidget);
      expect(find.text('New Sale'), findsOneWidget);
      expect(find.text('Catalog'), findsNothing);
      expect(find.text('Reports'), findsNothing);
      expect(find.text('Settings'), findsNothing);
    });

    testWidgets('cashier New Sale app-bar and system back return home', (
      tester,
    ) async {
      sl<SessionService>().setUser('c1', 'Chala', 'CASHIER');
      final router = createRouter();
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      router.go(AppRoutes.cashier);
      await tester.pumpAndSettle();

      await tester.tap(find.text('New Sale'));
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.pos);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.cashier);

      await tester.tap(find.text('New Sale'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.cashier);
    });

    testWidgets('cashier direct POS system back falls back to cashier home', (
      tester,
    ) async {
      sl<SessionService>().setUser('c1', 'Chala', 'CASHIER');
      final router = createRouter();
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      router.go(AppRoutes.pos);
      await tester.pumpAndSettle();

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.cashier);
    });

    testWidgets('cashier dashboard logout clears session and opens login', (
      tester,
    ) async {
      sl<SessionService>().setUser('c1', 'Chala', 'CASHIER');
      final router = createRouter();
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      router.go(AppRoutes.cashier);
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Log out'));
      await tester.pumpAndSettle();
      expect(sl<SessionService>().isAuthenticated, false);
      expect(router.state.matchedLocation, AppRoutes.login);
    });

    testWidgets('cashier can access POS and is redirected away from reports', (
      tester,
    ) async {
      sl<SessionService>().setUser('c1', 'Chala', 'CASHIER');

      final router = createRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.reports);
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.cashier);
    });

    testWidgets('settings route is registered with safe back button', (
      tester,
    ) async {
      sl<SessionService>().setUser('m1', 'Abebe', 'MANAGER');

      final router = createRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.settings);
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.settings);
      expect(find.text('Settings'), findsWidgets);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('cashier is redirected away from settings and catalog', (
      tester,
    ) async {
      sl<SessionService>().setUser('c1', 'Chala', 'CASHIER');

      final router = createRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.settings);
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.cashier);

      router.go(AppRoutes.catalog);
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.cashier);
    });

    testWidgets('manager can navigate to settings route', (tester) async {
      sl<SessionService>().setUser('m1', 'Abebe', 'MANAGER');

      final router = createRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.settings);
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.settings);
    });

    testWidgets('system back from top-level POS returns manager home', (
      tester,
    ) async {
      sl<SessionService>().setUser('m1', 'Abebe', 'MANAGER');

      final router = createRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.pos);
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.pos);

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.manager);
    });

    testWidgets('manager can open all Phase 9 screens', (tester) async {
      sl<SessionService>().setUser('m1', 'Manager', 'MANAGER');
      final router = createRouter();
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      for (final route in [
        AppRoutes.creditNotes,
        AppRoutes.cancellation,
        AppRoutes.reports,
      ]) {
        router.go(route);
        await tester.pumpAndSettle();
        expect(router.state.matchedLocation, route);
      }
    });

    testWidgets('system back from pushed checkout returns to POS', (
      tester,
    ) async {
      sl<SessionService>().setUser('c1', 'Chala', 'CASHIER');

      final router = createRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.pos);
      await tester.pumpAndSettle();

      // Simulate the cart pushing checkout via a pushed route.
      router.push(AppRoutes.checkout);
      await tester.pumpAndSettle();
      expect(router.state.matchedLocation, AppRoutes.checkout);

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.pos);
    });
  });
}
