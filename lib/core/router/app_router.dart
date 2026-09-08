import 'package:flutter/material.dart';
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
import '../../features/invoice/presentation/cubit/checkout_cubit.dart';
import '../../features/invoice/presentation/pages/checkout_page.dart';
import '../../features/pos/presentation/bloc/cart_bloc.dart';
import '../../features/pos/presentation/bloc/cart_event.dart';
import '../../features/pos/presentation/bloc/pos_bloc.dart';
import '../../features/pos/presentation/bloc/pos_event.dart';
import '../../features/pos/presentation/pages/manager_dashboard_page.dart';
import '../../features/pos/presentation/pages/pos_page.dart';
import '../di/injection.dart';
import '../services/session_service.dart';
import 'app_routes.dart';

/// Placeholder page shown until the real screen is implemented.
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  void _safePop(BuildContext context) {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
    } else {
      final home = sl<SessionService>().homeRoute ?? AppRoutes.login;
      router.go(home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _safePop(context),
          tooltip: 'Back',
        ),
        title: Text(title),
      ),
      body: Center(
        child: Text(
          '$title\n(Coming soon)',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}

/// Creates the GoRouter with redirect guards.
///
/// Guard logic is delegated to [SessionService] for testability.
/// See [SessionService.evaluateRedirect] for the full flow.
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final session = sl<SessionService>();
      return session.evaluateRedirect(state.matchedLocation);
    },
    routes: [
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
        path: AppRoutes.manager,
        builder: (context, state) => const ManagerDashboardPage(),
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
        builder: (context, state) => const _PlaceholderPage(title: 'Receipt'),
      ),
      GoRoute(
        path: AppRoutes.catalog,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<CatalogBloc>()..add(const LoadCatalog()),
          child: const CatalogManagementPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.creditNotes,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Credit Notes'),
      ),
      GoRoute(
        path: AppRoutes.cancellation,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Invoice Cancellation'),
      ),
      GoRoute(
        path: AppRoutes.reports,
        builder: (context, state) => const _PlaceholderPage(title: 'Reports'),
      ),
      GoRoute(
        path: AppRoutes.syncQueue,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Sync Queue'),
      ),
      GoRoute(
        path: AppRoutes.audit,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Audit Trail'),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const _PlaceholderPage(title: 'Settings'),
      ),
    ],
  );
}
