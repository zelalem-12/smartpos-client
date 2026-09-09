// ignore_for_file: unnecessary_underscores
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/receipt/domain/entities/receipt_data.dart';
import 'package:smartpos_client/features/receipt/presentation/cubit/receipt_cubit.dart';
import 'package:smartpos_client/features/receipt/presentation/cubit/receipt_state.dart';
import 'package:smartpos_client/features/receipt/presentation/pages/receipt_page.dart';

class MockStoreConfigRepository extends Mock implements StoreConfigRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockReceiptCubit extends MockCubit<ReceiptState> implements ReceiptCubit {
  MockReceiptCubit() {
    when(() => state).thenReturn(const ReceiptLoading());
    when(() => stream).thenAnswer((_) => const Stream<ReceiptState>.empty());
    when(() => close()).thenAnswer((_) async {});
    when(() => load(any())).thenAnswer((_) async {});
    when(() => printReceipt()).thenAnswer((_) async {});
    when(() => reprint()).thenAnswer((_) async {});
    when(() => newSale()).thenAnswer((_) async {});
  }
}

void main() {
  late MockReceiptCubit cubit;

  setUp(() {
    if (sl.isRegistered<StoreConfigRepository>()) {
      sl.unregister<StoreConfigRepository>();
    }
    if (sl.isRegistered<UserRepository>()) {
      sl.unregister<UserRepository>();
    }
    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }

    final storeRepo = MockStoreConfigRepository();
    final userRepo = MockUserRepository();
    when(storeRepo.isDeviceActivated).thenAnswer((_) async => true);
    when(userRepo.hasManager).thenAnswer((_) async => true);
    sl.registerLazySingleton<StoreConfigRepository>(() => storeRepo);
    sl.registerLazySingleton<UserRepository>(() => userRepo);
    sl.registerLazySingleton<SessionService>(
      () => SessionService(storeRepo, userRepo),
    );
  });

  tearDown(() {
    sl.unregister<StoreConfigRepository>();
    sl.unregister<UserRepository>();
    sl.unregister<SessionService>();
  });

  final now = DateTime(2024, 1, 1, 12, 0);
  final receipt = ReceiptData(
    businessName: 'Business',
    tradeName: 'Trade',
    address: 'Addis Ababa',
    tin: '1234567890',
    vatRegNo: 'VAT-001',
    invoiceNumber: 5,
    invoiceDate: now,
    cashierName: 'Abebe',
    buyerTin: '0987654321',
    items: const [
      ReceiptItem(
        name: 'Coffee',
        quantity: 1,
        unitPrice: 23.0,
        vatRate: 0.15,
        netAmount: 20.0,
        vatAmount: 3.0,
        grossAmount: 23.0,
      ),
    ],
    netTotal: 20.0,
    vatTotal: 3.0,
    grossTotal: 23.0,
    paymentMethod: 'Cash',
    hash: 'hash',
    qrPayload: 'qr-payload',
  );

  Widget buildSubject({ReceiptState? initial}) {
    cubit = MockReceiptCubit();
    if (initial != null) {
      when(() => cubit.state).thenReturn(initial);
      when(() => cubit.stream).thenAnswer((_) => Stream.value(initial));
    }

    final router = GoRouter(
      initialLocation: AppRoutes.receipt,
      routes: [
        GoRoute(
          path: AppRoutes.pos,
          builder: (_, __) => const Scaffold(body: Text('POS')),
        ),
        GoRoute(
          path: AppRoutes.receipt,
          builder: (_, __) => BlocProvider<ReceiptCubit>(
            create: (_) => cubit,
            child: const ReceiptPage(),
          ),
        ),
      ],
    );

    return MediaQuery(
      data: const MediaQueryData(size: Size(1080, 1920)),
      child: MaterialApp.router(routerConfig: router),
    );
  }

  Future<void> pumpSubject(
    WidgetTester tester, {
    ReceiptState? initial,
    bool settle = true,
  }) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    addTearDown(() async => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(buildSubject(initial: initial));
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
  }

  testWidgets('shows loading indicator while loading', (tester) async {
    await pumpSubject(tester, initial: const ReceiptLoading(), settle: false);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows actionable error for missing or invalid invoice id', (
    tester,
  ) async {
    await pumpSubject(
      tester,
      initial: const ReceiptError(
        'Invalid or missing invoice ID. Please return to the POS and try again.',
        invoiceId: null,
      ),
    );

    expect(
      find.text(
        'Invalid or missing invoice ID. Please return to the POS and try again.',
      ),
      findsOneWidget,
    );
    expect(find.text('Back to POS'), findsOneWidget);

    await tester.tap(find.text('Back to POS'));
    await tester.pumpAndSettle();

    expect(find.text('POS'), findsOneWidget);
  });

  testWidgets('renders receipt, QR code, print and new sale actions', (
    tester,
  ) async {
    await pumpSubject(tester, initial: ReceiptReady(receipt));

    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.text('Print'), findsOneWidget);
    expect(find.text('New Sale'), findsOneWidget);
    expect(find.textContaining('Buyer TIN: 0987654321'), findsOneWidget);
  });

  testWidgets(
    'reprint button appears after a print and adds duplicate watermark',
    (tester) async {
      await pumpSubject(
        tester,
        initial: ReceiptPrinted(receipt, isDuplicate: true),
      );

      expect(find.text('Reprint (Duplicate)'), findsOneWidget);
      expect(find.text('*** DUPLICATE COPY / ድጋሚ የታተመ ***'), findsOneWidget);
    },
  );

  testWidgets('tapping New Sale clears cart and navigates to POS', (
    tester,
  ) async {
    await pumpSubject(tester, initial: ReceiptReady(receipt));

    await tester.tap(find.text('New Sale'));
    await tester.pumpAndSettle();

    expect(find.text('POS'), findsOneWidget);
    verify(() => cubit.newSale()).called(1);
  });
}
