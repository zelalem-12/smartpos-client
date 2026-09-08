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
    licenseKey: 'MOR-4A9K2L8Q',
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
      when(() => mockRepo.activateDevice('MOR-4A9K2L8Q'))
          .thenAnswer((_) async => validConfig);

      final result = await useCase('MOR-4A9K2L8Q');

      expect(result, validConfig);
      verify(() => mockRepo.activateDevice('MOR-4A9K2L8Q')).called(1);
    });

    test('trims and uppercases the key', () async {
      when(() => mockRepo.activateDevice('MOR-4A9K2L8Q'))
          .thenAnswer((_) async => validConfig);

      final result = await useCase('  mor-4a9k2l8q  ');

      expect(result, validConfig);
      verify(() => mockRepo.activateDevice('MOR-4A9K2L8Q')).called(1);
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

    test('throws ValidationFailure when key does not start with MOR-', () async {
      expect(
        () => useCase('XYZ-12345678'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('MOR-'),
        )),
      );
    });

    test('throws ValidationFailure when key is too short', () async {
      expect(
        () => useCase('MOR-123'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('12 characters'),
        )),
      );
    });

    test('throws ValidationFailure when key is too long', () async {
      expect(
        () => useCase('MOR-123456789'),
        throwsA(isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          contains('12 characters'),
        )),
      );
    });

    test('propagates ServerFailure from repository', () async {
      when(() => mockRepo.activateDevice('MOR-00000000'))
          .thenThrow(const ServerFailure('Server unavailable'));

      expect(
        () => useCase('MOR-00000000'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
