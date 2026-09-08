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
    testWidgets('renders name input and Create 4-Digit PIN section',
        (tester) async {
      when(() => mockCubit.state).thenReturn(const ManagerSetupInitial());

      await tester.pumpWidget(buildSubject());

      expect(find.text('Manager Setup'), findsOneWidget);
      expect(find.text('Create the first manager account.'), findsOneWidget);
      expect(find.text('Manager Name'), findsOneWidget);
      expect(find.text('Create 4-Digit PIN'), findsOneWidget);
      expect(find.text('Create Manager'), findsOneWidget);
    });

    testWidgets('shows loading when state is ManagerSetupLoading',
        (tester) async {
      when(() => mockCubit.state).thenReturn(const ManagerSetupLoading());

      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message on ManagerSetupError', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(const ManagerSetupError('PINs do not match'));

      await tester.pumpWidget(buildSubject());

      expect(find.text('PINs do not match'), findsOneWidget);
    });
  });
}
