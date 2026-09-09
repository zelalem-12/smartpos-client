import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_entity.dart';
import 'package:smartpos_client/features/pos/domain/usecases/clear_cart.dart';
import 'package:smartpos_client/features/receipt/domain/entities/receipt_data.dart';
import 'package:smartpos_client/features/receipt/domain/usecases/generate_receipt.dart';
import 'package:smartpos_client/features/receipt/domain/usecases/print_receipt.dart';
import 'package:smartpos_client/features/receipt/presentation/cubit/receipt_cubit.dart';
import 'package:smartpos_client/features/receipt/presentation/cubit/receipt_state.dart';

class MockGenerateReceipt extends Mock implements GenerateReceipt {}

class MockPrintReceipt extends Mock implements PrintReceipt {}

class MockClearCart extends Mock implements ClearCart {}

void main() {
  late MockGenerateReceipt generate;
  late MockPrintReceipt print;
  late MockClearCart clear;
  late ReceiptCubit cubit;

  final now = DateTime(2024, 1, 1, 12, 0);
  final receipt = ReceiptData(
    businessName: 'Business',
    tradeName: 'Trade',
    address: 'Addis Ababa',
    tin: '1234567890',
    vatRegNo: 'VAT-001',
    invoiceNumber: 1,
    invoiceDate: now,
    cashierName: 'Abebe',
    buyerTin: null,
    items: const [],
    netTotal: 100.0,
    vatTotal: 15.0,
    grossTotal: 115.0,
    paymentMethod: 'Cash',
    hash: 'hash',
    qrPayload: 'qr-payload',
  );

  setUpAll(() {
    registerFallbackValue(receipt);
    registerFallbackValue(const CartEntity());
  });

  setUp(() {
    generate = MockGenerateReceipt();
    print = MockPrintReceipt();
    clear = MockClearCart();
    cubit = ReceiptCubit(
      generateReceipt: generate,
      printReceipt: print,
      clearCart: clear,
    );

    when(() => generate(any())).thenAnswer((_) async => receipt);
    when(() => print(any(), isDuplicate: any(named: 'isDuplicate')))
        .thenAnswer((_) async => true);
    when(clear.call).thenAnswer((_) async => const CartEntity());
  });

  tearDown(() => cubit.close());

  group('ReceiptCubit', () {
    blocTest<ReceiptCubit, ReceiptState>(
      'emits error for invalid invoice id',
      build: () => cubit,
      act: (c) => c.load(null),
      expect: () => [
        isA<ReceiptError>().having((s) => s.invoiceId, 'invoiceId', isNull),
      ],
    );

    blocTest<ReceiptCubit, ReceiptState>(
      'emits loading then ready when invoice is loaded',
      build: () => cubit,
      act: (c) => c.load(1),
      expect: () => [
        isA<ReceiptLoading>(),
        isA<ReceiptReady>().having(
          (s) => s.receipt.hash,
          'receipt hash',
          'hash',
        ),
      ],
      verify: (_) {
        verify(() => generate(1)).called(1);
      },
    );

    blocTest<ReceiptCubit, ReceiptState>(
      'emits error when invoice loading fails',
      setUp: () {
        when(() => generate(any())).thenThrow(const CacheFailure('db error'));
      },
      build: () => cubit,
      act: (c) => c.load(1),
      expect: () => [
        isA<ReceiptLoading>(),
        isA<ReceiptError>().having((s) => s.message, 'message', 'db error'),
      ],
    );

    blocTest<ReceiptCubit, ReceiptState>(
      'emits printing then printed on a successful print',
      seed: () => ReceiptReady(receipt),
      build: () => cubit,
      act: (c) => c.printReceipt(),
      expect: () => [
        isA<ReceiptPrinting>(),
        isA<ReceiptPrinted>().having(
          (s) => s.isDuplicate,
          'isDuplicate',
          isFalse,
        ),
      ],
      verify: (_) {
        verify(() => print(receipt, isDuplicate: false)).called(1);
      },
    );

    blocTest<ReceiptCubit, ReceiptState>(
      'emits printing then printed as duplicate on reprint',
      seed: () => ReceiptPrinted(receipt),
      build: () => cubit,
      act: (c) => c.reprint(),
      expect: () => [
        isA<ReceiptPrinting>().having(
          (s) => s.isDuplicate,
          'isDuplicate',
          isTrue,
        ),
        isA<ReceiptPrinted>().having(
          (s) => s.isDuplicate,
          'isDuplicate',
          isTrue,
        ),
      ],
      verify: (_) {
        verify(() => print(receipt, isDuplicate: true)).called(1);
      },
    );

    blocTest<ReceiptCubit, ReceiptState>(
      'keeps the receipt when print fails',
      seed: () => ReceiptReady(receipt),
      setUp: () {
        when(() => print(any(), isDuplicate: any(named: 'isDuplicate')))
            .thenThrow(const CacheFailure('paper out'));
      },
      build: () => cubit,
      act: (c) => c.printReceipt(),
      expect: () => [
        isA<ReceiptPrinting>(),
        isA<ReceiptError>().having(
          (s) => s.receipt?.hash,
          'receipt hash preserved',
          'hash',
        ),
      ],
    );

    test('newSale clears the cart', () async {
      await cubit.newSale();
      verify(clear.call).called(1);
    });
  });
}
