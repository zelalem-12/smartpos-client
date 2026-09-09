import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection.dart';
import 'core/services/session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies (database, API client, printer)
  await initDependencies();

  // Load cached startup state (activation + manager existence) so the
  // router's synchronous redirect guard has correct data on first frame.
  await sl<SessionService>().init();

  runApp(const SmartPosApp());
}
