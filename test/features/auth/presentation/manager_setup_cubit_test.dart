import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/auth/domain/entities/user_entity.dart';
import 'package:smartpos_client/features/auth/domain/usecases/create_manager.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/manager_setup_cubit.dart';
import 'package:smartpos_client/features/auth/presentation/cubit/manager_setup_state.dart';

class MockCreateManager extends Mock implements CreateManager {}

void main() {
  late MockCreateManager mockCreateManager;

  final manager = UserEntity(
    id: 'abc-123',
    name: 'Abebe Bikila',
    role: 'MANAGER',
    pinHash: 'hashed',
    isActive: true,
    createdAt: DateTime(2026, 9, 8),
  );

  setUp(() {
    mockCreateManager = MockCreateManager();
  });

  group('ManagerSetupCubit', () {
    test('initial state is ManagerSetupInitial', () {
      final cubit = ManagerSetupCubit(mockCreateManager);
      expect(cubit.state, isA<ManagerSetupInitial>());
      cubit.close();
    });

    blocTest<ManagerSetupCubit, ManagerSetupState>(
      'emits [Loading, Success] when creation succeeds',
      build: () {
        when(() => mockCreateManager(name: 'Abebe Bikila', pin: '1234'))
            .thenAnswer((_) async => manager);
        return ManagerSetupCubit(mockCreateManager);
      },
      act: (cubit) => cubit.submit(
        name: 'Abebe Bikila',
        pin: '1234',
        confirmPin: '1234',
      ),
      expect: () => [
        isA<ManagerSetupLoading>(),
        isA<ManagerSetupSuccess>().having(
          (s) => s.manager.name,
          'name',
          'Abebe Bikila',
        ),
      ],
    );

    blocTest<ManagerSetupCubit, ManagerSetupState>(
      'emits [Loading, Error] when PINs do not match',
      build: () => ManagerSetupCubit(mockCreateManager),
      act: (cubit) => cubit.submit(
        name: 'Abebe Bikila',
        pin: '1234',
        confirmPin: '4321',
      ),
      expect: () => [
        isA<ManagerSetupLoading>(),
        isA<ManagerSetupError>().having(
          (s) => s.message,
          'message',
          'PINs do not match',
        ),
      ],
    );

    blocTest<ManagerSetupCubit, ManagerSetupState>(
      'emits [Loading, Error] when use case throws ValidationFailure',
      build: () {
        when(() => mockCreateManager(name: 'A', pin: '1234'))
            .thenThrow(const ValidationFailure('Manager name must be at least 2 characters'));
        return ManagerSetupCubit(mockCreateManager);
      },
      act: (cubit) => cubit.submit(
        name: 'A',
        pin: '1234',
        confirmPin: '1234',
      ),
      expect: () => [
        isA<ManagerSetupLoading>(),
        isA<ManagerSetupError>().having(
          (s) => s.message,
          'message',
          contains('2 characters'),
        ),
      ],
    );

    blocTest<ManagerSetupCubit, ManagerSetupState>(
      'emits [Loading, Error] when manager already exists',
      build: () {
        when(() => mockCreateManager(name: 'Abebe Bikila', pin: '1234'))
            .thenThrow(const ConflictFailure('A manager already exists'));
        return ManagerSetupCubit(mockCreateManager);
      },
      act: (cubit) => cubit.submit(
        name: 'Abebe Bikila',
        pin: '1234',
        confirmPin: '1234',
      ),
      expect: () => [
        isA<ManagerSetupLoading>(),
        isA<ManagerSetupError>().having(
          (s) => s.message,
          'message',
          'A manager already exists',
        ),
      ],
    );
  });
}
