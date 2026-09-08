import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/catalog/domain/entities/category_entity.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/update_product.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late UpdateProduct usecase;
  late MockCatalogRepository mockRepository;

  final now = DateTime(2024);

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = UpdateProduct(mockRepository);
  });

  setUpAll(() {
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

  final baseProduct = ProductEntity(
    id: 'p1',
    categoryId: 'cat-1',
    name: 'Coffee',
    barcode: 'BAR-001',
    price: 25.0,
    unit: 'cup',
    isActive: true,
    createdAt: now,
  );

  final category = CategoryEntity(
    id: 'cat-1',
    name: 'Beverages',
    isActive: true,
    createdAt: now,
  );

  group('UpdateProduct', () {
    test('returns updated product when input is valid', () async {
      final updated = baseProduct.copyWith(name: 'Premium Coffee', price: 30.0);

      when(() => mockRepository.getCategoryById('cat-1'))
          .thenAnswer((_) async => category);
      when(() => mockRepository.searchProducts('BAR-001'))
          .thenAnswer((_) async => [baseProduct]);
      when(() => mockRepository.updateProduct(any())).thenAnswer(
        (invocation) async =>
            invocation.positionalArguments[0] as ProductEntity,
      );

      final result = await usecase(updated);

      expect(result.name, 'Premium Coffee');
      expect(result.price, 30.0);
      verify(() => mockRepository.updateProduct(any())).called(1);
    });

    test('throws ValidationFailure when name is empty', () async {
      final invalid = baseProduct.copyWith(name: '  ');

      expect(() => usecase(invalid), throwsA(isA<ValidationFailure>()));
    });

    test('throws ValidationFailure when price is negative', () async {
      final invalid = baseProduct.copyWith(price: -1.0);

      expect(() => usecase(invalid), throwsA(isA<ValidationFailure>()));
    });

    test(
      'throws ConflictFailure when barcode duplicates another product',
      () async {
        final duplicate = baseProduct.copyWith(barcode: 'BAR-002');

        when(() => mockRepository.getCategoryById('cat-1'))
            .thenAnswer((_) async => category);
        when(() => mockRepository.searchProducts('BAR-002')).thenAnswer(
          (_) async => [
            ProductEntity(
              id: 'p2',
              categoryId: 'cat-1',
              name: 'Tea',
              barcode: 'BAR-002',
              price: 20.0,
              unit: 'cup',
              isActive: true,
              createdAt: now,
            ),
          ],
        );

        expect(() => usecase(duplicate), throwsA(isA<ConflictFailure>()));
      },
    );

    test('allows keeping same barcode for the updated product', () async {
      final updated = baseProduct.copyWith(name: 'Premium Coffee');

      when(() => mockRepository.getCategoryById('cat-1'))
          .thenAnswer((_) async => category);
      when(() => mockRepository.searchProducts('BAR-001'))
          .thenAnswer((_) async => [baseProduct]);
      when(() => mockRepository.updateProduct(any())).thenAnswer(
        (invocation) async =>
            invocation.positionalArguments[0] as ProductEntity,
      );

      final result = await usecase(updated);

      expect(result.name, 'Premium Coffee');
    });
  });
}
