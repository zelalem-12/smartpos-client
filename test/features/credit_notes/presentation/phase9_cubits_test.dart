import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/database/phase9_requests.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/cancellation/domain/repositories/cancellation_repository.dart';
import 'package:smartpos_client/features/cancellation/domain/usecases/cancellation_usecases.dart';
import 'package:smartpos_client/features/cancellation/presentation/cubit/cancellation_cubit.dart';
import 'package:smartpos_client/features/credit_notes/domain/entities/return_invoice.dart';
import 'package:smartpos_client/features/credit_notes/domain/repositories/credit_note_repository.dart';
import 'package:smartpos_client/features/credit_notes/domain/usecases/credit_note_usecases.dart';
import 'package:smartpos_client/features/credit_notes/presentation/cubit/credit_note_cubit.dart';
import 'package:smartpos_client/features/reports/domain/repositories/report_repository.dart';
import 'package:smartpos_client/features/reports/domain/usecases/report_usecases.dart';
import 'package:smartpos_client/features/reports/presentation/cubit/reports_cubit.dart';

class MockStore extends Mock implements StoreConfigRepository {}

class MockUsers extends Mock implements UserRepository {}

class MockCreditRepo extends Mock implements CreditNoteRepository {}

class MockCancellationRepo extends Mock implements CancellationRepository {}

class MockReportRepo extends Mock implements ReportRepository {}

void main() {
  late SessionService session;
  late ReturnInvoice invoice;
  setUp(() {
    session = SessionService(MockStore(), MockUsers());
    session.setUser('m', 'Manager', 'MANAGER');
    invoice = ReturnInvoice(
      id: 1,
      number: 7,
      buyerTin: null,
      status: 'PENDING_SYNC',
      createdAt: DateTime(2026),
      netTotal: 100,
      vatTotal: 15,
      grossTotal: 115,
      items: const [],
    );
  });

  test('credit cubit searches and submits successfully', () async {
    final repo = MockCreditRepo();
    when(() => repo.findInvoice(7)).thenAnswer((_) async => invoice);
    when(
      () => repo.create(
        invoiceId: 1,
        managerId: 'm',
        reason: 'Return',
        quantities: const {},
      ),
    ).thenAnswer((_) async => const CreditNoteResult(1, 100, 15, 115));
    final cubit = CreditNoteCubit(
      FindReturnInvoice(repo),
      CreateCreditNote(repo),
      session,
    );
    await cubit.search('7');
    expect(cubit.state.invoice, invoice);
    await cubit.submit('Return');
    expect(cubit.state.result?.number, 1);
    await cubit.close();
  });

  test('cancellation cubit exposes success', () async {
    final repo = MockCancellationRepo();
    when(() => repo.findInvoice(7)).thenAnswer((_) async => invoice);
    when(
      () => repo.request(
        invoiceId: 1,
        managerId: 'm',
        reason: 'Duplicate',
        now: any(named: 'now'),
      ),
    ).thenAnswer((_) async {});
    final cubit = CancellationCubit(
      FindCancellationInvoice(repo),
      RequestCancellation(repo),
      session,
    );
    await cubit.search('7');
    await cubit.submit('Duplicate');
    expect(cubit.state.success, isTrue);
    await cubit.close();
  });

  test('reports cubit loads X and validates cash count before Z', () async {
    final repo = MockReportRepo();
    final totals = ReportTotals(
      date: DateTime(2026),
      invoiceCount: 1,
      netTotal: 100,
      vatTotal: 15,
      grossTotal: 115,
      creditNetTotal: 0,
      creditVatTotal: 0,
      creditGrossTotal: 0,
      cashTotal: 115,
      telebirrTotal: 0,
      cbeBirrTotal: 0,
    );
    when(() => repo.generateX(any())).thenAnswer((_) async => totals);
    when(
      () => repo.closeZ(
        date: any(named: 'date'),
        managerId: 'm',
        cashCount: 115,
      ),
    ).thenAnswer((_) async => 1);
    final cubit = ReportsCubit(
      GenerateXReport(repo),
      CloseZReport(repo),
      session,
    );
    await cubit.load(DateTime(2026));
    expect(cubit.state.totals, totals);
    await cubit.closeDay('-1');
    expect(cubit.state.error, contains('valid'));
    await cubit.closeDay('115');
    expect(cubit.state.zNumber, 1);
    await cubit.close();
  });
}
