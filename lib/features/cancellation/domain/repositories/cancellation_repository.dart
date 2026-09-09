import '../../../credit_notes/domain/entities/return_invoice.dart';

abstract interface class CancellationRepository {
  Future<ReturnInvoice> findInvoice(int invoiceNumber);
  Future<void> request({
    required int invoiceId,
    required String managerId,
    required String reason,
    required DateTime now,
  });
}
