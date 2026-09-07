import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/activation/domain/entities/store_config_entity.dart';
import 'package:smartpos_client/features/activation/domain/repositories/activation_repository.dart';
import 'package:smartpos_client/features/activation/domain/usecases/activate_device.dart';

class MockActivationRepository extends Mock implements ActivationRepository {}

void main() {
  late ActivateDevice useCase;
  late MockActivationRepository mockRepo;

  const validConfig = StoreConfigEntity(
    licenseKey: 'ACT-89412',
    businessName: 'Bole Roasters Cafe PLC',
    tradeName: 'Bole Cafe',
    tin: '0012345678',
    vatRegNo: '123456789',
    sector: '18. Restaurants & Food Service',
    address: 'Addis Ababa, Bole',
    deviceSerial: 'SUNMI-V2P-ET-89412',
  );

  setUp(() {
    mockRepo = MockActivationRepository();
    useCase = ActivateDevice(mockRepo);
  });

  group('ActivateDevice', () {
    test('returns StoreConfigEntity on valid key', () async {
      when(() => mockRepo.activateDevice('ACT-89412'))
          .thenAnswer((_) async => validConfig);

      final result = await useCase('ACT-89412');

      expect(result, validConfig);
      verify(() => mockRepo.activateDevice('ACT-89412')).called(1);
    });

    test('trims and uppercases the key', () async {
      when(() => mockRepo.activateDevice('ACT-89412'))
          .thenAnswer((_) async => validConfig);

      final result = await useCase('  act-89412  ');

      expect(result, validConfig);
      verify(() => mockRepo.activateDevice('ACT-89412')).called(1);
    });

    test('throws ValidationFailure on empty key', () async {
      expect(
        () => useCase(''),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          'License key is required',
        )),
      );

      verifyNever(() => mockRepo.activateDevice(any()));
    });

    test('throws ValidationFailure on whitespace-only key', () async {
      expect(
        () => useCase('   '),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('throws ValidationFailure when key does not start with ACT-', () async {
      expect(
        () => useCase('XYZ-12345'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('ACT-'),
        )),
      );
    });

    test('throws ValidationFailure when key is too short', () async {
      expect(
        () => useCase('ACT-123'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('9 characters'),
        )),
      );
    });

    test('throws ValidationFailure when key is too long', () async {
      expect(
        () => useCase('ACT-1234567'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('9 characters'),
        )),
      );
    });

    test('propagates ServerFailure from repository', () async {
      when(() => mockRepo.activateDevice('ACT-99999'))
          .thenThrow(const ServerFailure('Server unavailable'));

      expect(
        () => useCase('ACT-99999'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
