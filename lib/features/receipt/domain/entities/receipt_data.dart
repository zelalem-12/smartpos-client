import 'package:equatable/equatable.dart';

/// A single line item on a thermal receipt.
class ReceiptItem extends Equatable {
  final String name;
  final int quantity;
  final double unitPrice;
  final double vatRate;
  final double netAmount;
  final double vatAmount;
  final double grossAmount;

  const ReceiptItem({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.vatRate,
    required this.netAmount,
    required this.vatAmount,
    required this.grossAmount,
  });

  @override
  List<Object?> get props => [
    name,
    quantity,
    unitPrice,
    vatRate,
    netAmount,
    vatAmount,
    grossAmount,
  ];
}

/// Full receipt payload used by the preview and the thermal printer.
class ReceiptData extends Equatable {
  final String businessName;
  final String tradeName;
  final String address;
  final String tin;
  final String vatRegNo;
  final int invoiceNumber;
  final DateTime invoiceDate;
  final String cashierName;
  final String? buyerTin;
  final List<ReceiptItem> items;
  final double netTotal;
  final double vatTotal;
  final double grossTotal;
  final String paymentMethod;
  final String hash;
  final String qrPayload;

  const ReceiptData({
    required this.businessName,
    required this.tradeName,
    required this.address,
    required this.tin,
    required this.vatRegNo,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.cashierName,
    this.buyerTin,
    required this.items,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.paymentMethod,
    required this.hash,
    required this.qrPayload,
  });

  String get formattedInvoiceNumber =>
      '#${invoiceNumber.toString().padLeft(6, '0')}';

  @override
  List<Object?> get props => [
    businessName,
    tradeName,
    address,
    tin,
    vatRegNo,
    invoiceNumber,
    invoiceDate,
    cashierName,
    buyerTin,
    items,
    netTotal,
    vatTotal,
    grossTotal,
    paymentMethod,
    hash,
    qrPayload,
  ];
}
