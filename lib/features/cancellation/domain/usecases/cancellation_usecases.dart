import '../../../credit_notes/domain/entities/return_invoice.dart';
import '../repositories/cancellation_repository.dart';

class FindCancellationInvoice {
  final CancellationRepository repository;
  const FindCancellationInvoice(this.repository);
  Future<ReturnInvoice> call(int number) => repository.findInvoice(number);
}

class RequestCancellation {
  final CancellationRepository repository;
  const RequestCancellation(this.repository);
  Future<void> call({
    required int invoiceId,
    required String managerId,
    required String reason,
    DateTime? now,
  }) => repository.request(
    invoiceId: invoiceId,
    managerId: managerId,
    reason: reason,
    now: now ?? DateTime.now(),
  );
}
