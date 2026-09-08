import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../core/router/app_routes.dart';
import '../../core/services/session_service.dart';

/// Convenient extensions on BuildContext.
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Show a snackbar with a message.
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Pops the current route if there is a back stack; otherwise navigates to
  /// the authenticated user's home route.
  ///
  /// This prevents Android/system back or an app bar back button from leaving
  /// the app when the screen was entered as a top-level route.
  void safePop() {
    final router = GoRouter.of(this);
    if (router.canPop()) {
      router.pop();
    } else {
      final home = sl<SessionService>().homeRoute ?? AppRoutes.login;
      router.go(home);
    }
  }
}
