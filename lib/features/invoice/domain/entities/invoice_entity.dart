import 'package:equatable/equatable.dart';

import 'invoice_item_entity.dart';
import 'payment_entity.dart';

/// Domain representation of a persisted fiscal invoice.
class InvoiceEntity extends Equatable {
  final String id;
  final int invoiceNumber;
  final String cashierId;
  final String? buyerTin;
  final double netTotal;
  final double vatTotal;
  final double grossTotal;
  final String status;
  final DateTime createdAt;
  final List<InvoiceItemEntity> items;
  final PaymentEntity payment;
  final String previousHash;
  final String currentHash;

  const InvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.cashierId,
    this.buyerTin,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.status,
    required this.createdAt,
    required this.items,
    required this.payment,
    required this.previousHash,
    required this.currentHash,
  });

  @override
  List<Object?> get props => [
    id,
    invoiceNumber,
    cashierId,
    buyerTin,
    netTotal,
    vatTotal,
    grossTotal,
    status,
    createdAt,
    items,
    payment,
    previousHash,
    currentHash,
  ];
}
