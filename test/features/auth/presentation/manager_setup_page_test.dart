import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/manager_setup_cubit.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/manager_setup_state.dart';
import 'package:smartpos_client/features/auth/presentation/pages/manager_setup_page.dart';

class MockManagerSetupCubit extends MockCubit<ManagerSetupState>
    implements ManagerSetupCubit {}

void main() {
  late MockManagerSetupCubit mockCubit;

  setUp(() {
    mockCubit = MockManagerSetupCubit();
  });

  Widget buildSubject() {
    return MaterialApp(
      home: BlocProvider<ManagerSetupCubit>.value(
        value: mockCubit,
        child: const ManagerSetupPage(),
      ),
    );
  }

  group('ManagerSetupPage', () {
    testWidgets('renders username, full name, and password fields', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(const ManagerSetupInitial());

      await tester.pumpWidget(buildSubject());

      expect(find.text('Manager Setup'), findsOneWidget);
      expect(find.text('Create the first manager account.'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Create Manager'), findsOneWidget);
    });

    testWidgets('submits form when Create Manager is tapped', (tester) async {
      when(() => mockCubit.state).thenReturn(const ManagerSetupInitial());
      when(
        () => mockCubit.submit(
          username: any(named: 'username'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
          confirmPassword: any(named: 'confirmPassword'),
        ),
      ).thenAnswer((_) async {});

      await tester.pumpWidget(buildSubject());

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), 'abebe01');
      await tester.enterText(textFields.at(1), 'Abebe Bikila');
      await tester.enterText(textFields.at(2), '1234');
      await tester.enterText(textFields.at(3), '1234');
      await tester.pump();

      await tester.tap(find.text('Create Manager'));
      await tester.pump();

      verify(
        () => mockCubit.submit(
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          password: '1234',
          confirmPassword: '1234',
        ),
      ).called(1);
    });

    testWidgets('shows loading when state is ManagerSetupLoading', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(const ManagerSetupLoading());

      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message on ManagerSetupError', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(const ManagerSetupError('Passwords do not match'));

      await tester.pumpWidget(buildSubject());

      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}
