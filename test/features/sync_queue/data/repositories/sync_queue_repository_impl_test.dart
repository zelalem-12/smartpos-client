import 'package:dio/dio.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/database/create_invoice_request.dart';
import 'package:smartpos_client/core/network/api_endpoints.dart';
import 'package:smartpos_client/core/network/network_info.dart';
import 'package:smartpos_client/features/sync_queue/data/repositories/sync_queue_repository_impl.dart';

class MockDio extends Mock implements Dio {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AppDatabase db;
  late MockDio dio;
  late MockNetworkInfo networkInfo;
  late SyncQueueRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.forTesting();
    dio = MockDio();
    networkInfo = MockNetworkInfo();
    repository = SyncQueueRepositoryImpl(db, dio, networkInfo);

    await db.insertUser(
      UsersCompanion.insert(
        id: 'csh-001',
        username: 'cashier',
        fullName: 'Cashier',
        role: 'CASHIER',
        passwordHash: 'hash',
      ),
    );

    when(() => networkInfo.isOnline).thenAnswer((_) async => true);
  });

  tearDown(() => db.close());

  Future<Invoice> createInvoice() => db.createInvoiceTransaction(
    CreateInvoiceDbRequest(
      cashierId: 'csh-001',
      netTotal: 100,
      vatTotal: 15,
      grossTotal: 115,
      status: 'PENDING_SYNC',
      items: [
        CreateInvoiceItemDbRequest(
          productId: 'p1',
          productName: 'Coffee',
          unitPrice: 115,
          quantity: 1,
          vatRate: .15,
          netAmount: 100,
          vatAmount: 15,
          grossAmount: 115,
        ),
      ],
      paymentMethod: 'cash',
      paymentAmount: 115,
      payloadBuilder: (n) => AppDatabase.toDeterministicJson({'n': n}),
      syncOperation: 'CREATE_INVOICE',
      auditAction: 'INVOICE_CREATED',
      auditUserId: 'csh-001',
    ),
  );

  group('SyncQueueRepositoryImpl', () {
    test('retry does not start while the device is offline', () async {
      final invoice = await createInvoice();
      final row = (await db.getSyncQueueEntryByInvoiceId(invoice.id))!;
      when(() => networkInfo.isOnline).thenAnswer((_) async => false);

      await expectLater(repository.retry(row.id), throwsA(isA<StateError>()));

      final unchanged = await db.getSyncQueueById(row.id);
      expect(unchanged!.status, 'PENDING');
      verifyNever(() => dio.post(any(), data: any(named: 'data')));
    });

    test('lists entries newest first', () async {
      await createInvoice();
      await createInvoice();
      final entries = await repository.getQueue();
      expect(entries.length, 2);
      expect(entries[0].id, greaterThan(entries[1].id));
    });

    test('actionable entries include PENDING and FAILED', () async {
      final firstInvoice = await createInvoice();
      final firstRow = (await db.getSyncQueueEntryByInvoiceId(
        firstInvoice.id,
      ))!;
      await db.updateSyncQueueById(
        firstRow.id,
        const SyncQueueCompanion(status: Value('FAILED')),
      );

      await createInvoice();

      final all = await repository.getQueue();
      final actionable = await repository.getActionableEntries();
      expect(actionable.length, 2);
      expect(
        actionable.map((e) => e.status).toSet(),
        containsAll(['PENDING', 'FAILED']),
      );
      expect(actionable.first.id, all.last.id);
    });

    test('retry marks synced on success', () async {
      final invoice = await createInvoice();
      final row = (await db.getSyncQueueEntryByInvoiceId(invoice.id))!;

      when(() => dio.post(ApiEndpoints.sync, data: any(named: 'data')))
          .thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ApiEndpoints.sync),
              statusCode: 200,
              data: {'status': 'synced'},
            ),
          );

      await repository.retry(row.id);

      final updated = await db.getSyncQueueById(row.id);
      expect(updated!.status, 'SYNCED');
      expect(updated.syncedAt, isNotNull);
      expect(updated.retryCount, 0);
      expect(updated.lastError, isNull);
    });

    test(
      'retry marks failed with incremented retry count on Dio exception',
      () async {
        final invoice = await createInvoice();
        final row = (await db.getSyncQueueEntryByInvoiceId(invoice.id))!;

        when(() => dio.post(ApiEndpoints.sync, data: any(named: 'data')))
            .thenThrow(
              DioException(
                requestOptions: RequestOptions(path: ApiEndpoints.sync),
                error: 'timeout',
              ),
            );

        await expectLater(
          repository.retry(row.id),
          throwsA(isA<DioException>()),
        );

        final updated = await db.getSyncQueueById(row.id);
        expect(updated!.status, 'FAILED');
        expect(updated.retryCount, 1);
        expect(updated.lastError, isNotNull);
      },
    );

    test('sync all processes actionable entries and leaves synced', () async {
      await createInvoice();
      await createInvoice();

      when(() => dio.post(ApiEndpoints.sync, data: any(named: 'data')))
          .thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ApiEndpoints.sync),
              statusCode: 200,
              data: {'status': 'synced'},
            ),
          );

      final summary = await repository.syncAll();
      expect(summary.processed, 2);
      expect(summary.failed, 0);
      final synced = await db.getAllSyncQueue();
      expect(synced.every((r) => r.status == 'SYNCED'), isTrue);
    });

    test(
      'sync all stops on first failure and marks that entry failed',
      () async {
        await createInvoice();
        await createInvoice();

        when(() => dio.post(ApiEndpoints.sync, data: any(named: 'data')))
            .thenThrow(
              DioException(
                requestOptions: RequestOptions(path: ApiEndpoints.sync),
                error: 'timeout',
              ),
            );

        final summary = await repository.syncAll();
        expect(summary.processed, 0);
        expect(summary.failed, greaterThan(0));

        final rows = await db.getAllSyncQueue();
        final failed = rows.where((r) => r.status == 'FAILED');
        expect(failed.length, greaterThanOrEqualTo(1));
        expect(failed.first.retryCount, 1);
      },
    );

    test('sync all returns offline message when network is offline', () async {
      when(() => networkInfo.isOnline).thenAnswer((_) async => false);
      await createInvoice();

      final summary = await repository.syncAll();
      expect(summary.processed, 0);
      expect(summary.failed, 0);
      expect(summary.error, contains('offline'));

      final row = await db.getAllSyncQueue();
      expect(row.first.status, 'PENDING');
    });

    test('oldest unsynced age is based on createdAt', () async {
      final invoice = await createInvoice();
      final row = (await db.getSyncQueueEntryByInvoiceId(invoice.id))!;
      await db.updateSyncQueueById(
        row.id,
        SyncQueueCompanion(
          createdAt: Value(DateTime.now().subtract(const Duration(days: 8))),
        ),
      );
      final age = await repository.oldestUnsyncedAge();
      expect(age, isNotNull);
      expect(age!.inDays, greaterThanOrEqualTo(8));
    });

    test('processing is set before network call', () async {
      final invoice = await createInvoice();
      final row = (await db.getSyncQueueEntryByInvoiceId(invoice.id))!;

      Response<dynamic>? captured;
      when(() => dio.post(ApiEndpoints.sync, data: any(named: 'data')))
          .thenAnswer((invocation) async {
            final processing = await db.getSyncQueueById(row.id);
            expect(processing!.status, 'PROCESSING');
            captured = Response(
              requestOptions: RequestOptions(path: ApiEndpoints.sync),
              statusCode: 200,
              data: {'status': 'synced'},
            );
            return captured!;
          });

      await repository.retry(row.id);
      expect(captured, isNotNull);
    });
  });
}
