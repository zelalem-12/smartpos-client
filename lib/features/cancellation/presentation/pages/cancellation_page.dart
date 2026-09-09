import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/navigation/auth_route_back_handler.dart';
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
      appBar: AppBar(title: const Text('Invoice Cancellation')),
      body: BlocBuilder<CancellationCubit, CancellationState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final invoice = state.invoice;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                key: const Key('cancellationInvoiceSearch'),
                controller: search,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Invoice number',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () =>
                        context.read<CancellationCubit>().search(search.text),
                  ),
                ),
                onSubmitted: context.read<CancellationCubit>().search,
              ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                Text(
                  state.error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<CancellationCubit>().search(search.text),
                  child: const Text('Retry'),
                ),
              ],
              if (invoice != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Invoice #${invoice.number}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text('Buyer TIN: ${invoice.buyerTin ?? 'Walk-in'}'),
                Text('Gross: ${invoice.grossTotal.toStringAsFixed(2)} ETB'),
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
                FilledButton(
                  onPressed: () =>
                      context.read<CancellationCubit>().submit(reason),
                  child: const Text('Request Cancellation'),
                ),
              ],
              if (state.success)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Cancellation request submitted successfully'),
                ),
            ],
          );
        },
      ),
    ),
  );
}
