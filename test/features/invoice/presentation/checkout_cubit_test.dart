import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/invoice_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_method.dart';
import 'package:smartpos_client/features/invoice/domain/usecases/create_invoice.dart';
import 'package:smartpos_client/features/invoice/presentation/cubit/checkout_cubit.dart';
import 'package:smartpos_client/features/invoice/presentation/cubit/checkout_state.dart';
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

  late CreateInvoice createInvoice;
  late ClearCart clearCart;
  late MockSessionService session;
  late CartRepository cartRepository;
  late CheckoutCubit cubit;

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
    items: const [],
    payment: const PaymentEntity(method: PaymentMethod.cash, amount: 115.0),
    previousHash: '',
    currentHash: 'hash',
  );

  setUp(() async {
    createInvoice = MockCreateInvoice();
    clearCart = MockClearCart();
    session = MockSessionService();
    cartRepository = _FakeCartRepository();
    await cartRepository.addItem(product);
    cubit = CheckoutCubit(
      getCart: GetCart(cartRepository),
      createInvoice: createInvoice,
      clearCart: clearCart,
      session: session,
    );
    when(
      () => session.currentSession,
    ).thenReturn(const Session(id: 'csh-001', name: 'Selam', role: 'CASHIER'));
  });

  group('CheckoutCubit', () {
    test('initial state contains the current cart', () {
      expect(cubit.state, isA<CheckoutLoaded>());
      expect((cubit.state as CheckoutLoaded).cart.itemCount, 1);
    });

    test('selectPaymentMethod updates the payment method', () {
      cubit.selectPaymentMethod(PaymentMethod.telebirr);
      expect(
        (cubit.state as CheckoutLoaded).paymentMethod,
        PaymentMethod.telebirr,
      );
    });

    test('cash tendered updates live change', () {
      cubit.updateCashTendered('200');
      expect((cubit.state as CheckoutLoaded).change, 85.0);
    });

    blocTest<CheckoutCubit, CheckoutState>(
      'emits error when cart is empty',
      seed: () => CheckoutLoaded(cart: const CartEntity()),
      build: () => cubit,
      act: (bloc) => bloc.confirmCheckout(),
      expect: () => [
        isA<CheckoutLoaded>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'Cart is empty',
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits error when cash tendered is less than total',
      build: () => cubit,
      act: (bloc) => bloc
        ..updateCashTendered('50')
        ..confirmCheckout(),
      expect: () => [
        isA<CheckoutLoaded>().having(
          (s) => s.cashTendered,
          'cashTendered',
          '50',
        ),
        isA<CheckoutLoaded>().having(
          (s) => s.errorMessage,
          'errorMessage',
          contains('Cash tendered must be at least'),
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits error for invalid buyer TIN length',
      build: () => cubit,
      act: (bloc) => bloc
        ..updateBuyerTin('12345')
        ..updateCashTendered('200')
        ..confirmCheckout(),
      expect: () => [
        isA<CheckoutLoaded>().having((s) => s.buyerTin, 'buyerTin', '12345'),
        isA<CheckoutLoaded>().having(
          (s) => s.cashTendered,
          'cashTendered',
          '200',
        ),
        isA<CheckoutLoaded>().having(
          (s) => s.errorMessage,
          'errorMessage',
          contains('Buyer TIN must be exactly'),
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits processing then completed and clears cart on success',
      setUp: () {
        when(
          () => createInvoice(
            cart: any(named: 'cart'),
            paymentMethod: any(named: 'paymentMethod'),
            cashierId: any(named: 'cashierId'),
            cashTendered: any(named: 'cashTendered'),
            buyerTin: any(named: 'buyerTin'),
          ),
        ).thenAnswer((_) async => invoice);
        when(() => clearCart()).thenAnswer((_) async => const CartEntity());
      },
      build: () => cubit,
      act: (bloc) {
        bloc.updateCashTendered('200');
        return bloc.confirmCheckout();
      },
      expect: () => [
        isA<CheckoutLoaded>().having(
          (s) => s.cashTendered,
          'cashTendered',
          '200',
        ),
        isA<CheckoutLoaded>().having(
          (s) => s.isProcessing,
          'isProcessing',
          isTrue,
        ),
        isA<CheckoutCompleted>().having(
          (s) => s.invoiceId,
          'invoiceId',
          invoice.id,
        ),
      ],
      verify: (_) {
        verify(() => clearCart()).called(1);
      },
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits processing then error when invoice creation fails',
      setUp: () {
        when(
          () => createInvoice(
            cart: any(named: 'cart'),
            paymentMethod: any(named: 'paymentMethod'),
            cashierId: any(named: 'cashierId'),
            cashTendered: any(named: 'cashTendered'),
            buyerTin: any(named: 'buyerTin'),
          ),
        ).thenThrow(const CacheFailure('db error'));
      },
      build: () => cubit,
      act: (bloc) {
        bloc.updateCashTendered('200');
        return bloc.confirmCheckout();
      },
      expect: () => [
        isA<CheckoutLoaded>().having(
          (s) => s.cashTendered,
          'cashTendered',
          '200',
        ),
        isA<CheckoutLoaded>().having(
          (s) => s.isProcessing,
          'isProcessing',
          isTrue,
        ),
        isA<CheckoutLoaded>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'db error',
        ),
      ],
      verify: (_) {
        verifyNever(() => clearCart());
      },
    );
  });
}
