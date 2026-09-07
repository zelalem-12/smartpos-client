import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/store_config_entity.dart';

/// Displays activation success with store configuration summary.
class ActivationProgress extends StatelessWidget {
  final StoreConfigEntity storeConfig;

  const ActivationProgress({
    super.key,
    required this.storeConfig,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Device Activated',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _configRow(context, 'Business', storeConfig.businessName),
            _configRow(context, 'Trade Name', storeConfig.tradeName),
            _configRow(context, 'TIN', storeConfig.tin),
            _configRow(context, 'VAT Reg. No.', storeConfig.vatRegNo),
            _configRow(context, 'Sector', storeConfig.sector),
            _configRow(context, 'Address', storeConfig.address),
            _configRow(context, 'Device S/N', storeConfig.deviceSerial),
          ],
        ),
      ),
    );
  }

  Widget _configRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
