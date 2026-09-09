import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/navigation/auth_route_back_handler.dart';
import '../cubit/cashier_management_cubit.dart';
import '../cubit/cashier_management_state.dart';
import '../widgets/create_cashier_dialog.dart';

/// Manager-only settings page.
///
/// Displays cashier management (list, create, activate/deactivate).
/// Access is enforced by [SessionService.canAccess]; this page also guards
/// against direct access attempts.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = sl<SessionService>();
    if (!session.isManager) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(session.homeRoute ?? AppRoutes.login);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return const AuthRouteBackHandler(child: _SettingsView());
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textSecondary),
          onPressed: () => context.safePop(),
          tooltip: 'Back',
        ),
        title: Text(
          'Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cashier Management',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Create and manage cashier accounts. Manager accounts are protected.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    BlocConsumer<
                      CashierManagementCubit,
                      CashierManagementState
                    >(
                      listener: (context, state) {
                        if (state is CashierManagementError) {
                          context.showSnackBar(state.message, isError: true);
                        }
                      },
                      builder: (context, state) {
                        if (state is CashierManagementInitial ||
                            state is CashierManagementLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is CashierManagementError &&
                            state is! CashierManagementLoaded) {
                          return _ErrorView(
                            message: state.message,
                            onRetry: () => context
                                .read<CashierManagementCubit>()
                                .loadUsers(),
                          );
                        }

                        final users = state is CashierManagementLoaded
                            ? state.users
                            : <User>[];

                        if (users.isEmpty) {
                          return const _EmptyView();
                        }

                        return _UserList(
                          users: users,
                          onToggle: (user) => context
                              .read<CashierManagementCubit>()
                              .toggleActive(user),
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const ValueKey('createCashierButton'),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        onPressed: () => _showCreateDialog(context),
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Create Cashier'),
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context) async {
    final result = await showDialog<CreateCashierResult>(
      context: context,
      builder: (_) => const CreateCashierDialog(),
    );

    if (result == null || !context.mounted) return;

    await context.read<CashierManagementCubit>().createCashier(
      username: result.username,
      fullName: result.fullName,
      password: result.password,
    );
  }
}

class _UserList extends StatelessWidget {
  final List<User> users;
  final ValueChanged<User> onToggle;

  const _UserList({required this.users, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final user = users[index];
        final isManager = user.role == 'MANAGER';

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isManager
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : AppColors.accent.withValues(alpha: 0.12),
              child: Icon(
                isManager ? Icons.manage_accounts_outlined : Icons.person,
                color: isManager ? AppColors.primary : AppColors.accent,
              ),
            ),
            title: Text(
              user.fullName,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('@${user.username} · ${user.role}'),
                const SizedBox(height: 2),
                Text(
                  user.isActive ? 'Active' : 'Inactive',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: user.isActive
                        ? AppColors.success
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            trailing: isManager
                ? null
                : TextButton(
                    onPressed: () => onToggle(user),
                    child: Text(user.isActive ? 'Deactivate' : 'Activate'),
                  ),
          ),
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_outline,
            size: 56,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'No active users found',
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap Create Cashier to add one.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
