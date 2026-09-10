import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';

/// A navigation shell that provides a [BottomNavigationBar] on mobile and a
/// [NavigationRail] on tablet/desktop, wrapping the manager's primary
/// sections (Sale, Catalog, Reports, Settings, More).
///
/// The shell uses a [StatefulShellRoute] so each branch keeps its own
/// navigation state when switching tabs.
class AppNavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppNavShell({super.key, required this.navigationShell});

  static const _destinations = [
    _NavDestination(
      label: 'Sale',
      icon: Icons.point_of_sale_rounded,
      route: AppRoutes.manager,
    ),
    _NavDestination(
      label: 'Catalog',
      icon: Icons.menu_book_outlined,
      route: AppRoutes.catalog,
    ),
    _NavDestination(
      label: 'Reports',
      icon: Icons.bar_chart_outlined,
      route: AppRoutes.reports,
    ),
    _NavDestination(
      label: 'Settings',
      icon: Icons.settings_outlined,
      route: AppRoutes.settings,
    ),
  ];

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    if (isWide) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              backgroundColor: AppColors.surface,
              selectedIconTheme: const IconThemeData(color: AppColors.accent),
              selectedLabelTextStyle: const TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
              unselectedIconTheme: const IconThemeData(
                color: AppColors.textSecondary,
              ),
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.accent.withValues(alpha: 0.12),
        destinations: [
          for (final d in _destinations)
            NavigationDestination(icon: Icon(d.icon), label: d.label),
        ],
      ),
    );
  }
}

class _NavDestination {
  final String label;
  final IconData icon;
  final String route;

  const _NavDestination({
    required this.label,
    required this.icon,
    required this.route,
  });
}
