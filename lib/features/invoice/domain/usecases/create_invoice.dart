import '../../../pos/domain/entities/cart_entity.dart';
import '../entities/invoice_entity.dart';
import '../entities/payment_method.dart';
import '../repositories/invoice_repository.dart';

/// Creates a fiscal invoice from the current cart.
class CreateInvoice {
  final InvoiceRepository _repository;

  const CreateInvoice(this._repository);

  /// Persists an invoice with the selected [paymentMethod] for [cashierId].
  ///
  /// [cashTendered] is only meaningful for [PaymentMethod.cash].
  Future<InvoiceEntity> call({
    required CartEntity cart,
    required PaymentMethod paymentMethod,
    required String cashierId,
    double? cashTendered,
    String? buyerTin,
  }) {
    return _repository.createInvoice(
      cart: cart,
      paymentMethod: paymentMethod,
      cashierId: cashierId,
      cashTendered: cashTendered,
      buyerTin: buyerTin,
    );
  }
}
