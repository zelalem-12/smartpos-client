class CreditNoteLineRequest {
  final int invoiceItemId;
  final double quantity;
  const CreditNoteLineRequest(this.invoiceItemId, this.quantity);
}

class CreateCreditNoteRequest {
  final int invoiceId;
  final String managerId;
  final String reason;
  final List<CreditNoteLineRequest> items;
  const CreateCreditNoteRequest({
    required this.invoiceId,
    required this.managerId,
    required this.reason,
    required this.items,
  });
}

class CreateCancellationRequest {
  final int invoiceId;
  final String managerId;
  final String reason;
  final DateTime now;
  const CreateCancellationRequest({
    required this.invoiceId,
    required this.managerId,
    required this.reason,
    required this.now,
  });
}

class ReportTotals {
  final DateTime date;
  final int invoiceCount;
  final double netTotal, vatTotal, grossTotal;
  final double creditNetTotal, creditVatTotal, creditGrossTotal;
  final double cashTotal, telebirrTotal, cbeBirrTotal;
  const ReportTotals({
    required this.date,
    required this.invoiceCount,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.creditNetTotal,
    required this.creditVatTotal,
    required this.creditGrossTotal,
    required this.cashTotal,
    required this.telebirrTotal,
    required this.cbeBirrTotal,
  });
}
