import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/auth/domain/entities/user_entity.dart';
import 'package:smartpos_client/features/auth/domain/repositories/auth_repository.dart';
import 'package:smartpos_client/features/auth/domain/usecases/login_with_credentials.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginWithCredentials useCase;
  late MockAuthRepository mockRepo;

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
    mockRepo = MockAuthRepository();
    useCase = LoginWithCredentials(mockRepo);
  });

  group('LoginWithCredentials', () {
    test('returns UserEntity on valid credentials', () async {
      when(
        () => mockRepo.loginWithCredentials(
          username: 'abebe01',
          password: '1234',
        ),
      ).thenAnswer((_) async => user);

      final result = await useCase(username: 'abebe01', password: '1234');

      expect(result, user);
      verify(
        () => mockRepo.loginWithCredentials(
          username: 'abebe01',
          password: '1234',
        ),
      ).called(1);
    });

    test('throws ValidationFailure on empty username', () async {
      expect(
        () => useCase(username: '', password: '1234'),
        throwsA(
          isA<ValidationFailure>().having(
            (f) => f.message,
            'message',
            'Username is required',
          ),
        ),
      );
      verifyNever(
        () => mockRepo.loginWithCredentials(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      );
    });

    test('throws ValidationFailure on empty password', () async {
      expect(
        () => useCase(username: 'abebe01', password: ''),
        throwsA(
          isA<ValidationFailure>().having(
            (f) => f.message,
            'message',
            'Password is required',
          ),
        ),
      );
    });

    test('propagates AuthFailure from repository', () async {
      when(
        () => mockRepo.loginWithCredentials(
          username: 'abebe01',
          password: 'wrong',
        ),
      ).thenThrow(const AuthFailure('Invalid username or password'));

      expect(
        () => useCase(username: 'abebe01', password: 'wrong'),
        throwsA(isA<AuthFailure>()),
      );
    });
  });
}
