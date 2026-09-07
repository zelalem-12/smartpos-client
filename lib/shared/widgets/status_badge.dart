import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// A small colored badge for displaying status (SYNCED, PENDING, FAILED, etc).
class StatusBadge extends StatelessWidget {
  final String label;
  final StatusType type;

  const StatusBadge({
    super.key,
    required this.label,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color get _backgroundColor {
    return switch (type) {
      StatusType.success => AppColors.syncCompleted.withValues(alpha: 0.15),
      StatusType.pending => AppColors.syncPending.withValues(alpha: 0.15),
      StatusType.error => AppColors.syncFailed.withValues(alpha: 0.15),
      StatusType.info => AppColors.info.withValues(alpha: 0.15),
      StatusType.neutral => AppColors.offline.withValues(alpha: 0.15),
    };
  }

  Color get _textColor {
    return switch (type) {
      StatusType.success => AppColors.syncCompleted,
      StatusType.pending => AppColors.syncPending,
      StatusType.error => AppColors.syncFailed,
      StatusType.info => AppColors.info,
      StatusType.neutral => AppColors.offline,
    };
  }
}

enum StatusType { success, pending, error, info, neutral }
