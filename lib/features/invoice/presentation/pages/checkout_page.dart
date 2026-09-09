import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/entities/payment_method.dart';
import '../cubit/checkout_cubit.dart';
import '../cubit/checkout_state.dart';

/// Checkout screen: review cart totals, choose payment, tender cash, and
/// create the fiscal invoice.
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthRouteBackHandler(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AppAppBar(title: 'Checkout'),
        body: BlocListener<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutCompleted) {
              context.pushReplacement(
                '${AppRoutes.receipt}?invoiceId=${state.invoiceId}',
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoaded) {
                    return SingleChildScrollView(
                      child: _buildBody(context, state),
                    );
                  }
                  if (state is CheckoutCompleted) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Initial / unknown state: show a loading indicator
                  // instead of a blank screen.
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CheckoutLoaded state) {
    final cubit = context.read<CheckoutCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _OrderSummary(state: state),
        const SizedBox(height: 16),
        _PaymentMethodSelector(
          state: state,
          onChanged: cubit.selectPaymentMethod,
        ),
        if (state.paymentMethod.isCash) ...[
          const SizedBox(height: 16),
          AppTextField(
            key: const ValueKey('cashTenderedField'),
            label: 'Cash Tendered',
            hint: '0.00',
            controller: null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            textInputAction: TextInputAction.next,
            onChanged: cubit.updateCashTendered,
          ),
          const SizedBox(height: 12),
          _ChangeDisplay(change: state.change),
        ],
        const SizedBox(height: 16),
        AppTextField(
          key: const ValueKey('buyerTinField'),
          label: 'Buyer TIN (optional)',
          hint: '10-digit TIN',
          controller: null,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 10,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => cubit.confirmCheckout(),
          onChanged: cubit.updateBuyerTin,
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            state.errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: 24),
        AppButton(
          key: const ValueKey('confirmCheckoutButton'),
          label: 'Confirm Payment',
          isLoading: state.isProcessing,
          icon: Icons.check_circle_outline,
          onPressed: cubit.confirmCheckout,
        ),
      ],
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final CheckoutLoaded state;

  const _OrderSummary({required this.state});

  @override
  Widget build(BuildContext context) {
    final cart = state.cart;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            _SummaryRow(label: 'Net total', value: cart.netTotal),
            _SummaryRow(label: 'VAT (15%)', value: cart.vatTotal),
            const Divider(height: 24),
            _SummaryRow(
              label: 'Grand total',
              value: cart.grossTotal,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final TextStyle? style;

  const _SummaryRow({required this.label, required this.value, this.style});

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: effectiveStyle),
          Text(
            CurrencyFormatter.format(value),
            style: effectiveStyle?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodSelector extends StatelessWidget {
  final CheckoutLoaded state;
  final ValueChanged<PaymentMethod> onChanged;

  const _PaymentMethodSelector({required this.state, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: PaymentMethod.values.map((method) {
            return ChoiceChip(
              key: ValueKey('paymentMethod_${method.name}'),
              label: Text(method.label),
              selected: state.paymentMethod == method,
              onSelected: (_) => onChanged(method),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ChangeDisplay extends StatelessWidget {
  final double change;

  const _ChangeDisplay({required this.change});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Change',
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            CurrencyFormatter.format(change),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.accentDark,
            ),
          ),
        ],
      ),
    );
  }
}
