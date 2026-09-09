import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/activation/domain/entities/store_config_entity.dart';
import 'package:smartpos_client/features/activation/domain/usecases/activate_device.dart';
import 'package:smartpos_client/features/activation/presentation/cubit/activation_cubit.dart';
import 'package:smartpos_client/features/activation/presentation/cubit/activation_state.dart';

class MockActivateDevice extends Mock implements ActivateDevice {}

class MockStoreConfigRepository extends Mock implements StoreConfigRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockActivateDevice mockActivateDevice;
  late SessionService sessionService;

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
    mockActivateDevice = MockActivateDevice();
    final storeRepo = MockStoreConfigRepository();
    final userRepo = MockUserRepository();
    when(() => storeRepo.isDeviceActivated()).thenAnswer((_) async => false);
    when(() => userRepo.hasManager()).thenAnswer((_) async => false);
    sessionService = SessionService(storeRepo, userRepo);
  });

  group('ActivationCubit', () {
    test('initial state is ActivationInitial', () {
      final cubit = ActivationCubit(mockActivateDevice, sessionService);
      expect(cubit.state, isA<ActivationInitial>());
      cubit.close();
    });

    blocTest<ActivationCubit, ActivationState>(
      'emits [Loading, Success] when valid key submitted',
      build: () {
        when(() => mockActivateDevice('MOR-4A9K2L8Q'))
            .thenAnswer((_) async => validConfig);
        return ActivationCubit(mockActivateDevice, sessionService);
      },
      act: (cubit) => cubit.activate('MOR-4A9K2L8Q'),
      expect: () => [
        isA<ActivationLoading>(),
        isA<ActivationSuccess>().having(
          (s) => s.storeConfig.tin,
          'tin',
          '0012345678',
        ),
      ],
    );

    blocTest<ActivationCubit, ActivationState>(
      'emits [Loading, Error] when empty key submitted',
      build: () {
        when(() => mockActivateDevice(''))
            .thenThrow(const ValidationFailure('License key is required'));
        return ActivationCubit(mockActivateDevice, sessionService);
      },
      act: (cubit) => cubit.activate(''),
      expect: () => [
        isA<ActivationLoading>(),
        isA<ActivationError>().having(
          (s) => s.message,
          'message',
          'License key is required',
        ),
      ],
    );

    blocTest<ActivationCubit, ActivationState>(
      'emits [Loading, Error] when invalid format submitted',
      build: () {
        when(() => mockActivateDevice('XXXXX')).thenThrow(
          const ValidationFailure('License key must start with "MOR-"'),
        );
        return ActivationCubit(mockActivateDevice, sessionService);
      },
      act: (cubit) => cubit.activate('XXXXX'),
      expect: () => [
        isA<ActivationLoading>(),
        isA<ActivationError>().having(
          (s) => s.message,
          'message',
          contains('MOR-'),
        ),
      ],
    );

    blocTest<ActivationCubit, ActivationState>(
      'emits [Loading, Error] when server fails',
      build: () {
        when(() => mockActivateDevice('MOR-00000000'))
            .thenThrow(const ServerFailure('Server unavailable'));
        return ActivationCubit(mockActivateDevice, sessionService);
      },
      act: (cubit) => cubit.activate('MOR-00000000'),
      expect: () => [
        isA<ActivationLoading>(),
        isA<ActivationError>().having(
          (s) => s.message,
          'message',
          'Server unavailable',
        ),
      ],
    );
  });
}
