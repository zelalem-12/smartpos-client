import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/error_message.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';
import '../../domain/usecases/toggle_product_active.dart';
import '../../domain/usecases/update_product.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

/// Manages the catalog management screen state.
///
/// Handles loading, searching, filtering, adding, updating and toggling
/// product active status.
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final GetCategories _getCategories;
  final GetProducts _getProducts;
  final SearchProducts _searchProducts;
  final AddProduct _addProduct;
  final UpdateProduct _updateProduct;
  final ToggleProductActive _toggleProductActive;

  CatalogBloc(
    this._getCategories,
    this._getProducts,
    this._searchProducts,
    this._addProduct,
    this._updateProduct,
    this._toggleProductActive,
  ) : super(const CatalogInitial()) {
    on<LoadCatalog>(_onLoadCatalog);
    on<SearchCatalog>(_onSearchCatalog);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<ToggleProductActiveEvent>(_onToggleProductActive);
  }

  Future<void> _onLoadCatalog(
    LoadCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogLoading());
    try {
      final categories = await _getCategories();
      final products = await _getProducts();
      emit(
        CatalogLoaded(
          categories: categories,
          products: products,
          filteredProducts: products,
        ),
      );
    } on Failure catch (e) {
      emit(CatalogError(e.message));
    } catch (e) {
      emit(CatalogError(sanitizeErrorMessage(e)));
    }
  }

  Future<void> _onSearchCatalog(
    SearchCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CatalogLoaded) return;

    try {
      final products = await _getProducts();
      var filteredProducts = products;

      if (event.query.trim().isNotEmpty) {
        final searchResults = await _searchProducts(event.query.trim());
        filteredProducts = searchResults;
      }

      if (event.categoryId != null && event.categoryId!.isNotEmpty) {
        filteredProducts = filteredProducts
            .where((p) => p.categoryId == event.categoryId)
            .toList();
      }

      emit(
        currentState.copyWith(
          products: products,
          filteredProducts: filteredProducts,
          searchQuery: event.query,
          selectedCategoryId: event.categoryId,
        ),
      );
    } on Failure catch (e) {
      emit(CatalogError(e.message));
    } catch (e) {
      emit(CatalogError(sanitizeErrorMessage(e)));
    }
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogLoading());
    try {
      await _addProduct(
        categoryId: event.product.categoryId,
        name: event.product.name,
        description: event.product.description,
        barcode: event.product.barcode,
        price: event.product.price,
        cost: event.product.cost,
        stockQuantity: event.product.stockQuantity,
        unit: event.product.unit,
        vatRate: event.product.vatRate,
      );
      add(const LoadCatalog());
    } on Failure catch (e) {
      emit(CatalogError(e.message));
    } catch (e) {
      emit(CatalogError(sanitizeErrorMessage(e)));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogLoading());
    try {
      await _updateProduct(event.product);
      add(const LoadCatalog());
    } on Failure catch (e) {
      emit(CatalogError(e.message));
    } catch (e) {
      emit(CatalogError(sanitizeErrorMessage(e)));
    }
  }

  Future<void> _onToggleProductActive(
    ToggleProductActiveEvent event,
    Emitter<CatalogState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CatalogLoaded) return;

    emit(const CatalogLoading());
    try {
      await _toggleProductActive(event.productId);
      add(const LoadCatalog());
    } on Failure catch (e) {
      emit(CatalogError(e.message));
    } catch (e) {
      emit(CatalogError(sanitizeErrorMessage(e)));
    }
  }
}
