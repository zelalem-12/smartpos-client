import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/auth/domain/entities/user_entity.dart';
import 'package:smartpos_client/features/auth/domain/repositories/auth_repository.dart';
import 'package:smartpos_client/features/auth/domain/usecases/create_cashier.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late CreateCashier useCase;
  late MockAuthRepository mockRepo;

  final cashier = UserEntity(
    id: 'csh-001',
    username: 'selam_t',
    fullName: 'Selam Teshale',
    role: 'CASHIER',
    passwordHash: 'hashed-password',
    isActive: true,
    createdAt: DateTime(2026, 9, 8),
  );

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = CreateCashier(mockRepo);
  });

  group('CreateCashier', () {
    test('returns UserEntity on valid input', () async {
      when(
        () => mockRepo.createCashier(
          username: 'selam_t',
          fullName: 'Selam Teshale',
          password: '1234',
        ),
      ).thenAnswer((_) async => cashier);

      final result = await useCase(
        username: 'selam_t',
        fullName: 'Selam Teshale',
        password: '1234',
      );

      expect(result, cashier);
      verify(
        () => mockRepo.createCashier(
          username: 'selam_t',
          fullName: 'Selam Teshale',
          password: '1234',
        ),
      ).called(1);
    });

    test('throws ValidationFailure on short username', () async {
      expect(
        () => useCase(
          username: 'st',
          fullName: 'Selam Teshale',
          password: '1234',
        ),
        throwsA(
          isA<ValidationFailure>().having(
            (f) => f.message,
            'message',
            contains('at least 3 characters'),
          ),
        ),
      );
    });

    test('propagates ConflictFailure for duplicate username', () async {
      when(
        () => mockRepo.createCashier(
          username: any(named: 'username'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const ConflictFailure('Username is already taken'));

      expect(
        () => useCase(
          username: 'selam_t',
          fullName: 'Selam Teshale',
          password: '1234',
        ),
        throwsA(isA<ConflictFailure>()),
      );
    });
  });
}
