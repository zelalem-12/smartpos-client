// ignore_for_file: prefer_initializing_formals

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../catalog/domain/entities/product_entity.dart';
import '../../../catalog/domain/usecases/get_categories.dart';
import '../../../catalog/domain/usecases/get_products.dart';
import 'pos_event.dart';
import 'pos_state.dart';

/// Manages the POS product catalog screen state.
///
/// Loads categories and active products and applies search/category
/// filters locally.
class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc({
    required GetCategories getCategories,
    required GetProducts getProducts,
  }) : _getCategories = getCategories,
       _getProducts = getProducts,
       super(const PosInitial()) {
    on<LoadPosCatalog>(_onLoadPosCatalog);
    on<SearchPosProducts>(_onSearchPosProducts);
    on<SelectPosCategory>(_onSelectPosCategory);
  }

  final GetCategories _getCategories;
  final GetProducts _getProducts;

  Future<void> _onLoadPosCatalog(
    LoadPosCatalog event,
    Emitter<PosState> emit,
  ) async {
    emit(const PosLoading());
    try {
      final categories = await _getCategories();
      final products = await _getProducts();
      final activeProducts = products.where((p) => p.isActive).toList();
      emit(
        PosLoaded(
          categories: categories,
          products: activeProducts,
          filteredProducts: activeProducts,
        ),
      );
    } on Failure catch (e) {
      emit(PosError(e.message));
    } catch (e) {
      emit(PosError('Unexpected error: $e'));
    }
  }

  void _onSearchPosProducts(SearchPosProducts event, Emitter<PosState> emit) {
    final currentState = state;
    if (currentState is! PosLoaded) return;

    final query = event.query.trim().toLowerCase();
    final categoryId = currentState.selectedCategoryId;

    final filtered = _filter(
      currentState.products,
      query: query,
      categoryId: categoryId,
    );

    emit(
      currentState.copyWith(
        filteredProducts: filtered,
        searchQuery: event.query,
      ),
    );
  }

  void _onSelectPosCategory(SelectPosCategory event, Emitter<PosState> emit) {
    final currentState = state;
    if (currentState is! PosLoaded) return;

    final filtered = _filter(
      currentState.products,
      query: currentState.searchQuery.trim().toLowerCase(),
      categoryId: event.categoryId,
    );

    emit(
      currentState.copyWith(
        filteredProducts: filtered,
        selectedCategoryId: event.categoryId,
      ),
    );
  }

  List<ProductEntity> _filter(
    List<ProductEntity> products, {
    required String query,
    required String? categoryId,
  }) {
    var filtered = products;
    if (categoryId != null && categoryId.isNotEmpty) {
      filtered = filtered.where((p) => p.categoryId == categoryId).toList();
    }
    if (query.isNotEmpty) {
      filtered = filtered
          .where(
            (p) =>
                p.name.toLowerCase().contains(query) ||
                p.barcode.toLowerCase().contains(query),
          )
          .toList();
    }
    return filtered;
  }
}
