import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/phase9_requests.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
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
      appBar: AppBar(title: const Text('X / Z Reports')),
      body: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state.loading && state.totals == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () => context.read<ReportsCubit>().load(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (state.error != null) ...[
                  Text(
                    state.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.read<ReportsCubit>().load(),
                    child: const Text('Retry'),
                  ),
                ],
                if (state.totals != null) ...[
                  _Summary(state.totals!),
                  const Divider(height: 32),
                  TextField(
                    key: const Key('cashCount'),
                    controller: cash,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Physical cash count (ETB)',
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    key: const Key('closeZ'),
                    onPressed: () =>
                        context.read<ReportsCubit>().closeDay(cash.text),
                    child: const Text('Close Z Report'),
                  ),
                ],
                if (state.zNumber != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Z report #${state.zNumber} closed successfully',
                    ),
                  ),
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
      Text('X Report', style: Theme.of(context).textTheme.headlineSmall),
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
