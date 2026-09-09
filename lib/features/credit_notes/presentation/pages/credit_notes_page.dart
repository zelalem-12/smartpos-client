import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/navigation/auth_route_back_handler.dart';
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
      appBar: AppBar(title: const Text('Credit Notes')),
      body: BlocBuilder<CreditNoteCubit, CreditNoteState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final invoice = state.invoice;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                key: const Key('creditInvoiceSearch'),
                controller: search,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Invoice number',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () =>
                        context.read<CreditNoteCubit>().search(search.text),
                  ),
                ),
                onSubmitted: context.read<CreditNoteCubit>().search,
              ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                Text(
                  state.error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<CreditNoteCubit>().search(search.text),
                  child: const Text('Retry'),
                ),
              ],
              if (invoice != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Invoice #${invoice.number}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text('Gross: ${invoice.grossTotal.toStringAsFixed(2)} ETB'),
                for (final item in invoice.items)
                  ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      'Remaining: ${item.remainingQuantity.toStringAsFixed(2)}',
                    ),
                    trailing: SizedBox(
                      width: 100,
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
                TextField(
                  key: const Key('creditReason'),
                  controller: reason,
                  decoration: const InputDecoration(labelText: 'Return reason'),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () =>
                      context.read<CreditNoteCubit>().submit(reason.text),
                  child: const Text('Create Credit Note'),
                ),
              ],
              if (state.result != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Credit note #${state.result!.number} created successfully',
                ),
                Text(
                  'Credit total: ${state.result!.grossTotal.toStringAsFixed(2)} ETB',
                ),
              ],
            ],
          );
        },
      ),
    ),
  );
}
