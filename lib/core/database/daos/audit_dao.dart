import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/audit_log_table.dart';

part 'audit_dao.g.dart';

/// Data access for the audit log table.
@DriftAccessor(tables: [AuditLogs])
class AuditDao extends DatabaseAccessor<AppDatabase> with _$AuditDaoMixin {
  AuditDao(super.db);

  Future<List<AuditLog>> getAllAuditLogs({bool newestFirst = true}) {
    final query = select(auditLogs);
    query.orderBy([
      (a) => newestFirst ? OrderingTerm.desc(a.id) : OrderingTerm.asc(a.id),
    ]);
    return query.get();
  }

  Future<List<AuditLog>> getAuditLogsByInvoiceId(int invoiceId) {
    return (select(auditLogs)
          ..where((a) => a.invoiceId.equals(invoiceId))
          ..orderBy([(a) => OrderingTerm.desc(a.id)]))
        .get();
  }
}
