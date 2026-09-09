import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/core/printer/printer_service.dart';
import 'package:smartpos_client/core/printer/receipt_printer.dart';
import 'package:smartpos_client/features/receipt/domain/entities/receipt_data.dart';

class MockPrinterService extends Mock implements PrinterService {}

void main() {
  late MockPrinterService service;
  late ReceiptPrinter printer;

  final now = DateTime(2024, 1, 1, 12, 0);
  final receipt = ReceiptData(
    businessName: 'Business Name',
    tradeName: 'Trade Name',
    address: 'Addis Ababa',
    tin: '1234567890',
    vatRegNo: 'VAT-001',
    invoiceNumber: 7,
    invoiceDate: now,
    cashierName: 'Abebe',
    buyerTin: '0987654321',
    items: const [
      ReceiptItem(
        name: 'Coffee',
        quantity: 2,
        unitPrice: 50.0,
        vatRate: 0.15,
        netAmount: 86.96,
        vatAmount: 13.04,
        grossAmount: 100.0,
      ),
      ReceiptItem(
        name: 'Tea',
        quantity: 1,
        unitPrice: 15.0,
        vatRate: 0.15,
        netAmount: 13.04,
        vatAmount: 1.96,
        grossAmount: 15.0,
      ),
    ],
    netTotal: 100.0,
    vatTotal: 15.0,
    grossTotal: 115.0,
    paymentMethod: 'Cash',
    hash: 'fiscalhash',
    qrPayload: 'qr-data',
  );

  setUp(() {
    service = MockPrinterService();
    printer = ReceiptPrinter(service);

    when(service.init).thenAnswer((_) async {});
    when(service.getStatus).thenAnswer((_) async => PrinterStatus.ready);
    when(() => service.printReceipt(any<List<PrintLine>>()))
        .thenAnswer((_) async => true);
    when(() => service.printQrCode(any<String>(), size: any(named: 'size')))
        .thenAnswer((_) async => true);
    when(service.cutPaper).thenAnswer((_) async {});
  });

  group('ReceiptPrinter', () {
    test(
      'buildLines includes header, item lines, totals and duplicate watermark',
      () {
        final lines = printer.buildLines(receipt, isDuplicate: true);
        final texts = lines.map((l) => l.text).join('\n');

        expect(texts, contains('Trade Name'));
        expect(texts, contains('TIN: 1234567890'));
        expect(texts, contains('Coffee'));
        expect(texts, contains('Tea'));
        expect(texts, contains('Gross total:'));
        expect(texts, contains('115.00'));
        expect(texts, contains('Payment:'));
        expect(texts, contains('Cash'));
        expect(texts, contains('Buyer TIN: 0987654321'));
        expect(texts, contains('fiscalhash'));
        expect(texts, contains('*** DUPLICATE COPY / ድጋሚ የታተመ ***'));
      },
    );

    test('buildLines omits buyer TIN when not present', () {
      final noBuyer = receipt.copyWithNoBuyerTin();
      final lines = printer.buildLines(noBuyer);
      final texts = lines.map((l) => l.text).join('\n');

      expect(texts, isNot(contains('Buyer TIN:')));
    });

    test('print initializes, prints receipt, qr code and cuts paper', () async {
      await printer.print(receipt);

      verify(service.init).called(1);
      verify(service.getStatus).called(1);
      verify(() => service.printReceipt(any<List<PrintLine>>())).called(1);
      verify(() => service.printQrCode('qr-data', size: 6)).called(1);
      verify(service.cutPaper).called(1);
    });

    test('print throws when printer is not ready', () async {
      when(service.getStatus).thenAnswer((_) async => PrinterStatus.noPaper);

      expect(() => printer.print(receipt), throwsA(isA<CacheFailure>()));
    });
  });
}

extension _ReceiptDataCopy on ReceiptData {
  ReceiptData copyWithNoBuyerTin() => ReceiptData(
    businessName: businessName,
    tradeName: tradeName,
    address: address,
    tin: tin,
    vatRegNo: vatRegNo,
    invoiceNumber: invoiceNumber,
    invoiceDate: invoiceDate,
    cashierName: cashierName,
    buyerTin: null,
    items: items,
    netTotal: netTotal,
    vatTotal: vatTotal,
    grossTotal: grossTotal,
    paymentMethod: paymentMethod,
    hash: hash,
    qrPayload: qrPayload,
  );
}
