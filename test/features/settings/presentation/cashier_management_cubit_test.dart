import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/features/auth/domain/entities/user_entity.dart';
import 'package:smartpos_client/features/auth/domain/repositories/auth_repository.dart';
import 'package:smartpos_client/features/auth/domain/usecases/create_cashier.dart';
import 'package:smartpos_client/features/settings/presentation/cubit/cashier_management_cubit.dart';
import 'package:smartpos_client/features/settings/presentation/cubit/cashier_management_state.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockUserRepository mockUserRepo;
  late CreateCashier createCashier;
  late CashierManagementCubit cubit;

  final now = DateTime(2026, 9, 8);
  final cashier = User(
    id: 'csh-001',
    username: 'selam_t',
    fullName: 'Selam Teshale',
    role: 'CASHIER',
    passwordHash: 'hash',
    isActive: true,
    createdAt: now,
  );
  final createdCashier = UserEntity(
    id: 'csh-002',
    username: 'new_cashier',
    fullName: 'New Cashier',
    role: 'CASHIER',
    passwordHash: 'hash',
    isActive: true,
    createdAt: now,
  );
  final manager = User(
    id: 'mgr-001',
    username: 'abebe_m',
    fullName: 'Abebe Mulu',
    role: 'MANAGER',
    passwordHash: 'hash',
    isActive: true,
    createdAt: now,
  );

  setUpAll(() {
    registerFallbackValue(
      UsersCompanion(
        id: const Value(''),
        username: const Value(''),
        fullName: const Value(''),
        role: const Value(''),
        passwordHash: const Value(''),
        isActive: const Value(true),
      ),
    );
  });

  setUp(() {
    mockUserRepo = MockUserRepository();
    final mockAuthRepo = MockAuthRepository();
    createCashier = CreateCashier(mockAuthRepo);
    cubit = CashierManagementCubit(mockUserRepo, createCashier);

    when(
      () => mockAuthRepo.createCashier(
        username: any(named: 'username'),
        fullName: any(named: 'fullName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => createdCashier);
  });

  group('CashierManagementCubit', () {
    test('initial state is CashierManagementInitial', () {
      expect(cubit.state, isA<CashierManagementInitial>());
    });

    test('loadUsers emits loaded state with active users', () async {
      when(() => mockUserRepo.getAllUsers()).thenAnswer((_) async => [manager]);

      await cubit.loadUsers();

      expect(cubit.state, isA<CashierManagementLoaded>());
      expect((cubit.state as CashierManagementLoaded).users.length, 1);
    });

    test('loadUsers emits error when repository fails', () async {
      when(() => mockUserRepo.getAllUsers()).thenThrow(Exception('db failure'));

      await cubit.loadUsers();

      expect(cubit.state, isA<CashierManagementError>());
    });

    test('toggleActive refuses to deactivate a manager', () async {
      when(() => mockUserRepo.getAllUsers()).thenAnswer((_) async => [manager]);

      await cubit.toggleActive(manager);

      verifyNever(() => mockUserRepo.updateUser(any()));
      expect(cubit.state, isA<CashierManagementError>());
    });

    test('toggleActive deactivates a cashier', () async {
      when(() => mockUserRepo.getAllUsers()).thenAnswer((_) async => [cashier]);
      when(() => mockUserRepo.updateUser(any())).thenAnswer((_) async => true);

      await cubit.toggleActive(cashier);

      verify(() => mockUserRepo.updateUser(any())).called(1);
      expect(cubit.state, isA<CashierManagementLoaded>());
    });

    test('createCashier refreshes the user list on success', () async {
      when(() => mockUserRepo.getAllUsers()).thenAnswer((_) async => [cashier]);

      await cubit.createCashier(
        username: 'new_cashier',
        fullName: 'New Cashier',
        password: '1234',
      );

      expect(cubit.state, isA<CashierManagementLoaded>());
    });

    test(
      'createCashier emits error and refreshes list on validation failure',
      () async {
        when(() => mockUserRepo.getAllUsers())
            .thenAnswer((_) async => [manager]);

        await cubit.createCashier(username: 'ab', fullName: 'A', password: '1');

        expect(cubit.state, isA<CashierManagementError>());
      },
    );
  });
}
