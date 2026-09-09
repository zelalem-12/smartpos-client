import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/phase9_requests.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/empty_view.dart';
import '../../../../shared/widgets/error_view.dart';
import '../cubit/reports_cubit.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});
  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final cash = TextEditingController();
  @override
  void dispose() {
    cash.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthRouteBackHandler(
    child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(title: 'X / Z Reports'),
      body: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state.loading && state.totals == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.totals == null) {
            return ErrorView(
              message: state.error!,
              onRetry: () => context.read<ReportsCubit>().load(),
            );
          }
          if (state.totals == null) {
            return const EmptyView(
              icon: Icons.bar_chart_outlined,
              message: 'No report data available',
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<ReportsCubit>().load(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (state.error != null) ...[
                  ErrorView(
                    message: state.error!,
                    onRetry: () => context.read<ReportsCubit>().load(),
                  ),
                  const SizedBox(height: 16),
                ],
                _Summary(state.totals!),
                const Divider(height: 32),
                AppTextField(
                  label: 'Physical cash count (ETB)',
                  hint: '0.00',
                  controller: cash,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  label: 'Close Z Report',
                  icon: Icons.task_alt_outlined,
                  onPressed: () =>
                      context.read<ReportsCubit>().closeDay(cash.text),
                ),
                if (state.zNumber != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Z report #${state.zNumber} closed successfully',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    ),
  );
}

class _Summary extends StatelessWidget {
  final ReportTotals totals;
  const _Summary(this.totals);
  Widget row(String name, num value) => ListTile(
    dense: true,
    title: Text(name),
    trailing: Text(value is int ? '$value' : '${value.toStringAsFixed(2)} ETB'),
  );
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'X Report',
        style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
      ),
      row('Invoices', totals.invoiceCount),
      row('Net sales', totals.netTotal),
      row('VAT', totals.vatTotal),
      row('Gross sales', totals.grossTotal),
      row('Credit notes', totals.creditGrossTotal),
      const Divider(),
      row('Cash', totals.cashTotal),
      row('Telebirr', totals.telebirrTotal),
      row('CBE Birr', totals.cbeBirrTotal),
    ],
  );
}
