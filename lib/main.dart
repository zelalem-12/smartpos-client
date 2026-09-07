import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies (database, API client, printer)
  await initDependencies();

  runApp(const SmartPosApp());
}
