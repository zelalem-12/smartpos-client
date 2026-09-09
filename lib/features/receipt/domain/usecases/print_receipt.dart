import '../../../../core/printer/printer_service.dart';
import '../entities/receipt_data.dart';
import '../../../../core/printer/receipt_printer.dart';

/// Prints a receipt through the configured [PrinterService].
class PrintReceipt {
  final ReceiptPrinter _receiptPrinter;

  PrintReceipt(PrinterService printer)
    : _receiptPrinter = ReceiptPrinter(printer);

  Future<bool> call(ReceiptData data, {bool isDuplicate = false}) =>
      _receiptPrinter.print(data, isDuplicate: isDuplicate);
}
