import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/di/injection.dart';
import 'package:smartpos_client/core/router/app_routes.dart';
import 'package:smartpos_client/core/services/session_service.dart';
import 'package:smartpos_client/features/catalog/domain/entities/category_entity.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_state.dart';
import 'package:smartpos_client/features/catalog/presentation/pages/catalog_management_page.dart';

class _FakeSessionService implements SessionService {
  @override
  Session? get currentSession =>
      const Session(id: 'u1', name: 'Abebe', role: 'MANAGER');

  @override
  bool get isAuthenticated => true;

  @override
  bool get isManager => true;

  @override
  String? get currentUserName => currentSession?.name;

  @override
  String? get currentUserRole => currentSession?.role;

  @override
  String? get homeRoute => AppRoutes.manager;

  @override
  void setUser(String id, String name, String role) {}

  @override
  void clear() {}

  @override
  bool canAccess(String path) => true;

  @override
  Future<String?> evaluateRedirect(String path) async => null;
}

class MockCatalogBloc extends MockBloc<CatalogEvent, CatalogState>
    implements CatalogBloc {}

void main() {
  late MockCatalogBloc mockBloc;
  final now = DateTime(2024);

  setUp(() {
    mockBloc = MockCatalogBloc();

    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
    sl.registerLazySingleton<SessionService>(() => _FakeSessionService());
  });

  tearDown(() {
    if (sl.isRegistered<SessionService>()) {
      sl.unregister<SessionService>();
    }
  });

  Widget buildSubject() {
    final router = GoRouter(
      initialLocation: AppRoutes.catalog,
      routes: [
        GoRoute(
          path: AppRoutes.catalog,
          builder: (context, state) => BlocProvider<CatalogBloc>.value(
            value: mockBloc,
            child: const CatalogManagementPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.manager,
          builder: (context, state) => const Scaffold(body: Text('Dashboard')),
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  group('CatalogManagementPage', () {
    testWidgets('renders loading indicator when loading', (tester) async {
      when(() => mockBloc.state).thenReturn(const CatalogLoading());

      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders product list when loaded', (tester) async {
      final category = CategoryEntity(
        id: 'cat-1',
        name: 'Beverages',
        isActive: true,
        createdAt: now,
      );
      final product = ProductEntity(
        id: 'p1',
        categoryId: 'cat-1',
        name: 'Coffee',
        barcode: 'BAR-001',
        price: 25.0,
        unit: 'cup',
        isActive: true,
        createdAt: now,
      );

      when(() => mockBloc.state).thenReturn(
        CatalogLoaded(
          categories: [category],
          products: [product],
          filteredProducts: [product],
        ),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.text('Coffee'), findsOneWidget);
      expect(find.text('Beverages · BAR-001'), findsOneWidget);
      expect(find.text('1 products'), findsOneWidget);
    });

    testWidgets('renders empty state when no products', (tester) async {
      when(() => mockBloc.state).thenReturn(
        const CatalogLoaded(categories: [], products: [], filteredProducts: []),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.text('No products found'), findsOneWidget);
    });

    testWidgets('tapping add FAB opens product dialog', (tester) async {
      final category = CategoryEntity(
        id: 'cat-1',
        name: 'Beverages',
        isActive: true,
        createdAt: now,
      );

      when(() => mockBloc.state).thenReturn(
        CatalogLoaded(
          categories: [category],
          products: const [],
          filteredProducts: const [],
        ),
      );
      whenListen(
        mockBloc,
        Stream.fromIterable([
          CatalogLoaded(
            categories: [category],
            products: const [],
            filteredProducts: const [],
          ),
        ]),
        initialState: CatalogLoaded(
          categories: [category],
          products: const [],
          filteredProducts: const [],
        ),
      );

      await tester.pumpWidget(buildSubject());
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Add Product'), findsOneWidget);
    });

    testWidgets('search input dispatches SearchCatalog event', (tester) async {
      final category = CategoryEntity(
        id: 'cat-1',
        name: 'Beverages',
        isActive: true,
        createdAt: now,
      );

      when(() => mockBloc.state).thenReturn(
        CatalogLoaded(
          categories: [category],
          products: const [],
          filteredProducts: const [],
        ),
      );

      await tester.pumpWidget(buildSubject());

      await tester.enterText(find.byType(TextField).first, 'coffee');
      await tester.pump();

      verify(() => mockBloc.add(const SearchCatalog(query: 'coffee')))
          .called(1);
    });

    testWidgets('search field retains focus while typing a complete phrase', (
      tester,
    ) async {
      when(() => mockBloc.state).thenReturn(
        const CatalogLoaded(categories: [], products: [], filteredProducts: []),
      );

      await tester.pumpWidget(buildSubject());
      final searchField = find.byType(TextField).first;
      await tester.tap(searchField);
      await tester.pump();

      for (final value in [
        'c',
        'co',
        'cof',
        'coff',
        'coffee',
        'coffee beans',
      ]) {
        await tester.enterText(searchField, value);
        await tester.pump();
        expect(tester.testTextInput.isVisible, isTrue);
        expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);
      }

      expect(find.text('coffee beans'), findsOneWidget);
    });
  });
}
