import '../../../../core/database/app_database.dart';
import '../../../../core/database/phase9_requests.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/return_invoice.dart';
import '../../domain/repositories/credit_note_repository.dart';

class CreditNoteRepositoryImpl implements CreditNoteRepository {
  final AppDatabase db;
  const CreditNoteRepositoryImpl(this.db);
  @override
  Future<ReturnInvoice> findInvoice(int invoiceNumber) async {
    final invoice = await db.getInvoiceByNumber(invoiceNumber);
    if (invoice == null) {
      throw NotFoundFailure('Invoice #$invoiceNumber not found');
    }
    final rows = await db.getInvoiceItemsByInvoiceId(invoice.id);
    final items = <ReturnInvoiceItem>[];
    for (final row in rows) {
      items.add(
        ReturnInvoiceItem(
          id: row.id,
          name: row.productName,
          quantity: row.quantity.toDouble(),
          returnedQuantity: await db.getReturnedQuantity(row.id),
          unitPrice: row.unitPrice,
          netAmount: row.netAmount,
          vatAmount: row.vatAmount,
          grossAmount: row.grossAmount,
        ),
      );
    }
    return ReturnInvoice(
      id: invoice.id,
      number: invoice.invoiceNumber,
      buyerTin: invoice.buyerTin,
      status: invoice.status,
      createdAt: invoice.createdAt,
      netTotal: invoice.netTotal,
      vatTotal: invoice.vatTotal,
      grossTotal: invoice.grossTotal,
      items: items,
    );
  }

  @override
  Future<CreditNoteResult> create({
    required int invoiceId,
    required String managerId,
    required String reason,
    required Map<int, double> quantities,
  }) async {
    try {
      final note = await db.createCreditNoteTransaction(
        CreateCreditNoteRequest(
          invoiceId: invoiceId,
          managerId: managerId,
          reason: reason,
          items: quantities.entries
              .map((e) => CreditNoteLineRequest(e.key, e.value))
              .toList(),
        ),
      );
      return CreditNoteResult(
        note.creditNoteNumber,
        note.netTotal,
        note.vatTotal,
        note.grossTotal,
      );
    } on ArgumentError catch (e) {
      throw ValidationFailure(e.message?.toString() ?? 'Invalid credit note');
    } on StateError catch (e) {
      throw ConflictFailure(e.message);
    }
  }
}
