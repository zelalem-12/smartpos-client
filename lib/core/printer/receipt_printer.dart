import 'dart:math';

import 'package:intl/intl.dart';

import '../../features/receipt/domain/entities/receipt_data.dart';
import '../constants/app_constants.dart';
import '../error/failures.dart';
import '../utils/currency_formatter.dart';
import 'printer_service.dart';

/// Converts a [ReceiptData] into thermal [PrintLine]s and drives the printer.
class ReceiptPrinter {
  static const int _lineWidth = 32;

  final PrinterService _printer;

  const ReceiptPrinter(this._printer);

  /// Prints the receipt, including its QR code and a paper cut.
  ///
  /// [isDuplicate] adds a bilingual watermark to the printed output.
  Future<bool> print(ReceiptData receipt, {bool isDuplicate = false}) async {
    await _printer.init();
    final status = await _printer.getStatus();
    if (status != PrinterStatus.ready) {
      throw CacheFailure('Printer not ready: ${status.name}');
    }

    final lines = buildLines(receipt, isDuplicate: isDuplicate);
    await _printer.printReceipt(lines);
    await _printer.printQrCode(receipt.qrPayload, size: 6);
    await _printer.cutPaper();

    return true;
  }

  /// Builds the list of formatted lines that the printer will output.
  List<PrintLine> buildLines(ReceiptData receipt, {bool isDuplicate = false}) {
    final lines = <PrintLine>[];

    if (isDuplicate) {
      lines.add(
        const PrintLine.center('*** DUPLICATE COPY / ድጋሚ የታተመ ***', bold: true),
      );
      lines.add(const PrintLine.center('--------------------------------'));
    }

    lines.add(
      PrintLine.center(
        receipt.tradeName,
        bold: true,
        fontSize: PrintFontSize.large,
      ),
    );
    lines.add(PrintLine.center(receipt.businessName));
    lines.add(PrintLine.center(receipt.address));
    lines.add(PrintLine.center('TIN: ${receipt.tin}'));
    lines.add(PrintLine.center('VAT Reg: ${receipt.vatRegNo}'));
    lines.add(const PrintLine.center('--------------------------------'));

    lines.add(PrintLine('Invoice: ${receipt.formattedInvoiceNumber}'));
    lines.add(PrintLine('Date: ${_formatDate(receipt.invoiceDate)}'));
    lines.add(PrintLine('Cashier: ${receipt.cashierName}'));
    if (receipt.buyerTin != null) {
      lines.add(PrintLine('Buyer TIN: ${receipt.buyerTin}'));
    }
    lines.add(const PrintLine(''));

    for (final item in receipt.items) {
      lines.add(
        PrintLine(_itemLine(item), bold: false, fontSize: PrintFontSize.normal),
      );
    }

    lines.add(const PrintLine.center('--------------------------------'));
    lines.add(_twoColumn('Net total:', _formatAmount(receipt.netTotal)));
    lines.add(
      _twoColumn('${AppConstants.vatLabel}:', _formatAmount(receipt.vatTotal)),
    );
    lines.add(
      _twoColumn('Gross total:', _formatAmount(receipt.grossTotal), bold: true),
    );
    lines.add(_twoColumn('Payment:', receipt.paymentMethod));
    lines.add(const PrintLine(''));
    lines.add(const PrintLine.center('Fiscal hash:'));
    lines.add(PrintLine.center(receipt.hash, fontSize: PrintFontSize.small));
    lines.add(const PrintLine(''));
    lines.add(const PrintLine.center('Thank you for your business!'));
    lines.add(const PrintLine.center('Powered by SmartPOS Ethiopia'));

    return lines;
  }

  String _itemLine(ReceiptItem item) {
    final qty = item.quantity.toString();
    final unit = CurrencyFormatter.formatCompact(item.unitPrice);
    final total = CurrencyFormatter.formatCompact(item.grossAmount);
    final prefix = '$qty x $unit ';
    final maxNameLength = _lineWidth - total.length - 1;
    final name = _fit(item.name, max(0, maxNameLength));
    return _padTwoColumn('$name $prefix', total);
  }

  PrintLine _twoColumn(String left, String right, {bool bold = false}) {
    final text = _padTwoColumn(left, right);
    final align = PrintAlignment.left;
    final fontSize = bold ? PrintFontSize.normal : PrintFontSize.normal;
    return PrintLine(text, bold: bold, alignment: align, fontSize: fontSize);
  }

  String _padTwoColumn(String left, String right) {
    final cleanLeft = _fit(left, _lineWidth);
    final pad = _lineWidth - cleanLeft.length - right.length;
    if (pad <= 0) return '$cleanLeft $right';
    return cleanLeft + (' ' * pad) + right;
  }

  String _fit(String value, int length) {
    if (value.length <= length) return value;
    if (length <= 3) return value;
    return '${value.substring(0, length - 3)}...';
  }

  String _formatAmount(double amount) {
    return CurrencyFormatter.formatCompact(amount);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date.toLocal());
  }
}
