import '../entities/receipt_data.dart';
import '../repositories/receipt_repository.dart';

/// Loads a full receipt from a persisted invoice ID.
class GenerateReceipt {
  final ReceiptRepository _repository;

  const GenerateReceipt(this._repository);

  Future<ReceiptData> call(int invoiceId) => _repository.getReceipt(invoiceId);
}
