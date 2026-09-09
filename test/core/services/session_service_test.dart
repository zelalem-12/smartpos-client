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

    test('homeRoute is /cashier for cashier', () {
      service.setUser('u2', 'Chala', 'CASHIER');
      expect(service.homeRoute, AppRoutes.cashier);
      expect(service.isManager, false);
      expect(service.isCashier, true);
      expect(service.isCashier, true);
    });

    test('unknown role has no home or authenticated route access', () {
      service.setUser('u3', 'Unknown', 'SUPERVISOR');
      expect(service.homeRoute, isNull);
      expect(service.isManager, false);
      expect(service.isCashier, false);
      expect(service.canAccess(AppRoutes.cashier), false);
      expect(service.canAccess(AppRoutes.pos), false);
      expect(service.canAccess(AppRoutes.manager), false);
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
      expect(service.canAccess(AppRoutes.cashier), true);
      expect(service.canAccess(AppRoutes.pos), true);
      expect(service.canAccess(AppRoutes.checkout), true);
      expect(service.canAccess(AppRoutes.receipt), true);
      expect(service.canAccess(AppRoutes.reports), false);
      expect(service.canAccess(AppRoutes.settings), false);
      expect(service.canAccess(AppRoutes.catalog), false);
    });

    test('manager routes are a strict superset of cashier routes', () {
      service.setUser('u1', 'Abebe', 'MANAGER');
      final managerAccess = <String, bool>{
        AppRoutes.cashier: service.canAccess(AppRoutes.cashier),
        AppRoutes.pos: service.canAccess(AppRoutes.pos),
        AppRoutes.checkout: service.canAccess(AppRoutes.checkout),
        AppRoutes.receipt: service.canAccess(AppRoutes.receipt),
        AppRoutes.catalog: service.canAccess(AppRoutes.catalog),
        AppRoutes.reports: service.canAccess(AppRoutes.reports),
        AppRoutes.creditNotes: service.canAccess(AppRoutes.creditNotes),
        AppRoutes.cancellation: service.canAccess(AppRoutes.cancellation),
        AppRoutes.syncQueue: service.canAccess(AppRoutes.syncQueue),
        AppRoutes.audit: service.canAccess(AppRoutes.audit),
        AppRoutes.settings: service.canAccess(AppRoutes.settings),
      };

      service.setUser('u2', 'Chala', 'CASHIER');
      final cashierAccess = <String, bool>{
        AppRoutes.cashier: service.canAccess(AppRoutes.cashier),
        AppRoutes.pos: service.canAccess(AppRoutes.pos),
        AppRoutes.checkout: service.canAccess(AppRoutes.checkout),
        AppRoutes.receipt: service.canAccess(AppRoutes.receipt),
        AppRoutes.catalog: service.canAccess(AppRoutes.catalog),
        AppRoutes.reports: service.canAccess(AppRoutes.reports),
        AppRoutes.creditNotes: service.canAccess(AppRoutes.creditNotes),
        AppRoutes.cancellation: service.canAccess(AppRoutes.cancellation),
        AppRoutes.syncQueue: service.canAccess(AppRoutes.syncQueue),
        AppRoutes.audit: service.canAccess(AppRoutes.audit),
        AppRoutes.settings: service.canAccess(AppRoutes.settings),
      };

      expect(cashierAccess.values.where((v) => v).length, 4);
      for (final entry in cashierAccess.entries) {
        if (entry.value) {
          expect(managerAccess[entry.key], isTrue);
        }
      }
    });

    test('clear removes authentication', () {
      service.setUser('u1', 'Abebe', 'MANAGER');
      expect(service.isAuthenticated, true);
      service.clear();
      expect(service.isAuthenticated, false);
      expect(service.currentUserName, isNull);
    });

    group('evaluateRedirect', () {
      // Each test below stubs the repos, constructs a fresh SessionService,
      // and calls init() to load the cached startup state the synchronous
      // redirect guard reads.

      test('redirects to activation when device not activated', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => false);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => false);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();
        final result = service.evaluateRedirect(AppRoutes.pos);
        expect(result, AppRoutes.activation);
      });

      test('redirects to manager setup when no manager', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => false);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();
        final result = service.evaluateRedirect(AppRoutes.login);
        expect(result, AppRoutes.managerSetup);
      });

      test('redirects public routes to pin login before auth', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();
        final result = service.evaluateRedirect(AppRoutes.pos);
        expect(result, AppRoutes.login);
      });

      test('does not redirect pin login before auth', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();
        final result = service.evaluateRedirect(AppRoutes.login);
        expect(result, isNull);
      });

      test('skips activation after setup has completed', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();
        final result = service.evaluateRedirect(AppRoutes.activation);
        expect(result, AppRoutes.login);
      });

      test('skips manager setup after setup has completed', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();
        final result = service.evaluateRedirect(AppRoutes.managerSetup);
        expect(result, AppRoutes.login);
      });

      test(
        'redirects public routes to home when authenticated as manager',
        () async {
          when(() => mockStoreRepo.isDeviceActivated())
              .thenAnswer((_) async => true);
          when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
          service = SessionService(mockStoreRepo, mockUserRepo);
          await service.init();
          service.setUser('u1', 'Abebe', 'MANAGER');
          final result = service.evaluateRedirect(AppRoutes.login);
          expect(result, AppRoutes.manager);
        },
      );

      test('redirects restricted routes to home for cashier', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();
        service.setUser('u2', 'Chala', 'CASHIER');
        final result = service.evaluateRedirect(AppRoutes.reports);
        expect(result, AppRoutes.cashier);
      });

      test('enforces role-specific dashboards', () async {
        when(() => mockStoreRepo.isDeviceActivated())
            .thenAnswer((_) async => true);
        when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
        service = SessionService(mockStoreRepo, mockUserRepo);
        await service.init();

        service.setUser('u1', 'Abebe', 'MANAGER');
        expect(service.evaluateRedirect(AppRoutes.cashier), AppRoutes.manager);

        service.setUser('u2', 'Chala', 'CASHIER');
        expect(service.evaluateRedirect(AppRoutes.manager), AppRoutes.cashier);
      });

      test(
        'refresh reloads cached startup state and notifies listeners',
        () async {
          var activatedCalls = 0;
          when(() => mockStoreRepo.isDeviceActivated()).thenAnswer((_) async {
            activatedCalls++;
            return activatedCalls == 1 ? false : true;
          });
          when(() => mockUserRepo.hasManager()).thenAnswer((_) async => true);
          service = SessionService(mockStoreRepo, mockUserRepo);
          await service.init();
          expect(service.isDeviceActivated, isFalse);
          expect(service.evaluateRedirect(AppRoutes.pos), AppRoutes.activation);

          var notified = 0;
          service.addListener(() => notified++);

          await service.refresh();
          expect(service.isDeviceActivated, isTrue);
          expect(notified, 1);
          expect(service.evaluateRedirect(AppRoutes.pos), AppRoutes.login);
        },
      );
    });
  });
}
