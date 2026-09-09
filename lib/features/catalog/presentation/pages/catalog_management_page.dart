import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../../../shared/widgets/empty_view.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/catalog_bloc.dart';
import '../bloc/catalog_event.dart';
import '../bloc/catalog_state.dart';
import '../widgets/product_dialog.dart';

/// Manager-only catalog management page.
///
/// Lists products with search and category filtering, and allows
/// adding, editing and toggling the active status of products.
///
/// Expects a [CatalogBloc] to be provided above this widget (by the router
/// or a parent BlocProvider in tests).
class CatalogManagementPage extends StatefulWidget {
  const CatalogManagementPage({super.key});

  @override
  State<CatalogManagementPage> createState() => _CatalogManagementPageState();
}

class _CatalogManagementPageState extends State<CatalogManagementPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(CatalogBloc bloc) {
    final query = _searchController.text;
    final currentState = bloc.state;
    String? categoryId;
    if (currentState is CatalogLoaded) {
      categoryId = currentState.selectedCategoryId;
    }
    bloc.add(SearchCatalog(query: query, categoryId: categoryId));
  }

  void _onCategorySelected(CatalogBloc bloc, String? categoryId) {
    final query = _searchController.text;
    bloc.add(SearchCatalog(query: query, categoryId: categoryId));
  }

  Future<void> _showProductDialog({ProductEntity? product}) async {
    final bloc = context.read<CatalogBloc>();
    final currentState = bloc.state;
    if (currentState is! CatalogLoaded) return;

    final result = await showDialog<ProductEntity>(
      context: context,
      builder: (_) =>
          ProductDialog(categories: currentState.categories, product: product),
    );

    if (result == null) return;

    if (product != null) {
      bloc.add(UpdateProductEvent(result));
    } else {
      bloc.add(AddProductEvent(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CatalogBloc>();

    return AuthRouteBackHandler(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AppAppBar(title: 'Catalog Management'),
        body: BlocConsumer<CatalogBloc, CatalogState>(
          listener: (context, state) {
            if (state is CatalogError) {
              context.showSnackBar(state.message, isError: true);
            }
          },
          builder: (context, state) {
            if (state is CatalogInitial || state is CatalogLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CatalogError) {
              return ErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<CatalogBloc>().add(const LoadCatalog()),
              );
            }

            if (state is CatalogLoaded) {
              return _buildBody(context, state, bloc);
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.accent,
          onPressed: () => _showProductDialog(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    CatalogLoaded state,
    CatalogBloc bloc,
  ) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (_) => _onSearchChanged(bloc),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by name or barcode',
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ChoiceChip(
                        label: const Text('All'),
                        selected: state.selectedCategoryId == null,
                        onSelected: (_) => _onCategorySelected(bloc, null),
                      ),
                      const SizedBox(width: 8),
                      ...state.categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(category.name),
                            selected: state.selectedCategoryId == category.id,
                            onSelected: (_) =>
                                _onCategorySelected(bloc, category.id),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${state.filteredProducts.length} products',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: state.filteredProducts.isEmpty
                ? const EmptyView(
                    icon: Icons.search_off_outlined,
                    message: 'No products found',
                    hint: 'Try a different search or add a new product.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filteredProducts.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final product = state.filteredProducts[index];
                      return _ProductCard(
                        product: product,
                        categoryName: state.categories
                            .firstWhere(
                              (c) => c.id == product.categoryId,
                              orElse: () => state.categories.first,
                            )
                            .name,
                        onEdit: () => _showProductDialog(product: product),
                        onToggleActive: () =>
                            bloc.add(ToggleProductActiveEvent(product.id)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductEntity product;
  final String categoryName;
  final VoidCallback onEdit;
  final VoidCallback onToggleActive;

  const _ProductCard({
    required this.product,
    required this.categoryName,
    required this.onEdit,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          product.name,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$categoryName · ${product.barcode}'),
            const SizedBox(height: 4),
            Text(
              '${product.priceLabel} ETB · Stock: ${product.stockQuantity.toStringAsFixed(2)} ${product.unit}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.isActive ? 'Active' : 'Inactive',
              style: theme.textTheme.bodySmall?.copyWith(
                color: product.isActive
                    ? AppColors.success
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: product.isActive,
              onChanged: (_) => onToggleActive(),
              activeThumbColor: AppColors.accent,
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.textSecondary),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
