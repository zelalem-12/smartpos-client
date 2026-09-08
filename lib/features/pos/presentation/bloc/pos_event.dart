import 'package:equatable/equatable.dart';

/// Events for [PosBloc].
sealed class PosEvent extends Equatable {
  const PosEvent();

  @override
  List<Object?> get props => [];
}

/// Load categories and active products for the POS catalog.
class LoadPosCatalog extends PosEvent {
  const LoadPosCatalog();
}

/// Filter products by search query.
class SearchPosProducts extends PosEvent {
  final String query;

  const SearchPosProducts(this.query);

  @override
  List<Object?> get props => [query];
}

/// Filter products by category.
class SelectPosCategory extends PosEvent {
  final String? categoryId;

  const SelectPosCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
