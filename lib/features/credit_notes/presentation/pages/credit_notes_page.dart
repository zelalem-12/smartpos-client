import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/error_view.dart';
import '../cubit/credit_note_cubit.dart';

class CreditNotesPage extends StatefulWidget {
  const CreditNotesPage({super.key});
  @override
  State<CreditNotesPage> createState() => _CreditNotesPageState();
}

class _CreditNotesPageState extends State<CreditNotesPage> {
  final search = TextEditingController();
  final reason = TextEditingController();
  @override
  void dispose() {
    search.dispose();
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthRouteBackHandler(
    child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(title: 'Credit Notes'),
      body: BlocBuilder<CreditNoteCubit, CreditNoteState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final invoice = state.invoice;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppTextField(
                label: 'Invoice number',
                hint: 'Enter invoice number',
                controller: search,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.search,
                onSubmitted: context.read<CreditNoteCubit>().search,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () =>
                      context.read<CreditNoteCubit>().search(search.text),
                ),
              ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                ErrorView(
                  message: state.error!,
                  onRetry: () =>
                      context.read<CreditNoteCubit>().search(search.text),
                ),
              ],
              if (invoice != null) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invoice #${invoice.number}',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Gross: ${CurrencyFormatter.format(invoice.grossTotal)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
                for (final item in invoice.items)
                  ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      'Remaining: ${item.remainingQuantity.toStringAsFixed(2)}',
                    ),
                    trailing: SizedBox(
                      width: 120,
                      child: TextFormField(
                        key: Key('returnQty${item.id}'),
                        initialValue: (state.quantities[item.id] ?? 0)
                            .toString(),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (v) => context
                            .read<CreditNoteCubit>()
                            .setQuantity(item.id, double.tryParse(v) ?? 0),
                      ),
                    ),
                  ),
                AppTextField(
                  label: 'Return reason',
                  hint: 'Reason for the credit note',
                  controller: reason,
                ),
                const SizedBox(height: 16),
                AppButton(
                  label: 'Create Credit Note',
                  icon: Icons.note_add_outlined,
                  onPressed: () =>
                      context.read<CreditNoteCubit>().submit(reason.text),
                ),
              ],
              if (state.result != null) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Credit note #${state.result!.number} created successfully',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Credit total: ${CurrencyFormatter.format(state.result!.grossTotal)}',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppColors.success),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    ),
  );
}
