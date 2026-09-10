import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/activation/presentation/cubit/activation_cubit.dart';
import '../../features/activation/presentation/pages/activation_page.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/cubit/manager_setup_cubit.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/manager_setup_page.dart';
import '../../features/catalog/presentation/bloc/catalog_bloc.dart';
import '../../features/catalog/presentation/bloc/catalog_event.dart';
import '../../features/catalog/presentation/pages/catalog_management_page.dart';
import '../../features/cancellation/presentation/cubit/cancellation_cubit.dart';
import '../../features/cancellation/presentation/pages/cancellation_page.dart';
import '../../features/credit_notes/presentation/cubit/credit_note_cubit.dart';
import '../../features/credit_notes/presentation/pages/credit_notes_page.dart';
import '../../features/invoice/presentation/cubit/checkout_cubit.dart';
import '../../features/invoice/presentation/pages/checkout_page.dart';
import '../../features/receipt/presentation/cubit/receipt_cubit.dart';
import '../../features/receipt/presentation/pages/receipt_page.dart';
import '../../features/reports/presentation/cubit/reports_cubit.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/pos/presentation/bloc/cart_bloc.dart';
import '../../features/pos/presentation/bloc/cart_event.dart';
import '../../features/pos/presentation/bloc/pos_bloc.dart';
import '../../features/pos/presentation/bloc/pos_event.dart';
import '../../features/pos/presentation/pages/cashier_dashboard_page.dart';
import '../../features/pos/presentation/pages/manager_dashboard_page.dart';
import '../../features/pos/presentation/pages/pos_page.dart';
import '../../features/settings/presentation/cubit/cashier_management_cubit.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/sync_queue/presentation/pages/sync_queue_page.dart';
import '../../features/audit/presentation/pages/audit_page.dart';
import '../di/injection.dart';
import '../services/session_service.dart';
import 'app_routes.dart';
import '../../shared/widgets/app_nav_shell.dart';

/// Creates the GoRouter with redirect guards.
///
/// Guard logic is delegated to [SessionService] for testability.
/// See [SessionService.evaluateRedirect] for the full flow. The router
/// re-evaluates redirects whenever the [SessionService] notifies listeners
/// (login, logout, activation, manager setup) via `refreshListenable`.
GoRouter createRouter() {
  final session = sl<SessionService>();
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: session,
    redirect: (context, state) =>
        session.evaluateRedirect(state.matchedLocation),
    routes: [
      // --- Public / onboarding routes (no shell) ---
      GoRoute(
        path: AppRoutes.activation,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ActivationCubit>(),
          child: const ActivationPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.managerSetup,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ManagerSetupCubit>(),
          child: const ManagerSetupPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<LoginCubit>(),
          child: const LoginPage(),
        ),
      ),

      // --- Cashier dashboard (no shell — single action screen) ---
      GoRoute(
        path: AppRoutes.cashier,
        builder: (context, state) => const CashierDashboardPage(),
      ),

      // --- Manager shell with bottom nav / rail ---
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // Only managers see the nav shell. Cashiers are redirected by
          // the guard and never reach this builder.
          return AppNavShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Dashboard / New Sale
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.manager,
                builder: (context, state) => const ManagerDashboardPage(),
              ),
            ],
          ),
          // Branch 1: Catalog
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.catalog,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<CatalogBloc>()..add(const LoadCatalog()),
                  child: const CatalogManagementPage(),
                ),
              ),
            ],
          ),
          // Branch 2: Reports
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.reports,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<ReportsCubit>()..load(),
                  child: const ReportsPage(),
                ),
              ),
            ],
          ),
          // Branch 3: Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<CashierManagementCubit>()..loadUsers(),
                  child: const SettingsPage(),
                ),
              ),
            ],
          ),
        ],
      ),

      // --- Full-screen routes pushed on top of the shell ---
      GoRoute(
        path: AppRoutes.pos,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<PosBloc>()..add(const LoadPosCatalog()),
            ),
            BlocProvider(create: (_) => sl<CartBloc>()..add(const LoadCart())),
          ],
          child: const PosPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<CheckoutCubit>(),
          child: const CheckoutPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.receipt,
        builder: (context, state) {
          final invoiceId = int.tryParse(
            state.uri.queryParameters['invoiceId'] ?? '',
          );
          return BlocProvider(
            create: (_) => sl<ReceiptCubit>()..load(invoiceId),
            child: const ReceiptPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.creditNotes,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<CreditNoteCubit>(),
          child: const CreditNotesPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.cancellation,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<CancellationCubit>(),
          child: const CancellationPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.syncQueue,
        builder: (context, state) => const SyncQueuePage(),
      ),
      GoRoute(
        path: AppRoutes.audit,
        builder: (context, state) => const AuditPage(),
      ),
    ],
  );
}
