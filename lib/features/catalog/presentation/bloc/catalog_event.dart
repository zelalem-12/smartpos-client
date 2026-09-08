import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';

/// Events for [CatalogBloc].
sealed class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

/// Load categories and products.
class LoadCatalog extends CatalogEvent {
  const LoadCatalog();
}

/// Search and optionally filter by category.
class SearchCatalog extends CatalogEvent {
  final String query;
  final String? categoryId;

  const SearchCatalog({this.query = '', this.categoryId});

  @override
  List<Object?> get props => [query, categoryId];
}

/// Add a new product.
class AddProductEvent extends CatalogEvent {
  final ProductEntity product;

  const AddProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

/// Update an existing product.
class UpdateProductEvent extends CatalogEvent {
  final ProductEntity product;

  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

/// Toggle the active state of a product.
class ToggleProductActiveEvent extends CatalogEvent {
  final String productId;

  const ToggleProductActiveEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
