import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/catalog/data/datasources/catalog_local_source.dart';
import 'package:smartpos_client/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/get_categories.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/get_products.dart';
import 'package:smartpos_client/features/pos/data/repositories/cart_repository_impl.dart';
import 'package:smartpos_client/features/pos/domain/usecases/add_item_to_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/clear_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/get_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/remove_item_from_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/update_cart_item_quantity.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_bloc.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_event.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_bloc.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_event.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_state.dart';
import 'package:smartpos_client/features/pos/presentation/pages/pos_page.dart';
import 'package:smartpos_client/features/pos/presentation/widgets/pos_product_card.dart';

import '../../../shared/fakes/fake_session_service.dart';

void main() {
  late AppDatabase db;
  late CatalogRepositoryImpl repository;

  setUp(() {
    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
    sl.registerLazySingleton<SessionService>(() => FakeSessionService());

    db = AppDatabase.forTesting();
    repository = CatalogRepositoryImpl(CatalogLocalSource(db));
  });

  tearDown(() async {
    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
    await db.close();
  });

  Widget buildSubject() {
    final getCategories = GetCategories(repository);
    final getProducts = GetProducts(repository);
    final cartRepository = CartRepositoryImpl();

    final router = GoRouter(
      initialLocation: AppRoutes.pos,
      routes: [
        GoRoute(
          path: AppRoutes.pos,
          builder: (context, state) => MediaQuery(
            data: const MediaQueryData(size: Size(1000, 800)),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<PosBloc>(
                  create: (_) => PosBloc(
                    getCategories: getCategories,
                    getProducts: getProducts,
                  )..add(const LoadPosCatalog()),
                ),
                BlocProvider<CartBloc>(
                  create: (_) => CartBloc(
                    getCart: GetCart(cartRepository),
                    addItemToCart: AddItemToCart(cartRepository),
                    removeItemFromCart: RemoveItemFromCart(cartRepository),
                    updateQuantity: UpdateCartItemQuantity(cartRepository),
                    clearCart: ClearCart(cartRepository),
                  )..add(const LoadCart()),
                ),
              ],
              child: const PosPage(),
            ),
          ),
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  testWidgets('POS seeds catalog from empty database and renders 36 products', (
    tester,
  ) async {
    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();

    final posBloc = BlocProvider.of<PosBloc>(
      tester.element(find.byType(PosPage)),
    );
    expect(posBloc.state, isA<PosLoaded>());
    expect(
      (posBloc.state as PosLoaded).products.length,
      36,
      reason: 'POS catalog should load all 36 seeded products',
    );

    // Verify representative products are visible in the grid.
    expect(find.text('Amoxicillin 500mg'), findsOneWidget);
    expect(find.byType(PosProductCard), findsWidgets);
  });
}
