import '../../../../core/database/phase9_requests.dart';

abstract interface class ReportRepository {
  Future<ReportTotals> generateX(DateTime date);
  Future<int> closeZ({
    required DateTime date,
    required String managerId,
    required double cashCount,
  });
}
