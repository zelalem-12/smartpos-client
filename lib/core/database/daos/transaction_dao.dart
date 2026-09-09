import 'dart:convert';

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../create_invoice_request.dart';
import '../phase9_requests.dart';
import '../tables/audit_log_table.dart';
import '../tables/cancellation_requests_table.dart';
import '../tables/credit_notes_table.dart';
import '../tables/daily_reports_table.dart';
import '../tables/invoice_items_table.dart';
import '../tables/invoices_table.dart';
import '../tables/payments_table.dart';
import '../tables/sync_queue_table.dart';
import '../../utils/hash_chain.dart';

part 'transaction_dao.g.dart';

/// Owns the cross-table transactional operations that must run atomically:
/// invoice creation, credit notes, cancellations, and Z reports.
///
/// Each method appends a tamper-evident audit-log entry chained via SHA-256
/// and queues a sync entry. Business validation (reason non-empty, quantity
/// limits, cancellation window, etc.) is intentionally kept here for now
/// because it must run *inside* the transaction to be correct; it can be
/// extracted into domain services later once the transaction boundary is
/// preserved.
@DriftAccessor(
  tables: [
    Invoices,
    InvoiceItems,
    Payments,
    SyncQueue,
    AuditLogs,
    CreditNotes,
    CreditNoteItems,
    CancellationRequests,
    DailyReports,
  ],
)
class TransactionDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionDaoMixin {
  TransactionDao(super.db);

  // ─── Invoice creation ───────────────────────────────────────────────

  /// Atomically creates an invoice, its line items, payment record, a
  /// pending sync entry, and an audit-log entry with a chained SHA-256 hash.
  Future<Invoice> createInvoiceTransaction(CreateInvoiceDbRequest request) {
    return transaction(() async {
      // 1. Compute the next device-local invoice number.
      final maxExpr = invoices.invoiceNumber.max();
      final maxRow = await (selectOnly(
        invoices,
      )..addColumns([maxExpr])).getSingle();
      final nextNumber = (maxRow.read(maxExpr) ?? 0) + 1;

      // 2. Hash-chain anchor from the most recent audit entry.
      final lastAudit =
          await (select(auditLogs)
                ..orderBy([(a) => OrderingTerm.desc(a.id)])
                ..limit(1))
              .getSingleOrNull();
      final previousHash = lastAudit?.currentHash ?? '';

      // 3. Deterministic payload is supplied by the caller; the invoice
      //    number is injected here so the caller cannot use a stale value.
      final payload = request.payloadBuilder(nextNumber);
      final currentHash = HashChain.computeHash(previousHash, payload);

      // 4. Insert invoice header.
      final invoiceId = await into(invoices).insert(
        InvoicesCompanion.insert(
          invoiceNumber: nextNumber,
          cashierId: request.cashierId,
          buyerTin: request.buyerTin == null
              ? const Value.absent()
              : Value(request.buyerTin!),
          netTotal: request.netTotal,
          vatTotal: request.vatTotal,
          grossTotal: request.grossTotal,
          status: Value(request.status),
          payload: payload,
          previousHash: previousHash,
          currentHash: currentHash,
        ),
      );

      // 5. Insert line items.
      for (final item in request.items) {
        await into(invoiceItems).insert(
          InvoiceItemsCompanion.insert(
            invoiceId: invoiceId,
            productId: item.productId,
            productName: item.productName,
            unitPrice: item.unitPrice,
            quantity: Value(item.quantity),
            vatRate: Value(item.vatRate),
            netAmount: item.netAmount,
            vatAmount: item.vatAmount,
            grossAmount: item.grossAmount,
          ),
        );
      }

      // 6. Insert payment record.
      await into(payments).insert(
        PaymentsCompanion.insert(
          invoiceId: invoiceId,
          method: request.paymentMethod,
          amount: request.paymentAmount,
          cashTendered: request.cashTendered == null
              ? const Value.absent()
              : Value(request.cashTendered!),
          referenceCode: request.paymentReference == null
              ? const Value.absent()
              : Value(request.paymentReference!),
        ),
      );

      // 7. Queue the invoice for backend sync.
      await into(syncQueue).insert(
        SyncQueueCompanion.insert(
          invoiceId: invoiceId,
          operation: request.syncOperation,
          payload: payload,
        ),
      );

      // 8. Append the tamper-evident audit entry.
      await into(auditLogs).insert(
        AuditLogsCompanion.insert(
          action: request.auditAction,
          invoiceId: Value(invoiceId),
          userId: request.auditUserId,
          details: 'Invoice #$nextNumber created by ${request.cashierId}',
          payload: Value(payload),
          previousHash: previousHash,
          currentHash: currentHash,
        ),
      );

      // 9. Return the fully persisted invoice header.
      return (select(
        invoices,
      )..where((i) => i.id.equals(invoiceId))).getSingle();
    });
  }

