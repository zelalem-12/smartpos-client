import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/auth/domain/entities/user_entity.dart';
import 'package:smartpos_client/features/auth/domain/usecases/login_with_credentials.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/login_cubit.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/login_state.dart';

class MockLoginWithCredentials extends Mock implements LoginWithCredentials {}

class MockSessionService extends Mock implements SessionService {}

void main() {
  late MockLoginWithCredentials mockLogin;
  late MockSessionService mockSession;

  final user = UserEntity(
    id: 'abc-123',
    username: 'abebe01',
    fullName: 'Abebe Bikila',
    role: 'MANAGER',
    passwordHash: 'hashed',
    isActive: true,
    createdAt: DateTime(2026, 9, 8),
  );

  setUp(() {
    mockLogin = MockLoginWithCredentials();
    mockSession = MockSessionService();
  });

  group('LoginCubit', () {
    test('initial state is LoginInitial', () {
      final cubit = LoginCubit(mockLogin, mockSession);
      expect(cubit.state, isA<LoginInitial>());
      cubit.close();
    });

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Success] and sets session on valid credentials',
      build: () {
        when(() => mockLogin(username: 'abebe01', password: '1234'))
            .thenAnswer((_) async => user);
        return LoginCubit(mockLogin, mockSession);
      },
      act: (cubit) => cubit.submit(username: 'abebe01', password: '1234'),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginSuccess>().having(
          (s) => s.user.fullName,
          'fullName',
          'Abebe Bikila',
        ),
      ],
      verify: (_) {
        verify(() => mockSession.setUser(user.id, user.fullName, user.role))
            .called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Error] on invalid credentials',
      build: () {
        when(() => mockLogin(username: 'abebe01', password: 'wrong'))
            .thenThrow(const AuthFailure('Invalid username or password'));
        return LoginCubit(mockLogin, mockSession);
      },
      act: (cubit) => cubit.submit(username: 'abebe01', password: 'wrong'),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>().having(
          (s) => s.message,
          'message',
          'Invalid username or password',
        ),
      ],
    );
  });
}
