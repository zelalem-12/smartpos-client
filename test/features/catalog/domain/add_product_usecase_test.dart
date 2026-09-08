import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/features/catalog/domain/entities/category_entity.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/add_product.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late AddProduct usecase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = AddProduct(mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(
      CategoryEntity(
        id: '',
        name: '',
        isActive: true,
        createdAt: DateTime(2024),
      ),
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
        createdAt: DateTime(2024),
      ),
    );
  });

  final category = CategoryEntity(
    id: 'cat-1',
    name: 'Test Category',
    isActive: true,
    createdAt: DateTime(2024),
  );

  group('AddProduct', () {
    test('returns product when input is valid and barcode is unique', () async {
      when(() => mockRepository.getCategoryById('cat-1'))
          .thenAnswer((_) async => category);
      when(() => mockRepository.searchProducts('BAR-001'))
          .thenAnswer((_) async => []);
      when(() => mockRepository.addProduct(any()))
          .thenAnswer((invocation) async {
            final product = invocation.positionalArguments[0] as ProductEntity;
            return product.copyWith(id: 'generated-id');
          });

      final result = await usecase(
        categoryId: 'cat-1',
        name: 'Coffee',
        barcode: 'BAR-001',
        price: 25.0,
        unit: 'cup',
      );

      expect(result.name, 'Coffee');
      expect(result.barcode, 'BAR-001');
      verify(() => mockRepository.addProduct(any())).called(1);
    });

    test('throws ValidationFailure when name is empty', () async {
      expect(
        () => usecase(
          categoryId: 'cat-1',
          name: '   ',
          barcode: 'BAR-001',
          price: 25.0,
          unit: 'cup',
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('throws ValidationFailure when price is zero', () async {
      expect(
        () => usecase(
          categoryId: 'cat-1',
          name: 'Coffee',
          barcode: 'BAR-001',
          price: 0.0,
          unit: 'cup',
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('throws ValidationFailure when barcode is empty', () async {
      expect(
        () => usecase(
          categoryId: 'cat-1',
          name: 'Coffee',
          barcode: '  ',
          price: 25.0,
          unit: 'cup',
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('throws NotFoundFailure when category does not exist', () async {
      when(() => mockRepository.getCategoryById('missing'))
          .thenAnswer((_) async => null);

      expect(
        () => usecase(
          categoryId: 'missing',
          name: 'Coffee',
          barcode: 'BAR-001',
          price: 25.0,
          unit: 'cup',
        ),
        throwsA(isA<NotFoundFailure>()),
      );
    });

    test('throws ConflictFailure when barcode already exists', () async {
      when(() => mockRepository.getCategoryById('cat-1'))
          .thenAnswer((_) async => category);
      when(() => mockRepository.searchProducts('BAR-001')).thenAnswer(
        (_) async => [
          ProductEntity(
            id: 'existing',
            categoryId: 'cat-1',
            name: 'Existing',
            barcode: 'BAR-001',
            price: 10.0,
            unit: 'cup',
            isActive: true,
            createdAt: DateTime(2024),
          ),
        ],
      );

      expect(
        () => usecase(
          categoryId: 'cat-1',
          name: 'Coffee',
          barcode: 'BAR-001',
          price: 25.0,
          unit: 'cup',
        ),
        throwsA(isA<ConflictFailure>()),
      );
    });
  });
}
