import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/activation/domain/entities/store_config_entity.dart';
import 'package:smartpos_client/features/activation/presentation/cubit/activation_cubit.dart';
import 'package:smartpos_client/features/activation/presentation/cubit/activation_state.dart';
import 'package:smartpos_client/features/activation/presentation/pages/activation_page.dart';
import 'package:smartpos_client/features/activation/presentation/widgets/activation_progress.dart';

class MockActivationCubit extends MockCubit<ActivationState>
    implements ActivationCubit {}

void main() {
  late MockActivationCubit mockCubit;

  setUp(() {
    mockCubit = MockActivationCubit();
  });

  Widget buildSubject() {
    return MaterialApp(
      home: BlocProvider<ActivationCubit>.value(
        value: mockCubit,
        child: const ActivationPage(),
      ),
    );
  }

  group('ActivationPage', () {
    testWidgets('renders SmartPOS logo, text field, and Activate button',
        (tester) async {
      when(() => mockCubit.state).thenReturn(const ActivationInitial());

      await tester.pumpWidget(buildSubject());

      // Branding
      expect(find.text('SmartPOS Ethiopia'), findsOneWidget);
      expect(find.text('E-Invoicing System (Model 1)'), findsOneWidget);

      // Input
      expect(find.text('License Key'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Button
      expect(find.text('Activate'), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when loading',
        (tester) async {
      when(() => mockCubit.state).thenReturn(const ActivationLoading());

      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message on error state', (tester) async {
      when(() => mockCubit.state).thenReturn(
        const ActivationError('Invalid license key format'),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.text('Invalid license key format'), findsOneWidget);
    });

    testWidgets('shows success card on success state', (tester) async {
      const config = StoreConfigEntity(
        licenseKey: 'ACT-89412',
        businessName: 'Bole Roasters Cafe PLC',
        tradeName: 'Bole Cafe',
        tin: '0012345678',
        vatRegNo: '123456789',
        sector: '18. Restaurants & Food Service',
        address: 'Addis Ababa, Bole',
        deviceSerial: 'SUNMI-V2P-ET-89412',
      );

      when(() => mockCubit.state).thenReturn(
        const ActivationSuccess(config),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.byType(ActivationProgress), findsOneWidget);
      expect(find.text('Device Activated'), findsOneWidget);
      expect(find.text('Bole Roasters Cafe PLC'), findsOneWidget);
      expect(find.text('0012345678'), findsOneWidget);
    });

    testWidgets('calls activate on cubit when button tapped', (tester) async {
      when(() => mockCubit.state).thenReturn(const ActivationInitial());
      when(() => mockCubit.activate(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildSubject());

      // Type a license key
      await tester.enterText(find.byType(TextField), 'ACT-89412');
      await tester.pump();

      // Tap the Activate button
      await tester.tap(find.text('Activate'));
      await tester.pump();

      verify(() => mockCubit.activate('ACT-89412')).called(1);
    });
  });
}