  // ─── Credit notes ───────────────────────────────────────────────────

  Future<double> getReturnedQuantity(int invoiceItemId) async {
    final expression = creditNoteItems.quantity.sum();
    final row =
        await (selectOnly(creditNoteItems)
              ..where(creditNoteItems.invoiceItemId.equals(invoiceItemId))
              ..addColumns([expression]))
            .getSingle();
    return row.read(expression) ?? 0;
  }

  Future<CreditNote> createCreditNoteTransaction(
    CreateCreditNoteRequest request,
  ) {
    return transaction(() async {
      if (request.reason.trim().isEmpty) {
        throw ArgumentError('A return reason is required');
      }
      if (request.items.isEmpty ||
          request.items.every((e) => e.quantity <= 0)) {
        throw ArgumentError('At least one returned quantity is required');
      }
      final invoice = await (select(
        invoices,
      )..where((i) => i.id.equals(request.invoiceId))).getSingleOrNull();
      if (invoice == null) throw StateError('Invoice not found');
      if (invoice.status == 'CANCELLED') {
        throw StateError('Cancelled invoices cannot be returned');
      }
      final originalItems =
          await (select(invoiceItems)
                ..where((i) => i.invoiceId.equals(invoice.id))
                ..orderBy([(i) => OrderingTerm(expression: i.id)]))
              .get();
      final selected = <({InvoiceItem item, double quantity})>[];
      for (final line in request.items.where((e) => e.quantity > 0)) {
        final item = originalItems
            .where((i) => i.id == line.invoiceItemId)
            .firstOrNull;
        if (item == null) {
          throw ArgumentError('Item does not belong to invoice');
        }
        final returnedExpr = creditNoteItems.quantity.sum();
        final returnedRow =
            await (selectOnly(creditNoteItems)
                  ..join([
                    innerJoin(
                      creditNotes,
                      creditNotes.id.equalsExp(creditNoteItems.creditNoteId),
                    ),
                  ])
                  ..where(creditNoteItems.invoiceItemId.equals(item.id))
                  ..addColumns([returnedExpr]))
                .getSingle();
        final alreadyReturned = returnedRow.read(returnedExpr) ?? 0;
        if (line.quantity > item.quantity - alreadyReturned + 0.000001) {
          throw StateError('Returned quantity exceeds remaining sold quantity');
        }
        selected.add((item: item, quantity: line.quantity));
      }
      final maxExpr = creditNotes.creditNoteNumber.max();
      final row = await (selectOnly(
        creditNotes,
      )..addColumns([maxExpr])).getSingle();
      final number = (row.read(maxExpr) ?? 0) + 1;
      double net = 0, vat = 0, gross = 0;
      for (final line in selected) {
        final ratio = line.quantity / line.item.quantity;
        net += line.item.netAmount * ratio;
        vat += line.item.vatAmount * ratio;
        gross += line.item.grossAmount * ratio;
      }
      final payload = toDeterministicJson({
        'creditNoteNumber': number,
        'invoiceNumber': invoice.invoiceNumber,
        'managerId': request.managerId,
        'reason': request.reason.trim(),
        'netTotal': net,
        'vatTotal': vat,
        'grossTotal': gross,
        'items': selected
            .map((e) => {'invoiceItemId': e.item.id, 'quantity': e.quantity})
            .toList(),
      });
      final previousHash =
          (await (select(auditLogs)
                    ..orderBy([(a) => OrderingTerm.desc(a.id)])
                    ..limit(1))
                  .getSingleOrNull())
              ?.currentHash ??
          '';
      final hash = HashChain.computeHash(previousHash, payload);
      final id = await into(creditNotes).insert(
        CreditNotesCompanion.insert(
          creditNoteNumber: number,
          invoiceId: invoice.id,
          managerId: request.managerId,
          reason: request.reason.trim(),
          netTotal: net,
          vatTotal: vat,
          grossTotal: gross,
          payload: payload,
          previousHash: previousHash,
          currentHash: hash,
        ),
      );
      for (final line in selected) {
        final ratio = line.quantity / line.item.quantity;
        await into(creditNoteItems).insert(
          CreditNoteItemsCompanion.insert(
            creditNoteId: id,
            invoiceItemId: line.item.id,
            quantity: line.quantity,
            netAmount: line.item.netAmount * ratio,
            vatAmount: line.item.vatAmount * ratio,
            grossAmount: line.item.grossAmount * ratio,
          ),
        );
      }
      await into(syncQueue).insert(
        SyncQueueCompanion.insert(
          invoiceId: invoice.id,
          operation: 'CREATE_CREDIT_NOTE',
          payload: payload,
        ),
      );
      await into(auditLogs).insert(
        AuditLogsCompanion.insert(
          action: 'CREDIT_NOTE_CREATED',
          invoiceId: Value(invoice.id),
          userId: request.managerId,
          details: 'Credit note #$number for invoice #${invoice.invoiceNumber}',
          payload: Value(payload),
          previousHash: previousHash,
          currentHash: hash,
        ),
      );
      return (select(creditNotes)..where((c) => c.id.equals(id))).getSingle();
    });
  }

