import '../entities/receipt_data.dart';

/// Repository that assembles a [ReceiptData] from a persisted invoice ID.
abstract class ReceiptRepository {
  /// Returns the complete receipt data for [invoiceId].
  ///
  /// Throws a [NotFoundFailure] when the invoice does not exist and a
  /// [CacheFailure] when the store configuration is missing.
  Future<ReceiptData> getReceipt(int invoiceId);
}
