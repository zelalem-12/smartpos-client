import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/auth/domain/entities/user_entity.dart';
import 'package:smartpos_client/features/auth/domain/repositories/auth_repository.dart';
import 'package:smartpos_client/features/auth/domain/usecases/create_manager.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late CreateManager useCase;
  late MockAuthRepository mockRepo;

  final manager = UserEntity(
    id: 'abc-123',
    username: 'abebe01',
    fullName: 'Abebe Bikila',
    role: 'MANAGER',
    passwordHash: 'hashed-password',
    isActive: true,
    createdAt: DateTime(2026, 9, 8),
  );

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = CreateManager(mockRepo);
  });

  group('CreateManager', () {
    test('returns UserEntity on valid input', () async {
      when(
        () => mockRepo.createManager(
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          password: '1234',
        ),
      ).thenAnswer((_) async => manager);

      final result = await useCase(
        username: 'abebe01',
        fullName: 'Abebe Bikila',
        password: '1234',
      );

      expect(result, manager);
      verify(
        () => mockRepo.createManager(
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          password: '1234',
        ),
      ).called(1);
    });

    test('trims input', () async {
      when(
        () => mockRepo.createManager(
          username: any(named: 'username'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => manager);

      await useCase(
        username: '  abebe01  ',
        fullName: '  Abebe Bikila  ',
        password: '1234',
      );

      verify(
        () => mockRepo.createManager(
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          password: '1234',
        ),
      ).called(1);
    });

    test('throws ValidationFailure on short username', () async {
      expect(
        () =>
            useCase(username: 'ab', fullName: 'Abebe Bikila', password: '1234'),
        throwsA(
          isA<ValidationFailure>().having(
            (f) => f.message,
            'message',
            contains('at least 3 characters'),
          ),
        ),
      );
    });

    test('throws ValidationFailure on invalid username characters', () async {
      expect(
        () => useCase(
          username: 'abebe-01',
          fullName: 'Abebe Bikila',
          password: '1234',
        ),
        throwsA(
          isA<ValidationFailure>().having(
            (f) => f.message,
            'message',
            contains('letters, numbers, and underscores'),
          ),
        ),
      );
    });

    test('throws ValidationFailure on empty full name', () async {
      expect(
        () => useCase(username: 'abebe01', fullName: '', password: '1234'),
        throwsA(
          isA<ValidationFailure>().having(
            (f) => f.message,
            'message',
            'Full name is required',
          ),
        ),
      );
    });

    test('throws ValidationFailure on short password', () async {
      expect(
        () => useCase(
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          password: '123',
        ),
        throwsA(
          isA<ValidationFailure>().having(
            (f) => f.message,
            'message',
            contains('at least 4 characters'),
          ),
        ),
      );
    });

    test('propagates ConflictFailure from repository', () async {
      when(
        () => mockRepo.createManager(
          username: any(named: 'username'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const ConflictFailure('A manager already exists'));

      expect(
        () => useCase(
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          password: '1234',
        ),
        throwsA(isA<ConflictFailure>()),
      );
    });
  });
}
