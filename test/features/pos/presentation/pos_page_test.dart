import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/catalog/domain/entities/category_entity.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/pos/data/repositories/cart_repository_impl.dart';
import 'package:smartpos_client/features/pos/domain/repositories/cart_repository.dart';
import 'package:smartpos_client/features/pos/domain/usecases/add_item_to_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/clear_cart.dart'
    as usecases;
import 'package:smartpos_client/features/pos/domain/usecases/get_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/remove_item_from_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/update_cart_item_quantity.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_entity.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_item_entity.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_bloc.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_event.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_state.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_bloc.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_event.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/pos_state.dart';
import 'package:smartpos_client/features/pos/presentation/pages/pos_page.dart';
import 'package:smartpos_client/features/pos/presentation/widgets/pos_product_card.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/core/theme/app_theme.dart';

class MockPosBloc extends MockBloc<PosEvent, PosState> implements PosBloc {}

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {}

class _FakeSessionService implements SessionService {
  @override
  Session? get currentSession =>
      const Session(id: 'u1', name: 'Abebe', role: 'MANAGER');

  @override
  bool get isAuthenticated => true;

  @override
  bool get isManager => true;

  @override
  String? get currentUserName => currentSession?.name;

  @override
  String? get currentUserRole => currentSession?.role;

  @override
  String? get homeRoute => AppRoutes.manager;

  @override
  void setUser(String id, String name, String role) {}

  @override
  void clear() {}

  @override
  bool canAccess(String path) => true;

  @override
  Future<String?> evaluateRedirect(String path) async => null;
}

void main() {
  late CartRepository cartRepository;
  late CartBloc cartBloc;
  late MockPosBloc mockPosBloc;
  late GoRouter router;
  final now = DateTime(2024);

  setUp(() {
    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
    sl.registerLazySingleton<SessionService>(() => _FakeSessionService());
  });

  tearDown(() {
    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
  });

  final category = CategoryEntity(
    id: 'cat-1',
    name: 'Beverages',
    isActive: true,
    createdAt: now,
  );

  final product = ProductEntity(
    id: 'p1',
    categoryId: 'cat-1',
    name: 'Coffee',
    barcode: 'BAR-001',
    price: 80.0,
    unit: 'cup',
    isActive: true,
    createdAt: now,
  );

  setUp(() {
    cartRepository = CartRepositoryImpl();
    mockPosBloc = MockPosBloc();
    cartBloc = CartBloc(
      getCart: GetCart(cartRepository),
      addItemToCart: AddItemToCart(cartRepository),
      removeItemFromCart: RemoveItemFromCart(cartRepository),
      updateQuantity: UpdateCartItemQuantity(cartRepository),
      clearCart: usecases.ClearCart(cartRepository),
    );
  });

  Widget buildSubject({
    Size screenSize = const Size(600, 900),
    CartBloc? cartBlocOverride,
  }) {
    final effectiveCartBloc = cartBlocOverride ?? cartBloc;
    router = GoRouter(
      initialLocation: AppRoutes.pos,
      routes: [
        GoRoute(
          path: AppRoutes.pos,
          builder: (context, state) => MediaQuery(
            data: MediaQueryData(size: screenSize),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<PosBloc>.value(value: mockPosBloc),
                BlocProvider<CartBloc>.value(value: effectiveCartBloc),
              ],
              child: const PosPage(),
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.checkout,
          builder: (context, state) => const Scaffold(body: Text('Checkout')),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const Scaffold(body: Text('Login')),
        ),
      ],
    );

    return MaterialApp.router(theme: AppTheme.light, routerConfig: router);
  }

  group('PosPage', () {
    testWidgets('renders loading indicator when catalog is loading', (
      tester,
    ) async {
      when(() => mockPosBloc.state).thenReturn(const PosLoading());

      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders product grid when catalog is loaded', (tester) async {
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.text('Coffee'), findsOneWidget);
      expect(find.widgetWithText(PosProductCard, 'Beverages'), findsOneWidget);
    });

    testWidgets('shows bottom cart action on narrow screens', (tester) async {
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(buildSubject(screenSize: const Size(500, 800)));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('0 items'), findsOneWidget);
      expect(find.text('View Cart'), findsOneWidget);
    });

    testWidgets('logout action returns cashier to login', (tester) async {
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(buildSubject(screenSize: const Size(500, 800)));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Log out'));
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.login);
    });

    testWidgets('shows split cart panel on wide screens', (tester) async {
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(buildSubject(screenSize: const Size(1000, 800)));

      expect(find.text('Cart (0 items)'), findsOneWidget);
      expect(find.text('CHARGE 0.00 ETB'), findsOneWidget);
    });

    testWidgets('search field dispatches SearchPosProducts event', (
      tester,
    ) async {
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(buildSubject());

      await tester.enterText(
        find.byKey(const ValueKey('posSearchField')),
        'tea',
      );
      await tester.pump();

      verify(() => mockPosBloc.add(const SearchPosProducts('tea'))).called(1);
    });

    testWidgets('search field retains focus across multiple characters', (
      tester,
    ) async {
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(buildSubject());

      final searchField = find.byKey(const ValueKey('posSearchField'));
      await tester.tap(searchField);
      await tester.pump();

      for (final value in ['c', 'co', 'cof', 'coff', 'coffee']) {
        await tester.enterText(searchField, value);
        await tester.pump();
        expect(tester.testTextInput.isVisible, isTrue);
        expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);
      }

      expect(find.text('coffee'), findsOneWidget);
    });

    testWidgets('wide CHARGE button pushes checkout', (tester) async {
      final mockCartBloc = MockCartBloc();
      when(() => mockCartBloc.state).thenReturn(
        CartLoaded(
          CartEntity(items: [CartItemEntity(product: product, quantity: 1)]),
        ),
      );
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(
        buildSubject(
          screenSize: const Size(1000, 800),
          cartBlocOverride: mockCartBloc,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Cart (1 items)'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('chargeButton')));
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.checkout);
    });

    testWidgets('mobile CHARGE button pushes checkout from bottom sheet', (
      tester,
    ) async {
      final mockCartBloc = MockCartBloc();
      when(() => mockCartBloc.state).thenReturn(
        CartLoaded(
          CartEntity(items: [CartItemEntity(product: product, quantity: 1)]),
        ),
      );
      when(() => mockPosBloc.state).thenReturn(
        PosLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(
        buildSubject(
          screenSize: const Size(500, 800),
          cartBlocOverride: mockCartBloc,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('View Cart'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('chargeButton')));
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.checkout);
    });
  });
}
