import 'package:equatable/equatable.dart';

class ReturnInvoiceItem extends Equatable {
  final int id;
  final String name;
  final double quantity;
  final double returnedQuantity;
  final double unitPrice;
  final double netAmount;
  final double vatAmount;
  final double grossAmount;
  const ReturnInvoiceItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.returnedQuantity,
    required this.unitPrice,
    required this.netAmount,
    required this.vatAmount,
    required this.grossAmount,
  });
  double get remainingQuantity => quantity - returnedQuantity;
  @override
  List<Object?> get props => [
    id,
    name,
    quantity,
    returnedQuantity,
    unitPrice,
    netAmount,
    vatAmount,
    grossAmount,
  ];
}

class ReturnInvoice extends Equatable {
  final int id;
  final int number;
  final String? buyerTin;
  final String status;
  final DateTime createdAt;
  final double netTotal, vatTotal, grossTotal;
  final List<ReturnInvoiceItem> items;
  const ReturnInvoice({
    required this.id,
    required this.number,
    required this.buyerTin,
    required this.status,
    required this.createdAt,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.items,
  });
  @override
  List<Object?> get props => [
    id,
    number,
    buyerTin,
    status,
    createdAt,
    netTotal,
    vatTotal,
    grossTotal,
    items,
  ];
}

class CreditNoteResult extends Equatable {
  final int number;
  final double netTotal, vatTotal, grossTotal;
  const CreditNoteResult(
    this.number,
    this.netTotal,
    this.vatTotal,
    this.grossTotal,
  );
  @override
  List<Object?> get props => [number, netTotal, vatTotal, grossTotal];
}
