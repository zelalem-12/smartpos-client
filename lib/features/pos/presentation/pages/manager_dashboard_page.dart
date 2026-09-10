import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_app_bar.dart';

/// Manager dashboard shown at [AppRoutes.manager].
///
/// Displays the authenticated user, a welcome card, and a grid of
/// action buttons for sales, catalog, reports, settings, etc.
class ManagerDashboardPage extends StatelessWidget {
  const ManagerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final session = sl<SessionService>().currentSession;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppAppBar(
        title: AppConstants.appName,
        actions: [
          if (session != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  session.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textSecondary),
            tooltip: 'Log out',
            onPressed: () {
              sl<SessionService>().clear();
              context.go(AppRoutes.login);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(context, session),
              const SizedBox(height: 24),
              _buildActionGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, Session? session) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.point_of_sale_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${session?.name ?? 'User'}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    session?.role ?? 'Staff',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    final sessionService = sl<SessionService>();
    // Primary sections (Sale, Catalog, Reports, Settings) are in the nav
    // shell. The grid only shows secondary/management actions.
    final actions = [
      _Action('New Sale', Icons.shopping_cart_outlined, AppRoutes.pos),
      _Action('Sync Queue', Icons.sync_outlined, AppRoutes.syncQueue),
      _Action('Audit Trail', Icons.verified_user_outlined, AppRoutes.audit),
      _Action('Credit Notes', Icons.note_alt_outlined, AppRoutes.creditNotes),
      _Action(
        'Invoice Cancellation',
        Icons.cancel_outlined,
        AppRoutes.cancellation,
      ),
    ].where((action) => sessionService.canAccess(action.route)).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Adapt column count to available width:
        //  - < 600 (mobile): 2 columns
        //  - 600–899 (tablet): 3 columns
        //  - >= 900 (desktop): 4 columns
        final crossAxisCount = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 600
            ? 3
            : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: actions.map((a) => _buildActionTile(context, a)).toList(),
        );
      },
    );
  }

  Widget _buildActionTile(BuildContext context, _Action action) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(action.route),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(action.icon, color: AppColors.accent, size: 32),
              const SizedBox(height: 12),
              Text(
                action.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Action {
  final String label;
  final IconData icon;
  final String route;

  const _Action(this.label, this.icon, this.route);
}
