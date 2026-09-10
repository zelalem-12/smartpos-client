import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/status_banner.dart';
import '../cubit/cancellation_cubit.dart';

class CancellationPage extends StatefulWidget {
  const CancellationPage({super.key});
  @override
  State<CancellationPage> createState() => _CancellationPageState();
}

class _CancellationPageState extends State<CancellationPage> {
  final search = TextEditingController();
  String reason = 'Duplicate';
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthRouteBackHandler(
    child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(title: 'Invoice Cancellation'),
      body: BlocBuilder<CancellationCubit, CancellationState>(
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
                onSubmitted: context.read<CancellationCubit>().search,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () =>
                      context.read<CancellationCubit>().search(search.text),
                ),
              ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                ErrorView(
                  message: state.error!,
                  onRetry: () =>
                      context.read<CancellationCubit>().search(search.text),
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
                          'Buyer TIN: ${invoice.buyerTin ?? 'Walk-in'}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
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
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  key: const Key('cancellationReason'),
                  initialValue: reason,
                  decoration: const InputDecoration(labelText: 'Reason'),
                  items:
                      const [
                            'Duplicate',
                            'Wrong Buyer TIN',
                            'Wrong Product',
                            'Other',
                          ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (v) => setState(() => reason = v!),
                ),
                const SizedBox(height: 16),
                AppButton(
                  label: 'Request Cancellation',
                  icon: Icons.cancel_outlined,
                  onPressed: () =>
                      context.read<CancellationCubit>().submit(reason),
                ),
              ],
              if (state.success) ...[
                const SizedBox(height: 16),
                const StatusBanner(
                  message: 'Cancellation request submitted successfully',
                  type: StatusBannerType.success,
                ),
              ],
            ],
          );
        },
      ),
    ),
  );
}
