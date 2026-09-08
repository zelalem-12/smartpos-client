import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/catalog/domain/entities/category_entity.dart';
import 'package:smartpos_client/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/get_categories.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late GetCategories usecase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = GetCategories(mockRepository);
  });

  test('returns list of categories from repository', () async {
    final now = DateTime(2024);
    when(() => mockRepository.getCategories()).thenAnswer(
      (_) async => [
        CategoryEntity(
          id: 'cat-1',
          name: 'Beverages',
          isActive: true,
          createdAt: now,
        ),
      ],
    );

    final result = await usecase();

    expect(result.length, 1);
    expect(result.first.name, 'Beverages');
    verify(() => mockRepository.getCategories()).called(1);
  });
}