  // ─── Cancellations ──────────────────────────────────────────────────

  Future<CancellationRequest> createCancellationTransaction(
    CreateCancellationRequest request,
  ) {
    return transaction(() async {
      final reason = request.reason.trim();
      const allowed = {
        'Duplicate',
        'Wrong Buyer TIN',
        'Wrong Product',
        'Other',
      };
      if (reason.isEmpty || !allowed.contains(reason)) {
        throw ArgumentError('An approved cancellation reason is required');
      }
      final invoice = await (select(
        invoices,
      )..where((i) => i.id.equals(request.invoiceId))).getSingleOrNull();
      if (invoice == null) throw StateError('Invoice not found');
      if (invoice.status == 'CANCELLED' ||
          invoice.status == 'PENDING_CANCELLATION') {
        throw StateError(
          'Invoice is already cancelled or pending cancellation',
        );
      }
      if (request.now.difference(invoice.createdAt).inHours >= 48) {
        throw StateError('Cancellation period has expired');
      }
      if (await (select(
            cancellationRequests,
          )..where((c) => c.invoiceId.equals(invoice.id))).getSingleOrNull() !=
          null) {
        throw StateError('Cancellation already requested');
      }
      final payload = toDeterministicJson({
        'invoiceNumber': invoice.invoiceNumber,
        'managerId': request.managerId,
        'reason': reason,
        'status': 'PENDING',
      });
      final previousHash =
          (await (select(auditLogs)
                    ..orderBy([(a) => OrderingTerm.desc(a.id)])
                    ..limit(1))
                  .getSingleOrNull())
              ?.currentHash ??
          '';
      final hash = HashChain.computeHash(previousHash, payload);
      final id = await into(cancellationRequests).insert(
        CancellationRequestsCompanion.insert(
          invoiceId: invoice.id,
          managerId: request.managerId,
          reason: reason,
          payload: payload,
          previousHash: previousHash,
          currentHash: hash,
        ),
      );
      await (update(invoices)..where((i) => i.id.equals(invoice.id))).write(
        InvoicesCompanion(
          status: const Value('PENDING_CANCELLATION'),
          updatedAt: Value(request.now),
        ),
      );
      await into(syncQueue).insert(
        SyncQueueCompanion.insert(
          invoiceId: invoice.id,
          operation: 'CANCEL_INVOICE',
          payload: payload,
        ),
      );
      await into(auditLogs).insert(
        AuditLogsCompanion.insert(
          action: 'CANCELLATION_REQUESTED',
          invoiceId: Value(invoice.id),
          userId: request.managerId,
          details:
              'Cancellation requested for invoice #${invoice.invoiceNumber}: $reason',
          payload: Value(payload),
          previousHash: previousHash,
          currentHash: hash,
        ),
      );
      return (select(
        cancellationRequests,
      )..where((c) => c.id.equals(id))).getSingle();
    });
  }

  // ─── Reports ───────────────────────────────────────────────────────

  Future<ReportTotals> generateXReport(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final sales =
        await (select(invoices)..where(
              (i) =>
                  i.createdAt.isBiggerOrEqualValue(start) &
                  i.createdAt.isSmallerThanValue(end) &
                  i.status.isNotIn(['CANCELLED']),
            ))
            .get();
    final credits =
        await (select(creditNotes)..where(
              (c) =>
                  c.createdAt.isBiggerOrEqualValue(start) &
                  c.createdAt.isSmallerThanValue(end),
            ))
            .get();
    double cash = 0, telebirr = 0, cbe = 0;
    for (final sale in sales) {
      final payment =
          await (select(payments)
                ..where((p) => p.invoiceId.equals(sale.id))
                ..limit(1))
              .getSingleOrNull();
      if (payment?.method == 'cash') cash += payment!.amount;
      if (payment?.method == 'telebirr') telebirr += payment!.amount;
      if (payment?.method == 'cbeBirr') cbe += payment!.amount;
    }
    return ReportTotals(
      date: start,
      invoiceCount: sales.length,
      netTotal: sales.fold(0, (v, e) => v + e.netTotal),
      vatTotal: sales.fold(0, (v, e) => v + e.vatTotal),
      grossTotal: sales.fold(0, (v, e) => v + e.grossTotal),
      creditNetTotal: credits.fold(0, (v, e) => v + e.netTotal),
      creditVatTotal: credits.fold(0, (v, e) => v + e.vatTotal),
      creditGrossTotal: credits.fold(0, (v, e) => v + e.grossTotal),
      cashTotal: cash,
      telebirrTotal: telebirr,
      cbeBirrTotal: cbe,
    );
  }

