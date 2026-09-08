import 'package:equatable/equatable.dart';

import '../../../catalog/domain/entities/category_entity.dart';
import '../../../catalog/domain/entities/product_entity.dart';

/// States for [PosBloc].
sealed class PosState extends Equatable {
  const PosState();

  @override
  List<Object?> get props => [];
}

/// Initial POS state.
class PosInitial extends PosState {
  const PosInitial();
}

/// POS catalog data is being loaded.
class PosLoading extends PosState {
  const PosLoading();
}

/// POS catalog loaded successfully.
class PosLoaded extends PosState {
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final String searchQuery;
  final String? selectedCategoryId;

  const PosLoaded({
    required this.categories,
    required this.products,
    required this.filteredProducts,
    this.searchQuery = '',
    this.selectedCategoryId,
  });

  PosLoaded copyWith({
    List<CategoryEntity>? categories,
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    String? searchQuery,
    String? selectedCategoryId,
  }) {
    return PosLoaded(
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

/// POS catalog failed to load.
class PosError extends PosState {
  final String message;

  const PosError(this.message);

  @override
  List<Object?> get props => [message];
}
