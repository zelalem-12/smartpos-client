import '../../../../core/database/app_database.dart';
import '../../../../core/database/create_invoice_request.dart';
import '../../../../core/utils/vat_calculator.dart';
import '../../../pos/domain/entities/cart_entity.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/entities/invoice_item_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/invoice_repository.dart';

/// Drift-backed implementation of [InvoiceRepository].
class InvoiceRepositoryImpl implements InvoiceRepository {
  final AppDatabase _db;

  const InvoiceRepositoryImpl(this._db);

  @override
  Future<InvoiceEntity> createInvoice({
    required CartEntity cart,
    required PaymentMethod paymentMethod,
    required String cashierId,
    double? cashTendered,
    String? buyerTin,
  }) async {
    final items = _buildItems(cart);
    final totals = cart.totals;

    final request = CreateInvoiceDbRequest(
      cashierId: cashierId,
      buyerTin: buyerTin,
      netTotal: totals.net,
      vatTotal: totals.vat,
      grossTotal: totals.gross,
      status: 'PENDING_SYNC',
      items: items,
      paymentMethod: paymentMethod.name,
      paymentAmount: totals.gross,
      cashTendered: paymentMethod == PaymentMethod.cash ? cashTendered : null,
      paymentReference: paymentMethod == PaymentMethod.cash ? null : '',
      payloadBuilder: (invoiceNumber) => _buildPayload(
        invoiceNumber: invoiceNumber,
        cashierId: cashierId,
        buyerTin: buyerTin,
        totals: totals,
        items: items,
        paymentMethod: paymentMethod,
      ),
      syncOperation: 'CREATE_INVOICE',
      auditAction: 'INVOICE_CREATED',
      auditUserId: cashierId,
    );

    final invoice = await _db.createInvoiceTransaction(request);
    final invoiceItems = await _db.getInvoiceItemsByInvoiceId(invoice.id);
    final payment = await _db.getPaymentByInvoiceId(invoice.id);

    return _mapInvoice(
      invoice: invoice,
      items: invoiceItems,
      payment: payment!,
    );
  }

  List<CreateInvoiceItemDbRequest> _buildItems(CartEntity cart) {
    return cart.items.map((line) {
      final gross = line.grossTotal;
      final net = VatCalculator.grossToNet(gross);
      final vat = gross - net;
      return CreateInvoiceItemDbRequest(
        productId: line.product.id,
        productName: line.product.name,
        unitPrice: line.product.price,
        quantity: line.quantity,
        vatRate: line.product.vatRate,
        netAmount: net,
        vatAmount: vat,
        grossAmount: gross,
      );
    }).toList();
  }

  String _buildPayload({
    required int invoiceNumber,
    required String cashierId,
    required String? buyerTin,
    required _Totals totals,
    required List<CreateInvoiceItemDbRequest> items,
    required PaymentMethod paymentMethod,
  }) {
    final payload = <String, dynamic>{
      'invoiceNumber': invoiceNumber,
      'cashierId': cashierId,
      'buyerTin': buyerTin,
      'netTotal': totals.net,
      'vatTotal': totals.vat,
      'grossTotal': totals.gross,
      'status': 'PENDING_SYNC',
      'paymentMethod': paymentMethod.name,
      'items': items
          .map(
            (i) => <String, dynamic>{
              'productId': i.productId,
              'productName': i.productName,
              'unitPrice': i.unitPrice,
              'quantity': i.quantity,
              'vatRate': i.vatRate,
              'netAmount': i.netAmount,
              'vatAmount': i.vatAmount,
              'grossAmount': i.grossAmount,
            },
          )
          .toList(),
    };
    return AppDatabase.toDeterministicJson(payload);
  }

  InvoiceEntity _mapInvoice({
    required Invoice invoice,
    required List<InvoiceItem> items,
    required Payment payment,
  }) {
    return InvoiceEntity(
      id: invoice.id.toString(),
      invoiceNumber: invoice.invoiceNumber,
      cashierId: invoice.cashierId,
      buyerTin: invoice.buyerTin,
      netTotal: invoice.netTotal,
      vatTotal: invoice.vatTotal,
      grossTotal: invoice.grossTotal,
      status: invoice.status,
      createdAt: invoice.createdAt,
      previousHash: invoice.previousHash,
      currentHash: invoice.currentHash,
      items: items
          .map(
            (i) => InvoiceItemEntity(
              productId: i.productId,
              productName: i.productName,
              unitPrice: i.unitPrice,
              quantity: i.quantity,
              vatRate: i.vatRate,
              netAmount: i.netAmount,
              vatAmount: i.vatAmount,
              grossAmount: i.grossAmount,
            ),
          )
          .toList(),
      payment: PaymentEntity(
        method: PaymentMethod.values.byName(payment.method),
        amount: payment.amount,
        cashTendered: payment.cashTendered,
        referenceCode: payment.referenceCode,
      ),
    );
  }
}

extension _CartTotals on CartEntity {
  _Totals get totals =>
      _Totals(net: netTotal, vat: vatTotal, gross: grossTotal);
}

class _Totals {
  final double net;
  final double vat;
  final double gross;

  const _Totals({required this.net, required this.vat, required this.gross});
}
