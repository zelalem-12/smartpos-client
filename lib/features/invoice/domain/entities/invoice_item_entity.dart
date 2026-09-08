import 'package:equatable/equatable.dart';

/// Domain representation of a single line item on an invoice.
class InvoiceItemEntity extends Equatable {
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double vatRate;
  final double netAmount;
  final double vatAmount;
  final double grossAmount;

  const InvoiceItemEntity({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.vatRate,
    required this.netAmount,
    required this.vatAmount,
    required this.grossAmount,
  });

  @override
  List<Object?> get props => [
    productId,
    productName,
    unitPrice,
    quantity,
    vatRate,
    netAmount,
    vatAmount,
    grossAmount,
  ];
}
