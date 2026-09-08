/// Plain data carrier for the atomic invoice creation transaction.
///
/// All monetary values are tax-inclusive where applicable; net/vat/gross are
/// already computed by the caller.
class CreateInvoiceDbRequest {
  final String cashierId;
  final String? buyerTin;
  final double netTotal;
  final double vatTotal;
  final double grossTotal;
  final String status;
  final List<CreateInvoiceItemDbRequest> items;
  final String paymentMethod;
  final double paymentAmount;
  final double? cashTendered;
  final String? paymentReference;
  final String Function(int invoiceNumber) payloadBuilder;
  final String syncOperation;
  final String auditAction;
  final String auditUserId;

  const CreateInvoiceDbRequest({
    required this.cashierId,
    this.buyerTin,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.status,
    required this.items,
    required this.paymentMethod,
    required this.paymentAmount,
    this.cashTendered,
    this.paymentReference,
    required this.payloadBuilder,
    required this.syncOperation,
    required this.auditAction,
    required this.auditUserId,
  });
}

/// Line item data carrier for the atomic invoice creation transaction.
class CreateInvoiceItemDbRequest {
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double vatRate;
  final double netAmount;
  final double vatAmount;
  final double grossAmount;

  const CreateInvoiceItemDbRequest({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.vatRate,
    required this.netAmount,
    required this.vatAmount,
    required this.grossAmount,
  });
}
