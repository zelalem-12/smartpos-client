import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
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
import '../../features/auth/domain/usecases/create_cashier.dart';
import '../../features/auth/domain/usecases/create_manager.dart';
import '../../features/auth/domain/usecases/login_with_credentials.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/cubit/manager_setup_cubit.dart';
import '../../features/catalog/data/datasources/catalog_local_source.dart';
import '../../features/catalog/data/repositories/catalog_repository_impl.dart';
import '../../features/catalog/domain/repositories/catalog_repository.dart';
import '../../features/catalog/domain/usecases/add_product.dart';
import '../../features/catalog/domain/usecases/get_categories.dart';
import '../../features/catalog/domain/usecases/get_products.dart';
import '../../features/catalog/domain/usecases/search_products.dart';
import '../../features/catalog/domain/usecases/toggle_product_active.dart';
import '../../features/catalog/domain/usecases/update_product.dart';
import '../../features/catalog/presentation/bloc/catalog_bloc.dart';
import '../../features/invoice/data/repositories/invoice_repository_impl.dart';
import '../../features/invoice/domain/repositories/invoice_repository.dart';
import '../../features/invoice/domain/usecases/calculate_change.dart';
import '../../features/invoice/domain/usecases/create_invoice.dart';
import '../../features/invoice/presentation/cubit/checkout_cubit.dart';
import '../../features/pos/data/repositories/cart_repository_impl.dart';
import '../../features/pos/domain/repositories/cart_repository.dart';
import '../../features/pos/domain/usecases/add_item_to_cart.dart';
import '../../features/pos/domain/usecases/calculate_cart_totals.dart';
import '../../features/pos/domain/usecases/clear_cart.dart';
import '../../features/pos/domain/usecases/get_cart.dart';
import '../../features/pos/domain/usecases/remove_item_from_cart.dart';
import '../../features/pos/domain/usecases/update_cart_item_quantity.dart';
import '../../features/pos/presentation/bloc/cart_bloc.dart';
import '../../features/pos/presentation/bloc/pos_bloc.dart';
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
    () => SessionService(sl<StoreConfigRepository>(), sl<UserRepository>()),
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

  sl.registerLazySingleton<LoginWithCredentials>(
    () => LoginWithCredentials(sl<AuthRepository>()),
  );

  sl.registerFactory<LoginCubit>(
    () => LoginCubit(sl<LoginWithCredentials>(), sl<SessionService>()),
  );

  // ─── Phase 5: Cashier / Staff Management ───────────────────────────
  sl.registerLazySingleton<CreateCashier>(
    () => CreateCashier(sl<AuthRepository>()),
  );

  // ─── Phase 5: Catalog Management ───────────────────────────────────
  sl.registerLazySingleton<CatalogLocalSource>(
    () => CatalogLocalSource(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<CatalogRepository>(
    () => CatalogRepositoryImpl(sl<CatalogLocalSource>()),
  );

  sl.registerLazySingleton<GetCategories>(
    () => GetCategories(sl<CatalogRepository>()),
  );

  sl.registerLazySingleton<GetProducts>(
    () => GetProducts(sl<CatalogRepository>()),
  );

  sl.registerLazySingleton<SearchProducts>(
    () => SearchProducts(sl<CatalogRepository>()),
  );

  sl.registerLazySingleton<AddProduct>(
    () => AddProduct(sl<CatalogRepository>()),
  );

  sl.registerLazySingleton<UpdateProduct>(
    () => UpdateProduct(sl<CatalogRepository>()),
  );

  sl.registerLazySingleton<ToggleProductActive>(
    () => ToggleProductActive(sl<CatalogRepository>()),
  );

  sl.registerFactory<CatalogBloc>(
    () => CatalogBloc(
      sl<GetCategories>(),
      sl<GetProducts>(),
      sl<SearchProducts>(),
      sl<AddProduct>(),
      sl<UpdateProduct>(),
      sl<ToggleProductActive>(),
    ),
  );

  // ─── Phase 6: POS / Cart ─────────────────────────────────────────────

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());

  sl.registerLazySingleton<GetCart>(() => GetCart(sl<CartRepository>()));
  sl.registerLazySingleton<AddItemToCart>(
    () => AddItemToCart(sl<CartRepository>()),
  );
  sl.registerLazySingleton<RemoveItemFromCart>(
    () => RemoveItemFromCart(sl<CartRepository>()),
  );
  sl.registerLazySingleton<UpdateCartItemQuantity>(
    () => UpdateCartItemQuantity(sl<CartRepository>()),
  );
  sl.registerLazySingleton<ClearCart>(() => ClearCart(sl<CartRepository>()));
  sl.registerLazySingleton<CalculateCartTotals>(
    () => const CalculateCartTotals(),
  );

  sl.registerFactory<CartBloc>(
    () => CartBloc(
      getCart: sl<GetCart>(),
      addItemToCart: sl<AddItemToCart>(),
      removeItemFromCart: sl<RemoveItemFromCart>(),
      updateQuantity: sl<UpdateCartItemQuantity>(),
      clearCart: sl<ClearCart>(),
    ),
  );

  sl.registerFactory<PosBloc>(
    () => PosBloc(
      getCategories: sl<GetCategories>(),
      getProducts: sl<GetProducts>(),
    ),
  );

  // ─── Phase 7: Checkout / Invoicing ───────────────────────────────────

  sl.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryImpl(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<CreateInvoice>(
    () => CreateInvoice(sl<InvoiceRepository>()),
  );

  sl.registerLazySingleton<CalculateChange>(() => const CalculateChange());

  sl.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(
      getCart: sl<GetCart>(),
      createInvoice: sl<CreateInvoice>(),
      clearCart: sl<ClearCart>(),
      session: sl<SessionService>(),
    ),
  );
}

/// Creates the production database executor.
///
/// Uses drift_flutter's driftDatabase() in production.
/// For Phase 1 we use a simple NativeDatabase; encryption will be
/// configured when we add the hooks setup to pubspec.yaml.
QueryExecutor _createExecutor() {
  // For now, use an in-memory database during development.
  // In production, this will use a file-based encrypted database.
  return driftDatabase(name: 'smartpos');
}
