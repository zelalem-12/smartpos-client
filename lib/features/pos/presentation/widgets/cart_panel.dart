import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/cart_entity.dart';
import 'cart_line_item.dart';

/// Right-side or bottom-sheet cart panel showing line items, totals and the
/// CHARGE action.
class CartPanel extends StatelessWidget {
  final CartEntity cart;
  final void Function(String productId, int quantity) onQuantityChanged;
  final ValueChanged<String> onRemove;
  final VoidCallback onClear;
  final VoidCallback? onCharge;

  const CartPanel({
    super.key,
    required this.cart,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onClear,
    this.onCharge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: AppColors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            const Divider(height: 1),
            Expanded(
              child: cart.isEmpty
                  ? Center(
                      child: Text(
                        'Your cart is empty',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return CartLineItem(
                          item: item,
                          onQuantityChanged: (quantity) =>
                              onQuantityChanged(item.product.id, quantity),
                          onRemove: () => onRemove(item.product.id),
                        );
                      },
                    ),
            ),
            const Divider(height: 1),
            _buildTotals(context),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  key: const ValueKey('chargeButton'),
                  onPressed: cart.isEmpty ? null : onCharge,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.accent.withValues(
                      alpha: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.payment_outlined),
                  label: Text(
                    'CHARGE ${CurrencyFormatter.format(cart.grossTotal)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Cart (${cart.itemCount} items)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: TextButton.icon(
              onPressed: cart.isEmpty ? null : onClear,
              icon: const Icon(Icons.delete_sweep_outlined, size: 20),
              label: const Text('Clear'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotals(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _TotalRow(
            label: 'Net total',
            value: CurrencyFormatter.format(cart.netTotal),
            style: theme.textTheme.bodyMedium,
          ),
          _TotalRow(
            label: 'VAT (15%)',
            value: CurrencyFormatter.format(cart.vatTotal),
            style: theme.textTheme.bodyMedium,
          ),
          const Divider(height: 16),
          _TotalRow(
            label: 'Grand total',
            value: CurrencyFormatter.format(cart.grossTotal),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? style;

  const _TotalRow({required this.label, required this.value, this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: style)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: style?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
