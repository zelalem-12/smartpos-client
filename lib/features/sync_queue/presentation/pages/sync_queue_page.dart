import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../domain/entities/sync_queue_entry.dart';
import '../cubit/sync_queue_cubit.dart';
import '../cubit/sync_queue_state.dart';

/// Functional sync queue page.
///
/// Lists every queue entry newest first, shows status summaries, exposes
/// per-entry retry and a Sync All action, and surfaces offline/disabled
/// states plus a 7-day downtime banner.
class SyncQueuePage extends StatelessWidget {
  final SyncQueueCubit? cubit;
  const SyncQueuePage({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    final injected = cubit;
    if (injected != null) {
      return BlocProvider.value(value: injected, child: const _SyncQueueView());
    }
    return BlocProvider(
      create: (_) => sl<SyncQueueCubit>()..load(),
      child: const _SyncQueueView(),
    );
  }
}

class _SyncQueueView extends StatelessWidget {
  const _SyncQueueView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthRouteBackHandler(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppAppBar(
          title: 'Sync Queue',
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => context.read<SyncQueueCubit>().load(),
            ),
          ],
        ),
        body: BlocConsumer<SyncQueueCubit, SyncQueueState>(
          listener: (context, state) {
            if (state.error != null) {
              context.showSnackBar(state.error!, isError: true);
            }
          },
          builder: (context, state) {
            if (state.loading && state.entries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: Column(
                children: [
                  if (!state.isOnline) _OfflineBanner(state: state),
                  if (state.showDowntimeAlert) _DowntimeBanner(state: state),
                  _StatusSummary(entries: state.entries),
                  Expanded(
                    child: state.entries.isEmpty
                        ? _EmptyQueue(theme: theme)
                        : _QueueList(entries: state.entries),
                  ),
                  _SyncAllBar(state: state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  final SyncQueueState state;
  const _OfflineBanner({required this.state});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      backgroundColor: AppColors.error,
      content: const Text(
        'Device is offline. Sync actions are disabled until connectivity is restored.',
        style: TextStyle(color: Colors.white),
      ),
      leading: const Icon(Icons.cloud_off, color: Colors.white),
      actions: [
        TextButton(
          onPressed: () =>
              context.read<SyncQueueCubit>().dismissOfflineMessage(),
          child: const Text('DISMISS', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class _DowntimeBanner extends StatelessWidget {
  final SyncQueueState state;
  const _DowntimeBanner({required this.state});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      backgroundColor: AppColors.warning,
      content: const Text(
        'An entry has been unsynced for 7 or more days. Please resolve connectivity and sync.',
        style: TextStyle(color: Colors.black87),
      ),
      leading: const Icon(Icons.warning_amber_rounded, color: Colors.black87),
      actions: [
        TextButton(
          onPressed: () => context.read<SyncQueueCubit>().load(),
          child: const Text('REFRESH', style: TextStyle(color: Colors.black87)),
        ),
      ],
    );
  }
}

class _StatusSummary extends StatelessWidget {
  final List<SyncQueueEntry> entries;
  const _StatusSummary({required this.entries});

  @override
  Widget build(BuildContext context) {
    final counts = <String, int>{};
    for (final e in entries) {
      counts[e.status] = (counts[e.status] ?? 0) + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _Chip(
            label: 'Total',
            count: entries.length,
            color: AppColors.textSecondary,
          ),
          _Chip(
            label: 'Pending',
            count: counts['PENDING'] ?? 0,
            color: AppColors.accent,
          ),
          _Chip(
            label: 'Failed',
            count: counts['FAILED'] ?? 0,
            color: AppColors.error,
          ),
          _Chip(
            label: 'Synced',
            count: counts['SYNCED'] ?? 0,
            color: AppColors.success,
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _Chip({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withValues(alpha: .12),
      side: BorderSide(color: color.withValues(alpha: .3)),
      label: Text(
        '$label: $count',
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _EmptyQueue extends StatelessWidget {
  final ThemeData theme;
  const _EmptyQueue({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No sync jobs queued.', style: theme.textTheme.bodyLarge),
    );
  }
}

class _QueueList extends StatelessWidget {
  final List<SyncQueueEntry> entries;
  const _QueueList({required this.entries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: _StatusIcon(status: entry.status),
            title: Text('${entry.operation} — Invoice #${entry.invoiceId}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Created: ${_format(entry.createdAt)}'),
                if (entry.lastAttemptAt != null)
                  Text('Last attempt: ${_format(entry.lastAttemptAt!)}'),
                if (entry.lastError != null)
                  Text(
                    'Error: ${entry.lastError}',
                    style: TextStyle(color: AppColors.error),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (entry.retryCount > 0) Text('Retries: ${entry.retryCount}'),
              ],
            ),
            trailing: entry.isActionable
                ? IconButton(
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Retry',
                    onPressed: () =>
                        context.read<SyncQueueCubit>().retry(entry.id),
                  )
                : null,
          ),
        );
      },
    );
  }

  static String _format(DateTime dt) => DateFormat('MMM d, HH:mm').format(dt);
}

class _StatusIcon extends StatelessWidget {
  final String status;
  const _StatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'SYNCED':
        return const Icon(Icons.check_circle, color: AppColors.success);
      case 'FAILED':
        return const Icon(Icons.error, color: AppColors.error);
      case 'PROCESSING':
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case 'PENDING':
      default:
        return const Icon(Icons.schedule, color: AppColors.accent);
    }
  }
}

class _SyncAllBar extends StatelessWidget {
  final SyncQueueState state;
  const _SyncAllBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final actionable = state.entries.where((e) => e.isActionable).length;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: state.loading ? const SizedBox() : const Icon(Icons.sync),
          label: state.loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('Sync All ($actionable)'),
          onPressed: !state.isOnline || actionable == 0 || state.loading
              ? null
              : () => context.read<SyncQueueCubit>().syncAll(),
        ),
      ),
    );
  }
}
