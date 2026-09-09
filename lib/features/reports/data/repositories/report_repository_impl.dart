import '../../../../core/database/app_database.dart';
import '../../../../core/database/phase9_requests.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final AppDatabase db;
  const ReportRepositoryImpl(this.db);
  @override
  Future<ReportTotals> generateX(DateTime date) => db.generateXReport(date);
  @override
  Future<int> closeZ({
    required DateTime date,
    required String managerId,
    required double cashCount,
  }) async {
    try {
      return (await db.closeZReportTransaction(
        date: date,
        managerId: managerId,
        cashCount: cashCount,
      )).zNumber;
    } on ArgumentError catch (e) {
      throw ValidationFailure(e.message?.toString() ?? 'Invalid cash count');
    } on StateError catch (e) {
      throw AlreadyCompletedFailure(e.message);
    }
  }
}
