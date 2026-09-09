import '../../../../core/database/app_database.dart';
import '../../../../core/database/phase9_requests.dart';
import '../../../../core/error/failures.dart';
import '../../../credit_notes/data/repositories/credit_note_repository_impl.dart';
import '../../../credit_notes/domain/entities/return_invoice.dart';
import '../../domain/repositories/cancellation_repository.dart';

class CancellationRepositoryImpl implements CancellationRepository {
  final AppDatabase db;
  const CancellationRepositoryImpl(this.db);
  @override
  Future<ReturnInvoice> findInvoice(int invoiceNumber) =>
      CreditNoteRepositoryImpl(db).findInvoice(invoiceNumber);
  @override
  Future<void> request({
    required int invoiceId,
    required String managerId,
    required String reason,
    required DateTime now,
  }) async {
    try {
      await db.createCancellationTransaction(
        CreateCancellationRequest(
          invoiceId: invoiceId,
          managerId: managerId,
          reason: reason,
          now: now,
        ),
      );
    } on ArgumentError catch (e) {
      throw ValidationFailure(e.message?.toString() ?? 'Invalid cancellation');
    } on StateError catch (e) {
      throw ConflictFailure(e.message);
    }
  }
}
