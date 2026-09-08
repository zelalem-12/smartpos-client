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
    name: 'Abebe Bikila',
    role: 'MANAGER',
    pinHash: 'hashed-pin',
    isActive: true,
    createdAt: DateTime(2026, 9, 8),
  );

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = CreateManager(mockRepo);
  });

  group('CreateManager', () {
    test('returns UserEntity on valid input', () async {
      when(() => mockRepo.createManager(name: 'Abebe Bikila', pin: '1234'))
          .thenAnswer((_) async => manager);

      final result = await useCase(name: 'Abebe Bikila', pin: '1234');

      expect(result, manager);
      verify(() => mockRepo.createManager(name: 'Abebe Bikila', pin: '1234'))
          .called(1);
    });

    test('trims name', () async {
      when(() => mockRepo.createManager(name: 'Abebe Bikila', pin: '1234'))
          .thenAnswer((_) async => manager);

      await useCase(name: '  Abebe Bikila  ', pin: '1234');

      verify(() => mockRepo.createManager(name: 'Abebe Bikila', pin: '1234'))
          .called(1);
    });

    test('throws ValidationFailure on empty name', () async {
      expect(
        () => useCase(name: '', pin: '1234'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          'Manager name is required',
        )),
      );
    });

    test('throws ValidationFailure on short name', () async {
      expect(
        () => useCase(name: 'A', pin: '1234'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('at least 2 characters'),
        )),
      );
    });

    test('throws ValidationFailure on short PIN', () async {
      expect(
        () => useCase(name: 'Abebe', pin: '123'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('4 digits'),
        )),
      );
    });

    test('throws ValidationFailure on long PIN', () async {
      expect(
        () => useCase(name: 'Abebe', pin: '12345'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('4 digits'),
        )),
      );
    });

    test('throws ValidationFailure on non-numeric PIN', () async {
      expect(
        () => useCase(name: 'Abebe', pin: '12a4'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          'PIN must contain only digits',
        )),
      );
    });

    test('propagates ConflictFailure from repository', () async {
      when(() => mockRepo.createManager(name: any(named: 'name'), pin: any(named: 'pin')))
          .thenThrow(const ConflictFailure('A manager already exists'));

      expect(
        () => useCase(name: 'Abebe', pin: '1234'),
        throwsA(isA<ConflictFailure>()),
      );
    });
  });
}
