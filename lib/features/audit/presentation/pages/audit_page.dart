import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../../../../shared/widgets/app_app_bar.dart';
import '../../../../shared/widgets/empty_view.dart';
import '../../domain/entities/audit_log_entry.dart';
import '../cubit/audit_cubit.dart';
import '../cubit/audit_state.dart';

/// Audit trail page showing the chronological, tamper-evident operation log.
///
/// Supports chain verification, detail inspection, and CSV/JSON export.
class AuditPage extends StatelessWidget {
  final AuditCubit? cubit;
  const AuditPage({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    final injected = cubit;
    if (injected != null) {
      return BlocProvider.value(value: injected, child: const _AuditView());
    }
    return BlocProvider(
      create: (_) => sl<AuditCubit>()..load(),
      child: const _AuditView(),
    );
  }
}

class _AuditView extends StatelessWidget {
  const _AuditView();

  @override
  Widget build(BuildContext context) {
    return AuthRouteBackHandler(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppAppBar(
          title: 'Audit Trail',
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => context.read<AuditCubit>().refresh(),
            ),
          ],
        ),
        body: BlocConsumer<AuditCubit, AuditState>(
          listener: (context, state) {
            if (state.exportPath != null) {
              context.showSnackBar('Exported to ${state.exportPath}');
            } else if (state.exportError != null) {
              context.showSnackBar(
                'Export failed: ${state.exportError}',
                isError: true,
              );
            }
          },
          builder: (context, state) {
            if (state.loading && state.entries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: Column(
                children: [
                  _ChainStatus(state: state),
                  _ExportBar(state: state),
                  Expanded(
                    child: state.entries.isEmpty
                        ? const _EmptyTrail()
                        : _AuditList(entries: state.entries),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ChainStatus extends StatelessWidget {
  final AuditState state;
  const _ChainStatus({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.entries.isEmpty) return const SizedBox.shrink();

    Color color;
    IconData icon;
    String message;

    if (state.hasTamperedEntry) {
      color = AppColors.error;
      icon = Icons.gpp_bad;
      message = 'Audit chain broken. Tampering detected.';
    } else if (state.hasUnverifiableEntry) {
      color = AppColors.warning;
      icon = Icons.warning_amber_rounded;
      message = 'Audit chain contains legacy records that cannot be verified.';
    } else {
      color = AppColors.success;
      icon = Icons.verified_user;
      message = 'Audit chain verified.';
    }

    return MaterialBanner(
      backgroundColor: color.withValues(alpha: .12),
      leading: Icon(icon, color: color),
      content: Text(message, style: TextStyle(color: color)),
      actions: [
        TextButton(
          onPressed: () => context.read<AuditCubit>().refresh(),
          child: Text('VERIFY', style: TextStyle(color: color)),
        ),
      ],
    );
  }
}

class _ExportBar extends StatelessWidget {
  final AuditState state;
  const _ExportBar({required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: state.loading
                  ? const SizedBox()
                  : const Icon(Icons.download),
              label: state.loading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Export CSV'),
              onPressed: state.loading
                  ? null
                  : () => context.read<AuditCubit>().exportCsv(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              icon: state.loading ? const SizedBox() : const Icon(Icons.code),
              label: state.loading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Export JSON'),
              onPressed: state.loading
                  ? null
                  : () => context.read<AuditCubit>().exportJson(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTrail extends StatelessWidget {
  const _EmptyTrail();

  @override
  Widget build(BuildContext context) {
    return const EmptyView(
      icon: Icons.history_outlined,
      message: 'No audit records found',
      hint: 'Operations will appear here as they are logged.',
    );
  }
}

class _AuditList extends StatelessWidget {
  final List<AuditLogEntry> entries;
  const _AuditList({required this.entries});

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
            leading: _IntegrityIcon(status: entry.integrityStatus),
            title: Text(entry.action),
            subtitle: Text(
              '${_format(entry.createdAt)} · ${entry.userId}\n'
              'Hash: ${_truncate(entry.currentHash)}',
              maxLines: 3,
            ),
            isThreeLine: true,
            onTap: () => _showDetail(context, entry),
          ),
        );
      },
    );
  }

  static String _format(DateTime dt) =>
      DateFormat('MMM d, y HH:mm:ss').format(dt);

  static String _truncate(String hash) =>
      hash.isEmpty ? '-' : '${hash.substring(0, hash.length.clamp(0, 16))}...';

  static void _showDetail(BuildContext context, AuditLogEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entry.action),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DetailRow('User', entry.userId),
              _DetailRow('Invoice', entry.invoiceId?.toString() ?? '—'),
              _DetailRow('Time', _format(entry.createdAt)),
              _DetailRow('Details', entry.details),
              _DetailRow('Payload', entry.payload ?? '—'),
              _DetailRow('Previous Hash', entry.previousHash),
              _DetailRow('Current Hash', entry.currentHash),
              _DetailRow('Integrity', entry.integrityStatus.name),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SelectableText.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}

class _IntegrityIcon extends StatelessWidget {
  final AuditIntegrityStatus status;
  const _IntegrityIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AuditIntegrityStatus.valid:
        return const Icon(Icons.verified, color: AppColors.success);
      case AuditIntegrityStatus.unverifiable:
        return const Icon(Icons.help_outline, color: AppColors.warning);
      case AuditIntegrityStatus.tampered:
        return const Icon(Icons.warning_amber_rounded, color: AppColors.error);
    }
  }
}
