import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';

class MockStoreConfigRepository extends Mock implements StoreConfigRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockStoreConfigRepository mockStoreRepo;
  late MockUserRepository mockUserRepo;
  late SessionService service;

  setUp(() {
    mockStoreRepo = MockStoreConfigRepository();
    mockUserRepo = MockUserRepository();
    service = SessionService(mockStoreRepo, mockUserRepo);
  });

  group('SessionService', () {
    test('homeRoute is null when not authenticated', () {
      expect(service.homeRoute, isNull);
    });

    test('homeRoute is /manager for manager', () {
      service.setUser('u1', 'Abebe', 'MANAGER');
      expect(service.homeRoute, AppRoutes.manager);
      expect(service.isManager, true);
    });

    test('homeRoute is /pos for cashier', () {
      service.setUser('u2', 'Chala', 'CASHIER');
      expect(service.homeRoute, AppRoutes.pos);
      expect(service.isManager, false);
    });

    test('manager can access all authenticated routes', () {
      service.setUser('u1', 'Abebe', 'MANAGER');
      expect(service.canAccess(AppRoutes.pos), true);
      expect(service.canAccess(AppRoutes.reports), true);
      expect(service.canAccess(AppRoutes.settings), true);
      expect(service.canAccess(AppRoutes.audit), true);
    });

    test('cashier can access only sales routes', () {
      service.setUser('u2', 'Chala', 'CASHIER');
      expect(service.canAccess(AppRoutes.pos), true);
      expect(service.canAccess(AppRoutes.checkout), true);
      expect(service.canAccess(AppRoutes.receipt), true);
      expect(service.canAccess(AppRoutes.reports), false);
      expect(service.canAccess(AppRoutes.settings), false);
      expect(service.canAccess(AppRoutes.catalog), false);
    });

    test('clear removes authentication', () {
      service.setUser('u1', 'Abebe', 'MANAGER');
      expect(service.isAuthenticated, true);
      service.clear();
      expect(service.isAuthenticated, false);
      expect(service.currentUserName, isNull);
    });

    group('evaluateRedirect', () {
      test('redirects to activation when device not activated', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => false);
        final result = await service.evaluateRedirect(AppRoutes.pos);
        expect(result, AppRoutes.activation);
      });

      test('redirects to manager setup when no manager', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => false);
        final result = await service.evaluateRedirect(AppRoutes.login);
        expect(result, AppRoutes.managerSetup);
      });

      test('redirects public routes to pin login before auth', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        final result = await service.evaluateRedirect(AppRoutes.pos);
        expect(result, AppRoutes.login);
      });

      test('does not redirect pin login before auth', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        final result = await service.evaluateRedirect(AppRoutes.login);
        expect(result, isNull);
      });

      test('skips activation after setup has completed', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        final result = await service.evaluateRedirect(AppRoutes.activation);
        expect(result, AppRoutes.login);
      });

      test('skips manager setup after setup has completed', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        final result = await service.evaluateRedirect(AppRoutes.managerSetup);
        expect(result, AppRoutes.login);
      });

      test(
        'redirects public routes to home when authenticated as manager',
        () async {
          service.setUser('u1', 'Abebe', 'MANAGER');
          when(() => mockStoreRepo.isDeviceActivated())
              .thenAnswer((_) async => true);
          when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
          final result = await service.evaluateRedirect(AppRoutes.login);
          expect(result, AppRoutes.manager);
        },
      );

      test('redirects restricted routes to home for cashier', () async {
        service.setUser('u2', 'Chala', 'CASHIER');
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        final result = await service.evaluateRedirect(AppRoutes.reports);
        expect(result, AppRoutes.pos);
      });
    });
  });
}
