import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/invoice_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/invoice_item_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_method.dart';
import 'package:smartpos_client/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:smartpos_client/features/invoice/domain/usecases/create_invoice.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_entity.dart';

class MockInvoiceRepository extends Mock implements InvoiceRepository {}

void main() {
  late MockInvoiceRepository repository;
  late CreateInvoice usecase;

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

  setUpAll(() {
    registerFallbackValue(const CartEntity());
    registerFallbackValue(PaymentMethod.cash);
  });

  setUp(() {
    repository = MockInvoiceRepository();
    usecase = CreateInvoice(repository);
  });

  group('CreateInvoice', () {
    test(
      'calls repository with the supplied parameters and returns invoice',
      () async {
        when(
          () => repository.createInvoice(
            cart: any(named: 'cart'),
            paymentMethod: any(named: 'paymentMethod'),
            cashierId: any(named: 'cashierId'),
            cashTendered: any(named: 'cashTendered'),
            buyerTin: any(named: 'buyerTin'),
          ),
        ).thenAnswer((_) async => invoice);

        final cart = CartEntity().addProduct(product);
        final result = await usecase(
          cart: cart,
          paymentMethod: PaymentMethod.cash,
          cashierId: 'csh-001',
          cashTendered: 200.0,
          buyerTin: '1234567890',
        );

        expect(result, invoice);
        verify(
          () => repository.createInvoice(
            cart: cart,
            paymentMethod: PaymentMethod.cash,
            cashierId: 'csh-001',
            cashTendered: 200.0,
            buyerTin: '1234567890',
          ),
        ).called(1);
      },
    );

    test('forwards exceptions from repository', () async {
      when(
        () => repository.createInvoice(
          cart: any(named: 'cart'),
          paymentMethod: any(named: 'paymentMethod'),
          cashierId: any(named: 'cashierId'),
        ),
      ).thenThrow(Exception('db error'));

      final cart = CartEntity().addProduct(product);

      await expectLater(
        () => usecase(
          cart: cart,
          paymentMethod: PaymentMethod.cash,
          cashierId: 'csh-001',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
