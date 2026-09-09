import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/catalog/domain/entities/category_entity.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/add_product.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/get_categories.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/get_products.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/search_products.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/toggle_product_active.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/update_product.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:smartpos_client/features/catalog/presentation/bloc/catalog_state.dart';

class MockGetCategories extends Mock implements GetCategories {}

class MockGetProducts extends Mock implements GetProducts {}

class MockSearchProducts extends Mock implements SearchProducts {}

class MockAddProduct extends Mock implements AddProduct {}

class MockUpdateProduct extends Mock implements UpdateProduct {}

class MockToggleProductActive extends Mock implements ToggleProductActive {}

void main() {
  late MockGetCategories mockGetCategories;
  late MockGetProducts mockGetProducts;
  late MockSearchProducts mockSearchProducts;
  late MockAddProduct mockAddProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockToggleProductActive mockToggleProductActive;

  final now = DateTime(2024);

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

  CatalogBloc buildBloc() {
    return CatalogBloc(
      mockGetCategories,
      mockGetProducts,
      mockSearchProducts,
      mockAddProduct,
      mockUpdateProduct,
      mockToggleProductActive,
    );
  }

  setUp(() {
    mockGetCategories = MockGetCategories();
    mockGetProducts = MockGetProducts();
    mockSearchProducts = MockSearchProducts();
    mockAddProduct = MockAddProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockToggleProductActive = MockToggleProductActive();
  });

  setUpAll(() {
    registerFallbackValue(
      CategoryEntity(id: '', name: '', isActive: true, createdAt: now),
    );
    registerFallbackValue(
      ProductEntity(
        id: '',
        categoryId: '',
        name: '',
        barcode: '',
        price: 0,
        unit: '',
        isActive: true,
        createdAt: now,
      ),
    );
  });

  group('CatalogBloc', () {
    test('initial state is CatalogInitial', () {
      expect(buildBloc().state, isA<CatalogInitial>());
    });

    blocTest<CatalogBloc, CatalogState>(
      'emits [Loading, Loaded] when LoadCatalog succeeds',
      setUp: () {
        when(() => mockGetCategories()).thenAnswer((_) async => [category]);
        when(() => mockGetProducts()).thenAnswer((_) async => [product]);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const LoadCatalog()),
      expect: () => [
        isA<CatalogLoading>(),
        isA<CatalogLoaded>().having(
          (s) => s.products.length,
          'products count',
          1,
        ),
      ],
    );

    blocTest<CatalogBloc, CatalogState>(
      'emits [Loading, Error] when LoadCatalog fails',
      setUp: () {
        when(() => mockGetCategories()).thenThrow(Exception('db error'));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const LoadCatalog()),
      expect: () => [
        isA<CatalogLoading>(),
        isA<CatalogError>().having(
          (s) => s.message,
          'message',
          'Something went wrong. Please try again.',
        ),
      ],
    );

    blocTest<CatalogBloc, CatalogState>(
      'filters products by category',
      seed: () => CatalogLoaded(
        categories: [category],
        products: [product],
        filteredProducts: [product],
      ),
      setUp: () {
        when(() => mockGetProducts()).thenAnswer((_) async => [product]);
      },
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const SearchCatalog(query: '', categoryId: 'cat-1')),
      expect: () => [
        isA<CatalogLoaded>().having(
          (s) => s.filteredProducts.length,
          'filtered count',
          1,
        ),
      ],
    );

    blocTest<CatalogBloc, CatalogState>(
      'searches products by query and category',
      seed: () => CatalogLoaded(
        categories: [category],
        products: [product],
        filteredProducts: [product],
      ),
      setUp: () {
        when(() => mockGetProducts()).thenAnswer((_) async => [product]);
        when(() => mockSearchProducts('coffee'))
            .thenAnswer((_) async => [product]);
      },
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const SearchCatalog(query: 'coffee', categoryId: 'cat-1')),
      expect: () => [
        isA<CatalogLoaded>().having(
          (s) => s.searchQuery,
          'search query',
          'coffee',
        ),
      ],
    );

    blocTest<CatalogBloc, CatalogState>(
      'keeps catalog loaded across consecutive search characters',
      seed: () => CatalogLoaded(
        categories: [category],
        products: [product],
        filteredProducts: [product],
      ),
      setUp: () {
        when(() => mockGetProducts()).thenAnswer((_) async => [product]);
        when(() => mockSearchProducts(any()))
            .thenAnswer((_) async => [product]);
      },
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const SearchCatalog(query: 'c'))
        ..add(const SearchCatalog(query: 'co')),
      expect: () => [
        isA<CatalogLoaded>().having((s) => s.searchQuery, 'query', 'c'),
        isA<CatalogLoaded>().having((s) => s.searchQuery, 'query', 'co'),
      ],
    );

    blocTest<CatalogBloc, CatalogState>(
      'emits [Loading, Loaded] when adding a product succeeds',
      setUp: () {
        when(
          () => mockAddProduct(
            categoryId: any(named: 'categoryId'),
            name: any(named: 'name'),
            description: any(named: 'description'),
            barcode: any(named: 'barcode'),
            price: any(named: 'price'),
            cost: any(named: 'cost'),
            stockQuantity: any(named: 'stockQuantity'),
            unit: any(named: 'unit'),
            vatRate: any(named: 'vatRate'),
          ),
        ).thenAnswer((_) async => product);
        when(() => mockGetCategories()).thenAnswer((_) async => [category]);
        when(() => mockGetProducts()).thenAnswer((_) async => [product]);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(AddProductEvent(product)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        isA<CatalogLoading>(),
        isA<CatalogLoaded>().having(
          (s) => s.products.length,
          'products count',
          1,
        ),
      ],
    );

    blocTest<CatalogBloc, CatalogState>(
      'emits [Loading, Error] when update fails',
      seed: () => CatalogLoaded(
        categories: [category],
        products: [product],
        filteredProducts: [product],
      ),
      setUp: () {
        when(() => mockUpdateProduct(any()))
            .thenThrow(const FormatException('invalid'));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(UpdateProductEvent(product)),
      expect: () => [isA<CatalogLoading>(), isA<CatalogError>()],
    );

    blocTest<CatalogBloc, CatalogState>(
      'reloads catalog after toggle succeeds',
      seed: () => CatalogLoaded(
        categories: [category],
        products: [product],
        filteredProducts: [product],
      ),
      setUp: () {
        when(() => mockToggleProductActive('p1'))
            .thenAnswer((_) async => product.copyWith(isActive: false));
        when(() => mockGetCategories()).thenAnswer((_) async => [category]);
        when(() => mockGetProducts())
            .thenAnswer((_) async => [product.copyWith(isActive: false)]);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const ToggleProductActiveEvent('p1')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        isA<CatalogLoading>(),
        isA<CatalogLoaded>().having(
          (s) => s.products.first.isActive,
          'product inactive',
          isFalse,
        ),
      ],
    );
  });
}
