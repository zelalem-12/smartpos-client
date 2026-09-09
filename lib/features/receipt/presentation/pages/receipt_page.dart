import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/receipt_data.dart';
import '../cubit/receipt_cubit.dart';
import '../cubit/receipt_state.dart';
import '../widgets/receipt_widget.dart';

/// Receipt preview and print screen for a completed sale.
class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthRouteBackHandler(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textSecondary),
            onPressed: () => context.safePop(),
            tooltip: 'Back',
          ),
          title: const Text('Receipt'),
        ),
        body: SafeArea(
          child: BlocConsumer<ReceiptCubit, ReceiptState>(
            listener: _handleSideEffects,
            builder: _buildBody,
          ),
        ),
      ),
    );
  }

  void _handleSideEffects(BuildContext context, ReceiptState state) {
    if (state is ReceiptError && state.receipt != null) {
      context.showSnackBar(state.message, isError: true);
    }
  }

  Widget _buildBody(BuildContext context, ReceiptState state) {
    if (state is ReceiptLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ReceiptError && state.receipt == null) {
      return _buildError(context, state.message);
    }

    final receipt = _receiptFor(state);
    if (receipt == null) {
      return _buildError(context, 'Receipt could not be loaded.');
    }

    final isDuplicate = _isDuplicate(state);
    final isPrinting = state is ReceiptPrinting;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state is ReceiptError) _buildErrorBanner(context, state.message),
          ReceiptWidget(receipt: receipt, isDuplicate: isDuplicate),
          const SizedBox(height: 24),
          if (isPrinting)
            const Center(child: CircularProgressIndicator())
          else
            _buildActions(context, state),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Back to POS',
              icon: Icons.arrow_back,
              onPressed: () => context.go(AppRoutes.pos),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorBanner(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: AppColors.error, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildActions(BuildContext context, ReceiptState state) {
    final cubit = context.read<ReceiptCubit>();
    final printed = state is ReceiptPrinted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (printed)
          AppButton(
            key: const ValueKey('reprintButton'),
            label: 'Reprint (Duplicate)',
            icon: Icons.print,
            backgroundColor: AppColors.warning,
            onPressed: cubit.reprint,
          ),
        if (!printed)
          AppButton(
            key: const ValueKey('printButton'),
            label: 'Print',
            icon: Icons.print,
            onPressed: cubit.printReceipt,
          ),
        const SizedBox(height: 12),
        AppButton(
          key: const ValueKey('newSaleButton'),
          label: 'New Sale',
          icon: Icons.shopping_cart,
          backgroundColor: AppColors.primary,
          onPressed: () async {
            await cubit.newSale();
            if (context.mounted) {
              context.go(AppRoutes.pos);
            }
          },
        ),
      ],
    );
  }

  ReceiptData? _receiptFor(ReceiptState state) {
    if (state is ReceiptReady) return state.receipt;
    if (state is ReceiptPrinting) return state.receipt;
    if (state is ReceiptPrinted) return state.receipt;
    if (state is ReceiptError) return state.receipt;
    return null;
  }

  bool _isDuplicate(ReceiptState state) {
    if (state is ReceiptReady) return state.isDuplicate;
    if (state is ReceiptPrinting) return state.isDuplicate;
    if (state is ReceiptPrinted) return state.isDuplicate;
    return false;
  }
}
