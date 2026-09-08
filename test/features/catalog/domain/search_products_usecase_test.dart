import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/search_products.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late SearchProducts usecase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = SearchProducts(mockRepository);
  });

  final now = DateTime(2024);

  test('returns products matching the search query', () async {
    when(() => mockRepository.searchProducts('coffee')).thenAnswer(
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

    final result = await usecase('coffee');

    expect(result.length, 1);
    expect(result.first.name, 'Coffee');
    verify(() => mockRepository.searchProducts('coffee')).called(1);
  });
}
