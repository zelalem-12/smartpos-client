import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A reusable status banner for inline success or error messages.
///
/// Used in checkout, reports, credit notes, cancellation, manager setup,
/// and login to display a colored banner with an icon and message.
class StatusBanner extends StatelessWidget {
  final String message;
  final StatusBannerType type;

  const StatusBanner({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      StatusBannerType.success => AppColors.success,
      StatusBannerType.error => AppColors.error,
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            type == StatusBannerType.success
                ? Icons.check_circle_outline
                : Icons.error_outline,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: type == StatusBannerType.error
                    ? FontWeight.w500
                    : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The type of status to display in a [StatusBanner].
enum StatusBannerType { success, error }
