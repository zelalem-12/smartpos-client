import '../../../../core/database/phase9_requests.dart';
import '../repositories/report_repository.dart';

class GenerateXReport {
  final ReportRepository repository;
  const GenerateXReport(this.repository);
  Future<ReportTotals> call(DateTime date) => repository.generateX(date);
}

class CloseZReport {
  final ReportRepository repository;
  const CloseZReport(this.repository);
  Future<int> call({
    required DateTime date,
    required String managerId,
    required double cashCount,
  }) =>
      repository.closeZ(date: date, managerId: managerId, cashCount: cashCount);
}
