import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../core/router/app_routes.dart';
import '../../core/services/session_service.dart';
import '../extensions/context_extensions.dart';

/// Wraps authenticated section screens so that Android/system back returns
/// to the authenticated home route when the route has no back stack.
///
/// This prevents the app from exiting from top-level routes such as POS,
/// Catalog, Checkout or Settings. When the route was pushed onto a stack,
/// the normal pop behavior is preserved.
///
/// The authenticated home route itself is not intercepted, so system back from
/// the home screen exits the app as expected.
class AuthRouteBackHandler extends StatelessWidget {
  final Widget child;

  const AuthRouteBackHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).state.matchedLocation;
    final homeRoute = sl<SessionService>().homeRoute ?? AppRoutes.login;
    final isHomeRoute = currentRoute == homeRoute;

    return PopScope(
      canPop: isHomeRoute,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.safePop();
      },
      child: child,
    );
  }
}
