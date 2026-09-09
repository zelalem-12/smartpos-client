import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/invoice_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/invoice_item_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_method.dart';
import 'package:smartpos_client/features/invoice/domain/usecases/create_invoice.dart';
import 'package:smartpos_client/features/invoice/presentation/cubit/checkout_cubit.dart';
import 'package:smartpos_client/features/invoice/presentation/pages/checkout_page.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_entity.dart';
import 'package:smartpos_client/features/pos/domain/repositories/cart_repository.dart';
import 'package:smartpos_client/features/pos/domain/usecases/clear_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/get_cart.dart';

class MockCreateInvoice extends Mock implements CreateInvoice {}

class MockClearCart extends Mock implements ClearCart {}

class MockSessionService extends Mock implements SessionService {}

class _FakeCartRepository implements CartRepository {
  CartEntity _cart = const CartEntity();

  @override
  CartEntity get cart => _cart;

  @override
  Future<CartEntity> addItem(product) async {
    _cart = _cart.addProduct(product);
    return _cart;
  }

  @override
  Future<CartEntity> clear() async {
    _cart = _cart.clear();
    return _cart;
  }

  @override
  Future<CartEntity> removeItem(String productId) async => _cart;

  @override
  Future<CartEntity> updateQuantity(String productId, int quantity) async =>
      _cart;
}

void main() {
  setUpAll(() {
    registerFallbackValue(const CartEntity());
    registerFallbackValue(PaymentMethod.cash);
  });

  late CartRepository cartRepository;
  late CheckoutCubit cubit;
  late MockCreateInvoice createInvoice;
  late MockClearCart clearCart;
  late MockSessionService session;
  late GoRouter router;

  final now = DateTime(2024);
  final product = ProductEntity(
    id: 'p1',
    categoryId: 'cat-1',
    name: 'Coffee',
    barcode: 'BAR-001',
    price: 115.0,
    unit: 'cup',
    isActive: true,
    createdAt: now,
    vatRate: 0.15,
  );

  final invoice = InvoiceEntity(
    id: '1',
    invoiceNumber: 1,
    cashierId: 'csh-001',
    netTotal: 100.0,
    vatTotal: 15.0,
    grossTotal: 115.0,
    status: 'PENDING_SYNC',
    createdAt: now,
    items: [
      InvoiceItemEntity(
        productId: 'p1',
        productName: 'Coffee',
        unitPrice: 115.0,
        quantity: 1,
        vatRate: 0.15,
        netAmount: 100.0,
        vatAmount: 15.0,
        grossAmount: 115.0,
      ),
    ],
    payment: const PaymentEntity(
      method: PaymentMethod.cash,
      amount: 115.0,
      cashTendered: 200.0,
    ),
    previousHash: '',
    currentHash: 'hash',
  );

  setUp(() async {
    cartRepository = _FakeCartRepository();
    await cartRepository.addItem(product);
    createInvoice = MockCreateInvoice();
    clearCart = MockClearCart();
    session = MockSessionService();

    when(
      () => session.currentSession,
    ).thenReturn(const Session(id: 'csh-001', name: 'Selam', role: 'CASHIER'));
    when(() => session.isAuthenticated).thenReturn(true);
    when(() => session.homeRoute).thenReturn(AppRoutes.pos);
    when(() => clearCart()).thenAnswer((_) async => const CartEntity());

    cubit = CheckoutCubit(
      getCart: GetCart(cartRepository),
      createInvoice: createInvoice,
      clearCart: clearCart,
      session: session,
    );

    if (sl.isRegistered<SessionService>()) sl.unregister<SessionService>();
    sl.registerLazySingleton<SessionService>(() => session);
  });

  tearDown(() {
    if (sl.isRegistered<SessionService>()) sl.unregister<SessionService>();
  });

  Widget buildSubject() {
    router = GoRouter(
      initialLocation: AppRoutes.checkout,
      routes: [
        GoRoute(
          path: AppRoutes.pos,
          builder: (context, state) => const Scaffold(body: Text('POS')),
        ),
        GoRoute(
          path: AppRoutes.checkout,
          builder: (context, state) =>
              BlocProvider.value(value: cubit, child: const CheckoutPage()),
        ),
        GoRoute(
          path: AppRoutes.receipt,
          builder: (_, state) {
            return Scaffold(
              body: Text('Receipt ${state.uri.queryParameters['invoiceId']}'),
            );
          },
        ),
      ],
    );

    return MediaQuery(
      data: const MediaQueryData(size: Size(1080, 1920)),
      child: MaterialApp.router(routerConfig: router),
    );
  }

  Future<void> pumpSubject(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    addTearDown(() async => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(buildSubject());
  }

  group('CheckoutPage', () {
    testWidgets('displays order totals and payment options', (tester) async {
      await pumpSubject(tester);
      await tester.pumpAndSettle();

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('Grand total'), findsOneWidget);
      expect(find.textContaining('115.00 ETB'), findsWidgets);
      expect(find.text('Payment Method'), findsOneWidget);
      expect(find.text('Cash'), findsOneWidget);
      expect(find.text('Telebirr'), findsOneWidget);
      expect(find.text('CBE Birr'), findsOneWidget);
    });

    testWidgets('shows cash tendered input only for Cash', (tester) async {
      await pumpSubject(tester);
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('cashTenderedField')), findsOneWidget);

      await tester.tap(find.text('Telebirr'));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('cashTenderedField')), findsNothing);
    });

    testWidgets('updates live change as cash tendered is entered', (
      tester,
    ) async {
      await pumpSubject(tester);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const ValueKey('cashTenderedField')),
        '200',
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('85.00 ETB'), findsOneWidget);
    });

    testWidgets('navigates to receipt on successful confirmation', (
      tester,
    ) async {
      when(
        () => createInvoice(
          cart: any(named: 'cart'),
          paymentMethod: any(named: 'paymentMethod'),
          cashierId: any(named: 'cashierId'),
          cashTendered: any(named: 'cashTendered'),
          buyerTin: any(named: 'buyerTin'),
        ),
      ).thenAnswer((_) async => invoice);

      await pumpSubject(tester);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const ValueKey('cashTenderedField')),
        '200',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('confirmCheckoutButton')));
      await tester.pumpAndSettle();

      expect(find.text('Receipt 1'), findsOneWidget);
    });

    testWidgets('shows validation error for insufficient cash', (tester) async {
      await pumpSubject(tester);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const ValueKey('cashTenderedField')),
        '50',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('confirmCheckoutButton')));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Cash tendered must be at least'),
        findsOneWidget,
      );
    });

    testWidgets('back button returns to POS screen', (tester) async {
      await pumpSubject(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(router.state.matchedLocation, AppRoutes.pos);
    });

    testWidgets('buyer TIN field retains focus across multiple digits', (
      tester,
    ) async {
      await pumpSubject(tester);
      await tester.pumpAndSettle();

      final tinField = find.byKey(const ValueKey('buyerTinField'));
      await tester.tap(tinField);
      await tester.pump();

      for (final value in ['1', '12', '123', '1234', '1234567890']) {
        await tester.enterText(tinField, value);
        await tester.pump();
        expect(tester.testTextInput.isVisible, isTrue);
        expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);
      }

      expect(find.text('1234567890'), findsOneWidget);
    });
  });
}
