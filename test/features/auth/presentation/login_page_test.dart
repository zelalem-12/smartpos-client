import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/constants/app_constants.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/login_cubit.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/login_state.dart';
import 'package:smartpos_client/features/auth/presentation/pages/login_page.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  late MockLoginCubit mockCubit;

  setUp(() {
    mockCubit = MockLoginCubit();
  });

  Widget buildSubject() {
    return MaterialApp(
      home: BlocProvider<LoginCubit>.value(
        value: mockCubit,
        child: const LoginPage(),
      ),
    );
  }

  group('LoginPage', () {
    testWidgets('renders branding and username/password fields', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(const LoginInitial());

      await tester.pumpWidget(buildSubject());

      expect(find.text(AppConstants.appName), findsOneWidget);
      expect(find.text(AppConstants.appTagline), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);
    });

    testWidgets('submits credentials when Log In is tapped', (tester) async {
      when(() => mockCubit.state).thenReturn(const LoginInitial());
      when(
        () => mockCubit.submit(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});

      await tester.pumpWidget(buildSubject());

      await tester.enterText(find.byType(TextField).first, 'abebe01');
      await tester.enterText(find.byType(TextField).last, '1234');
      await tester.pump();

      await tester.tap(find.text('Log In'));
      await tester.pump();

      verify(() => mockCubit.submit(username: 'abebe01', password: '1234'))
          .called(1);
    });

    testWidgets('shows error message on LoginError', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(const LoginError('Invalid username or password'));

      await tester.pumpWidget(buildSubject());

      expect(find.text('Invalid username or password'), findsOneWidget);
    });

    testWidgets('username and password fields keep focus across characters', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(const LoginInitial());

      await tester.pumpWidget(buildSubject());

      final usernameField = find.byKey(const ValueKey('usernameField'));
      await tester.tap(usernameField);
      await tester.pump();

      for (final value in ['m', 'ma', 'man', 'mana', 'manager']) {
        await tester.enterText(usernameField, value);
        await tester.pump();
        expect(tester.testTextInput.isVisible, isTrue);
        expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);
      }

      expect(find.text('manager'), findsOneWidget);
    });
  });
}
