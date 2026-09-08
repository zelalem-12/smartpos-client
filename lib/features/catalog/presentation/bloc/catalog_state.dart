import 'package:equatable/equatable.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

/// States for [CatalogBloc].
sealed class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any load.
class CatalogInitial extends CatalogState {
  const CatalogInitial();
}

/// Data is being loaded or mutated.
class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

/// Catalog data loaded successfully.
class CatalogLoaded extends CatalogState {
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final String searchQuery;
  final String? selectedCategoryId;

  const CatalogLoaded({
    required this.categories,
    required this.products,
    required this.filteredProducts,
    this.searchQuery = '',
    this.selectedCategoryId,
  });

  CatalogLoaded copyWith({
    List<CategoryEntity>? categories,
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    String? searchQuery,
    String? selectedCategoryId,
  }) {
    return CatalogLoaded(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    products,
    filteredProducts,
    searchQuery,
    selectedCategoryId,
  ];
}

/// An error occurred while loading or mutating catalog data.
class CatalogError extends CatalogState {
  final String message;

  const CatalogError(this.message);

  @override
  List<Object?> get props => [message];
}
