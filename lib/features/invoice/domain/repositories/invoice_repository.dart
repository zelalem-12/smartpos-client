import '../../../pos/domain/entities/cart_entity.dart';
import '../entities/invoice_entity.dart';
import '../entities/payment_method.dart';

/// Repository for creating and querying fiscal invoices.
abstract class InvoiceRepository {
  /// Creates a new invoice from the current [cart] for the supplied
  /// [cashierId] and [paymentMethod].
  ///
  /// [cashTendered] is required only for [PaymentMethod.cash].
  /// [buyerTin] is optional and must be exactly 10 digits when provided.
  Future<InvoiceEntity> createInvoice({
    required CartEntity cart,
    required PaymentMethod paymentMethod,
    required String cashierId,
    double? cashTendered,
    String? buyerTin,
  });
}
