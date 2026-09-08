import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/activation/presentation/cubit/activation_cubit.dart';
import '../../features/activation/presentation/pages/activation_page.dart';
import '../../features/auth/presentation/cubit/manager_setup_cubit.dart';
import '../../features/auth/presentation/pages/manager_setup_page.dart';
import '../di/injection.dart';
import '../services/session_service.dart';

/// Route path constants.
class AppRoutes {
  AppRoutes._();
  static const String activation = '/activation';
  static const String managerSetup = '/manager-setup';
  static const String pinLogin = '/pin-login';
  static const String pos = '/pos';
  static const String checkout = '/checkout';
  static const String receipt = '/receipt';
  static const String catalog = '/catalog';
  static const String creditNotes = '/credit-notes';
  static const String cancellation = '/cancellation';
  static const String reports = '/reports';
  static const String syncQueue = '/sync-queue';
  static const String audit = '/audit';
  static const String settings = '/settings';
}

/// Placeholder page shown until the real screen is implemented.
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
    initialLocation: AppRoutes.activation,
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
        path: AppRoutes.pinLogin,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'PIN Login'),
      ),
      GoRoute(
        path: AppRoutes.pos,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'POS Terminal'),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Checkout'),
      ),
      GoRoute(
        path: AppRoutes.receipt,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Receipt'),
      ),
      GoRoute(
        path: AppRoutes.catalog,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Catalog Management'),
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
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Reports'),
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
    ],
  );
}