  Future<DailyReport> closeZReportTransaction({
    required DateTime date,
    required String managerId,
    required double cashCount,
  }) {
    return transaction(() async {
      if (cashCount < 0) throw ArgumentError('Cash count cannot be negative');
      final totals = await generateXReport(date);
      final day =
          '${totals.date.year.toString().padLeft(4, '0')}-${totals.date.month.toString().padLeft(2, '0')}-${totals.date.day.toString().padLeft(2, '0')}';
      if (await (select(
            dailyReports,
          )..where((r) => r.reportDate.equals(day))).getSingleOrNull() !=
          null) {
        throw StateError('Z report already closed for this date');
      }
      final dayInvoices =
          await (select(invoices)..where(
                (i) =>
                    i.createdAt.isBiggerOrEqualValue(totals.date) &
                    i.createdAt.isSmallerThanValue(
                      totals.date.add(const Duration(days: 1)),
                    ),
              ))
              .get();
      if (dayInvoices.isEmpty) {
        throw StateError('Cannot close a day with no invoices');
      }
      final maxExpr = dailyReports.zNumber.max();
      final number =
          ((await (selectOnly(
                dailyReports,
              )..addColumns([maxExpr])).getSingle()).read(maxExpr) ??
              0) +
          1;
      final payload = toDeterministicJson({
        'zNumber': number,
        'date': day,
        'invoiceCount': totals.invoiceCount,
        'netTotal': totals.netTotal,
        'vatTotal': totals.vatTotal,
        'grossTotal': totals.grossTotal,
        'creditNetTotal': totals.creditNetTotal,
        'creditVatTotal': totals.creditVatTotal,
        'creditGrossTotal': totals.creditGrossTotal,
        'cashTotal': totals.cashTotal,
        'telebirrTotal': totals.telebirrTotal,
        'cbeBirrTotal': totals.cbeBirrTotal,
        'cashCount': cashCount,
      });
      final previousHash =
          (await (select(auditLogs)
                    ..orderBy([(a) => OrderingTerm.desc(a.id)])
                    ..limit(1))
                  .getSingleOrNull())
              ?.currentHash ??
          '';
      final hash = HashChain.computeHash(previousHash, payload);
      final id = await into(dailyReports).insert(
        DailyReportsCompanion.insert(
          zNumber: number,
          reportDate: day,
          managerId: managerId,
          invoiceCount: totals.invoiceCount,
          netTotal: totals.netTotal,
          vatTotal: totals.vatTotal,
          grossTotal: totals.grossTotal,
          creditNetTotal: totals.creditNetTotal,
          creditVatTotal: totals.creditVatTotal,
          creditGrossTotal: totals.creditGrossTotal,
          cashTotal: totals.cashTotal,
          telebirrTotal: totals.telebirrTotal,
          cbeBirrTotal: totals.cbeBirrTotal,
          cashCount: cashCount,
          payload: payload,
          previousHash: previousHash,
          currentHash: hash,
        ),
      );
      final anchor = dayInvoices.first.id;
      await into(syncQueue).insert(
        SyncQueueCompanion.insert(
          invoiceId: anchor,
          operation: 'CLOSE_Z_REPORT',
          payload: payload,
        ),
      );
      await into(auditLogs).insert(
        AuditLogsCompanion.insert(
          action: 'Z_REPORT_CLOSED',
          invoiceId: Value(anchor),
          userId: managerId,
          details: 'Z report #$number closed for $day',
          payload: Value(payload),
          previousHash: previousHash,
          currentHash: hash,
        ),
      );
      return (select(dailyReports)..where((r) => r.id.equals(id))).getSingle();
    });
  }

  // ─── Helpers ────────────────────────────────────────────────────────

  /// Serialises a map with sorted keys into deterministic JSON.
  static String toDeterministicJson(Map<String, dynamic> map) {
    final sorted = _sortMap(map);
    return const JsonCodec().encode(sorted);
  }

  static Map<String, dynamic> _sortMap(Map<String, dynamic> map) {
    final sorted = <String, dynamic>{};
    for (final key in map.keys.toList()..sort()) {
      final value = map[key];
      if (value is Map<String, dynamic>) {
        sorted[key] = _sortMap(value);
      } else if (value is List) {
        sorted[key] = value.map((e) {
          if (e is Map<String, dynamic>) return _sortMap(e);
          return e;
        }).toList();
      } else {
        sorted[key] = value;
      }
    }
    return sorted;
  }
}
