import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../extensions/context_extensions.dart';

/// Branded AppBar used across all authenticated screens for visual
/// consistency.
///
/// Applies [AppColors.background] with elevation 0, a styled title, and a
/// leading back button that calls [ContextExtensions.safePop] so system back
/// never exits the app from a sub-screen.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final Widget? leading;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading:
          leading ??
          (showBack
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => context.safePop(),
                  tooltip: 'Back',
                )
              : null),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge
            ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
