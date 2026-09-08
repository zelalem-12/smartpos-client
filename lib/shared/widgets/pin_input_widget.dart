import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// A row of PIN dots that fill as digits are entered.
///
/// Used on the PIN Login screen and Manager Setup PIN creation.
class PinInputWidget extends StatelessWidget {
  /// Number of digits entered so far.
  final int filledCount;

  /// Total PIN length (default: 4).
  final int pinLength;

  /// Whether to show an error state (red dots).
  final bool hasError;

  const PinInputWidget({
    super.key,
    required this.filledCount,
    this.pinLength = AppConstants.pinLength,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) {
        final isFilled = index < filledCount;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled
                ? (hasError ? AppColors.error : AppColors.primary)
                : Colors.transparent,
            border: Border.all(
              color: hasError
                  ? AppColors.error
                  : (isFilled ? AppColors.primary : AppColors.border),
              width: 2,
            ),
          ),
        );
      }),
    );
  }
}
