import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../../../shared/widgets/app_choice_chip.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/empty_view.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../catalog/domain/entities/category_entity.dart';
import '../../../catalog/domain/entities/product_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../bloc/pos_bloc.dart';
import '../bloc/pos_event.dart';
import '../bloc/pos_state.dart';
import '../widgets/cart_panel.dart';
import '../widgets/pos_product_card.dart';

/// Main POS sale screen.
///
/// Displays a searchable product grid with category filters and a cart. On
/// tablet-sized screens the cart is shown in a permanent split view; on
/// narrow handsets it is accessible via a bottom sheet.
///
/// Expects [PosBloc] and [CartBloc] to be provided above this widget (by the
/// router or a parent BlocProvider in tests).
class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = !ResponsiveLayout.isMobile(context);

    return AuthRouteBackHandler(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppAppBar(
          title: 'New Sale',
          actions: const [_CurrentUserBadge(), _LogoutButton()],
        ),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: isWide ? 3 : 1,
                child: const _ProductCatalogPane(),
              ),
              if (isWide) const Expanded(flex: 2, child: _CartPane()),
            ],
          ),
        ),
        bottomNavigationBar: isWide ? null : const _MobileCartActionBar(),
      ),
    );
  }
}

class _CurrentUserBadge extends StatelessWidget {
  const _CurrentUserBadge();

  @override
  Widget build(BuildContext context) {
    final session = sl<SessionService>().currentSession;
    if (session == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Center(
        child: Text(
          session.name,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout, color: AppColors.textSecondary),
      tooltip: 'Log out',
      onPressed: () {
        sl<SessionService>().clear();
        context.go(AppRoutes.login);
      },
    );
  }
}

class _ProductCatalogPane extends StatefulWidget {
  const _ProductCatalogPane();

  @override
  State<_ProductCatalogPane> createState() => _ProductCatalogPaneState();
}

class _ProductCatalogPaneState extends State<_ProductCatalogPane> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    context.read<PosBloc>().add(SearchPosProducts(value));
  }

  void _onCategorySelected(String? categoryId) {
    context.read<PosBloc>().add(SelectPosCategory(categoryId));
  }

  void _onProductTapped(ProductEntity product) {
    context.read<CartBloc>().add(AddToCart(product));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                key: const ValueKey('posSearchField'),
                hint: 'Search products',
                controller: _searchController,
                prefixIcon: const Icon(Icons.search),
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: 12),
              _CategoryFilter(onSelected: _onCategorySelected),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<PosBloc, PosState>(
            builder: (context, state) {
              if (state is PosInitial || state is PosLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PosError) {
                return ErrorView(
                  message: state.message,
                  onRetry: () =>
                      context.read<PosBloc>().add(const LoadPosCatalog()),
                );
              }
              if (state is PosLoaded) {
                return _buildProductGrid(context, state);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(BuildContext context, PosLoaded state) {
    if (state.filteredProducts.isEmpty) {
      return EmptyView(
        icon: Icons.search_off_outlined,
        message: 'No products found',
        hint: 'Pull to refresh or tap Retry to reload the catalog.',
        actionLabel: 'Retry',
        onAction: () => context.read<PosBloc>().add(const LoadPosCatalog()),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 500 ? 3 : 2;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.85,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: state.filteredProducts.length,
          itemBuilder: (context, index) {
            final product = state.filteredProducts[index];
            final categoryIndex = state.categories.indexWhere(
              (c) => c.id == product.categoryId,
            );
            final categoryName = categoryIndex >= 0
                ? state.categories[categoryIndex].name
                : null;
            return PosProductCard(
              key: ValueKey('productCard-${product.id}'),
              product: product,
              categoryName: categoryName,
              onTap: () => _onProductTapped(product),
            );
          },
        );
      },
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  final ValueChanged<String?> onSelected;

  const _CategoryFilter({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<PosBloc, PosState>(
        buildWhen: (previous, current) =>
            current is PosLoaded || previous is PosLoaded,
        builder: (context, state) {
          final categories = state is PosLoaded
              ? state.categories
              : const <CategoryEntity>[];
          final selectedId = state is PosLoaded
              ? state.selectedCategoryId
              : null;

          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              AppChoiceChip(
                label: 'All',
                selected: selectedId == null,
                onSelected: (_) => onSelected(null),
              ),
              const SizedBox(width: 8),
              ...categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AppChoiceChip(
                    label: category.name,
                    selected: selectedId == category.id,
                    onSelected: (_) => onSelected(category.id),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class _CartPane extends StatelessWidget {
  const _CartPane();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = state is CartLoaded ? state.cart : const CartEntity();
        return CartPanel(
          cart: cart,
          onQuantityChanged: (productId, quantity) {
            context.read<CartBloc>().add(
              UpdateQuantity(productId: productId, quantity: quantity),
            );
          },
          onRemove: (productId) {
            context.read<CartBloc>().add(RemoveFromCart(productId));
          },
          onClear: () {
            context.read<CartBloc>().add(const ClearCartEvent());
          },
          onCharge: () => GoRouter.of(context).push(AppRoutes.checkout),
        );
      },
    );
  }
}

class _MobileCartActionBar extends StatelessWidget {
  const _MobileCartActionBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = state is CartLoaded ? state.cart : const CartEntity();
        final itemCount = cart.itemCount;

        return BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$itemCount item${itemCount == 1 ? '' : 's'}',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                    Text(
                      '${cart.grossTotal.toStringAsFixed(2)} ETB',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(0, 52)),
                onPressed: cart.isEmpty ? null : () => _openCartSheet(context),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('View Cart'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openCartSheet(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => BlocProvider.value(
        value: cartBloc,
        child: _CartBottomSheet(
          onCharge: () {
            Navigator.of(sheetContext).pop();
            GoRouter.of(context).push(AppRoutes.checkout);
          },
        ),
      ),
    );
  }
}

class _CartBottomSheet extends StatelessWidget {
  final VoidCallback onCharge;

  const _CartBottomSheet({required this.onCharge});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets;

    return Padding(
      padding: EdgeInsets.only(bottom: padding.bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cart = state is CartLoaded
                  ? state.cart
                  : const CartEntity();
              return CartPanel(
                cart: cart,
                onQuantityChanged: (productId, quantity) {
                  context.read<CartBloc>().add(
                    UpdateQuantity(productId: productId, quantity: quantity),
                  );
                },
                onRemove: (productId) {
                  context.read<CartBloc>().add(RemoveFromCart(productId));
                },
                onClear: () {
                  context.read<CartBloc>().add(const ClearCartEvent());
                },
                onCharge: onCharge,
              );
            },
          );
        },
      ),
    );
  }
}
