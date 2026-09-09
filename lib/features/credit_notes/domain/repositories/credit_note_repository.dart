import '../entities/return_invoice.dart';

abstract interface class CreditNoteRepository {
  Future<ReturnInvoice> findInvoice(int invoiceNumber);
  Future<CreditNoteResult> create({
    required int invoiceId,
    required String managerId,
    required String reason,
    required Map<int, double> quantities,
  });
}
