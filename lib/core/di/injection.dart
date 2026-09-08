import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';

import '../../features/activation/data/datasources/activation_local_source.dart';
import '../../features/activation/data/datasources/activation_remote_source.dart';
import '../../features/activation/data/repositories/activation_repository_impl.dart';
import '../../features/activation/domain/repositories/activation_repository.dart';
import '../../features/activation/domain/usecases/activate_device.dart';
import '../../features/activation/presentation/cubit/activation_cubit.dart';
import '../../features/auth/data/datasources/auth_local_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/create_manager.dart';
import '../../features/auth/presentation/cubit/manager_setup_cubit.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';
import '../printer/mock_printer_service.dart';
import '../printer/printer_service.dart';
import '../repositories/store_config_repository.dart';
import '../repositories/store_config_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../services/session_service.dart';

/// Global service locator instance.
final sl = GetIt.instance;

/// Initialize all dependencies.
///
/// Called once at app startup from main.dart.
/// Each phase adds its own feature registrations here.
Future<void> initDependencies() async {
  // ─── Core ───────────────────────────────────────────────────────────

  // Database — singleton (one encrypted SQLite file for the entire app)
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase(_createExecutor()));

  // HTTP client — singleton (mock interceptor returns fake data)
  sl.registerLazySingleton<Dio>(() => createDio());

  // Printer — singleton (mock for emulator, swap for SunmiPrinterService on real device)
  sl.registerLazySingleton<PrinterService>(() => MockPrinterService());

  // ─── Repositories ──────────────────────────────────────────────────

  sl.registerLazySingleton<StoreConfigRepository>(
    () => StoreConfigRepositoryImpl(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl<AppDatabase>()),
  );

  // ─── Services ──────────────────────────────────────────────────────

  sl.registerLazySingleton<SessionService>(
    () => SessionService(
      storeConfigRepo: sl<StoreConfigRepository>(),
      userRepo: sl<UserRepository>(),
    ),
  );

  // ─── Phase 2: Activation ─────────────────────────────────────────

  sl.registerLazySingleton<ActivationRemoteSource>(
    () => ActivationRemoteSource(sl<Dio>()),
  );

  sl.registerLazySingleton<ActivationLocalSource>(
    () => ActivationLocalSource(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<ActivationRepository>(
    () => ActivationRepositoryImpl(
      remoteSource: sl<ActivationRemoteSource>(),
      localSource: sl<ActivationLocalSource>(),
    ),
  );

  sl.registerLazySingleton<ActivateDevice>(
    () => ActivateDevice(sl<ActivationRepository>()),
  );

  // Cubit — Factory (fresh instance per screen)
  sl.registerFactory<ActivationCubit>(
    () => ActivationCubit(sl<ActivateDevice>()),
  );

  // ─── Phase 3: Auth / Manager Setup ─────────────────────────────────

  sl.registerLazySingleton<AuthLocalSource>(
    () => AuthLocalSource(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localSource: sl<AuthLocalSource>()),
  );

  sl.registerLazySingleton<CreateManager>(
    () => CreateManager(sl<AuthRepository>()),
  );

  sl.registerFactory<ManagerSetupCubit>(
    () => ManagerSetupCubit(sl<CreateManager>()),
  );

  // ─── Phase 4+ BLoCs ────────────────────────────────────────────────
  // (registered per-feature as they are implemented)
}

/// Creates the production database executor.
///
/// Uses drift_flutter's driftDatabase() in production.
/// For Phase 1 we use a simple NativeDatabase; encryption will be
/// configured when we add the hooks setup to pubspec.yaml.
QueryExecutor _createExecutor() {
  // For now, use an in-memory database during development.
  // In production, this will use a file-based encrypted database.
  return NativeDatabase.memory();
}
