import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/repositories/store_config_repository.dart';
import '../../../../core/repositories/user_repository.dart';
import '../../../invoice/domain/repositories/invoice_repository.dart';
import '../../domain/entities/receipt_data.dart';
import '../../domain/repositories/receipt_repository.dart';

/// Assembles a [ReceiptData] from the local invoice, store config and user
/// records without introducing any new database schema.
class ReceiptRepositoryImpl implements ReceiptRepository {
  final InvoiceRepository _invoiceRepository;
  final StoreConfigRepository _storeConfigRepository;
  final UserRepository _userRepository;

  ReceiptRepositoryImpl(
    this._invoiceRepository,
    this._storeConfigRepository,
    this._userRepository,
  );

  @override
  Future<ReceiptData> getReceipt(int invoiceId) async {
    final invoice = await _invoiceRepository.getInvoiceById(invoiceId);
    final store = await _storeConfigRepository.getStoreConfig();

    if (store == null) {
      throw const CacheFailure('Store is not activated');
    }

    final user = await _userRepository.getUserById(invoice.cashierId);
    final cashierName = user?.fullName ?? invoice.cashierId;

    final qrPayload = AppDatabase.toDeterministicJson({
      'tin': store.tin,
      'invoiceNumber': invoice.invoiceNumber,
      'grossTotal': invoice.grossTotal,
      'timestamp': invoice.createdAt.toIso8601String(),
      'hash': invoice.currentHash,
      if (invoice.buyerTin != null) 'buyerTin': invoice.buyerTin,
    });

    return ReceiptData(
      businessName: store.businessName,
      tradeName: store.tradeName,
      address: store.address,
      tin: store.tin,
      vatRegNo: store.vatRegNo,
      invoiceNumber: invoice.invoiceNumber,
      invoiceDate: invoice.createdAt,
      cashierName: cashierName,
      buyerTin: invoice.buyerTin,
      items: invoice.items
          .map(
            (i) => ReceiptItem(
              name: i.productName,
              quantity: i.quantity,
              unitPrice: i.unitPrice,
              vatRate: i.vatRate,
              netAmount: i.netAmount,
              vatAmount: i.vatAmount,
              grossAmount: i.grossAmount,
            ),
          )
          .toList(),
      netTotal: invoice.netTotal,
      vatTotal: invoice.vatTotal,
      grossTotal: invoice.grossTotal,
      paymentMethod: invoice.payment.method.label,
      hash: invoice.currentHash,
      qrPayload: qrPayload,
    );
  }
}
