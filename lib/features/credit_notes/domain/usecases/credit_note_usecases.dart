import '../entities/return_invoice.dart';
import '../repositories/credit_note_repository.dart';

class FindReturnInvoice {
  final CreditNoteRepository repository;
  const FindReturnInvoice(this.repository);
  Future<ReturnInvoice> call(int number) => repository.findInvoice(number);
}

class CreateCreditNote {
  final CreditNoteRepository repository;
  const CreateCreditNote(this.repository);
  Future<CreditNoteResult> call({
    required int invoiceId,
    required String managerId,
    required String reason,
    required Map<int, double> quantities,
  }) => repository.create(
    invoiceId: invoiceId,
    managerId: managerId,
    reason: reason,
    quantities: quantities,
  );
}
