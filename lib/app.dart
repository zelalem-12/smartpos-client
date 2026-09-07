import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Root widget of the SmartPOS application.
class SmartPosApp extends StatelessWidget {
  const SmartPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: createRouter(),
    );
  }
}
