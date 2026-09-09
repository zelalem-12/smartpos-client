import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/features/invoice/domain/entities/invoice_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/invoice_item_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_entity.dart';
import 'package:smartpos_client/features/invoice/domain/entities/payment_method.dart';
import 'package:smartpos_client/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:smartpos_client/features/receipt/data/repositories/receipt_repository_impl.dart';

class MockInvoiceRepository extends Mock implements InvoiceRepository {}

class MockStoreConfigRepository extends Mock implements StoreConfigRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockInvoiceRepository invoiceRepo;
  late MockStoreConfigRepository storeRepo;
  late MockUserRepository userRepo;
  late ReceiptRepositoryImpl repository;

  final now = DateTime(2024, 1, 1, 12, 0);
  final store = StoreConfig(
    id: 1,
    licenseKey: 'LIC-001',
    businessName: 'Business Name',
    tradeName: 'Trade Name',
    tin: '1234567890',
    vatRegNo: 'VAT-001',
    sector: 'Retail',
    address: 'Addis Ababa',
    deviceSerial: 'SN-001',
    createdAt: now,
  );
  final user = User(
    id: 'c1',
    username: 'cashier1',
    fullName: 'Abebe Bikila',
    role: 'CASHIER',
    passwordHash: 'hash',
    isActive: true,
    createdAt: now,
  );

  final invoice = InvoiceEntity(
    id: '1',
    invoiceNumber: 42,
    cashierId: 'c1',
    buyerTin: '0987654321',
    netTotal: 100.0,
    vatTotal: 15.0,
    grossTotal: 115.0,
    status: 'PENDING_SYNC',
    createdAt: now,
    previousHash: 'prev',
    currentHash: 'currenthash',
    items: const [
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
  );

  setUp(() {
    invoiceRepo = MockInvoiceRepository();
    storeRepo = MockStoreConfigRepository();
    userRepo = MockUserRepository();
    repository = ReceiptRepositoryImpl(invoiceRepo, storeRepo, userRepo);

    when(() => invoiceRepo.getInvoiceById(any()))
        .thenAnswer((_) async => invoice);
    when(storeRepo.getStoreConfig).thenAnswer((_) async => store);
    when(() => userRepo.getUserById(any())).thenAnswer((_) async => user);
  });

  group('ReceiptRepositoryImpl', () {
    test('maps invoice, store, cashier and payment into ReceiptData', () async {
      final receipt = await repository.getReceipt(1);

      expect(receipt.tradeName, 'Trade Name');
      expect(receipt.tin, '1234567890');
      expect(receipt.vatRegNo, 'VAT-001');
      expect(receipt.invoiceNumber, 42);
      expect(receipt.cashierName, 'Abebe Bikila');
      expect(receipt.buyerTin, '0987654321');
      expect(receipt.items.length, 1);
      expect(receipt.items.first.name, 'Coffee');
      expect(receipt.grossTotal, 115.0);
      expect(receipt.paymentMethod, 'Cash');
      expect(receipt.hash, 'currenthash');
    });

    test('falls back to cashier id when user record is missing', () async {
      when(() => userRepo.getUserById(any())).thenAnswer((_) async => null);

      final receipt = await repository.getReceipt(1);

      expect(receipt.cashierName, 'c1');
    });

    test('throws NotFoundFailure when invoice is missing', () async {
      when(() => invoiceRepo.getInvoiceById(any()))
          .thenAnswer((_) async => throw const NotFoundFailure('missing'));

      expect(() => repository.getReceipt(99), throwsA(isA<NotFoundFailure>()));
    });

    test('throws CacheFailure when store is not activated', () async {
      when(storeRepo.getStoreConfig).thenAnswer((_) async => null);

      expect(() => repository.getReceipt(1), throwsA(isA<CacheFailure>()));
    });

    test('QR payload is deterministic and includes required fields', () async {
      final receipt = await repository.getReceipt(1);
      final decoded = jsonDecode(receipt.qrPayload) as Map<String, dynamic>;

      expect(decoded, isA<Map<String, dynamic>>());
      expect(decoded['tin'], '1234567890');
      expect(decoded['invoiceNumber'], 42);
      expect(decoded['grossTotal'], 115.0);
      expect(decoded['hash'], 'currenthash');
      expect(decoded['buyerTin'], '0987654321');
      expect(decoded.containsKey('timestamp'), isTrue);

      final second = await repository.getReceipt(1);
      expect(second.qrPayload, receipt.qrPayload);
    });
  });
}
