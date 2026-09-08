import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/get_products.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late GetProducts usecase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = GetProducts(mockRepository);
  });

  final now = DateTime(2024);

  test('returns all products when no category is provided', () async {
    when(() => mockRepository.getProducts()).thenAnswer(
      (_) async => [
        ProductEntity(
          id: 'p1',
          categoryId: 'cat-1',
          name: 'Coffee',
          barcode: 'BAR-001',
          price: 25.0,
          unit: 'cup',
          isActive: true,
          createdAt: now,
        ),
      ],
    );

    final result = await usecase();

    expect(result.length, 1);
    verify(() => mockRepository.getProducts()).called(1);
  });

  test('filters products by category when categoryId is provided', () async {
    when(() => mockRepository.getProductsByCategory('cat-1')).thenAnswer(
      (_) async => [
        ProductEntity(
          id: 'p1',
          categoryId: 'cat-1',
          name: 'Coffee',
          barcode: 'BAR-001',
          price: 25.0,
          unit: 'cup',
          isActive: true,
          createdAt: now,
        ),
      ],
    );

    final result = await usecase(categoryId: 'cat-1');

    expect(result.length, 1);
    verify(() => mockRepository.getProductsByCategory('cat-1')).called(1);
    verifyNever(() => mockRepository.getProducts());
  });
}
