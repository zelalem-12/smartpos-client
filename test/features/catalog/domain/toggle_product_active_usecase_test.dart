import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smartpos_client/features/catalog/domain/usecases/toggle_product_active.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late ToggleProductActive usecase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = ToggleProductActive(mockRepository);
  });

  final now = DateTime(2024);

  test('toggles product active state', () async {
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

    when(() => mockRepository.toggleProductActive('p1'))
        .thenAnswer((_) async => product.copyWith(isActive: false));

    final result = await usecase('p1');

    expect(result.isActive, isFalse);
    verify(() => mockRepository.toggleProductActive('p1')).called(1);
  });
}
