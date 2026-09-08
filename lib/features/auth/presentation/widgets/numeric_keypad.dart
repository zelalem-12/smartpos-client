import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Numeric keypad for 4-digit PIN entry.
class NumericKeypad extends StatelessWidget {
  final ValueChanged<String>? onDigit;
  final VoidCallback? onBackspace;
  final VoidCallback? onClear;
  final bool enabled;

  const NumericKeypad({
    super.key,
    this.onDigit,
    this.onBackspace,
    this.onClear,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _row(['1', '2', '3']),
        _row(['4', '5', '6']),
        _row(['7', '8', '9']),
        _bottomRow(),
      ],
    );
  }

  Widget _row(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((d) => _key(d)).toList(),
    );
  }

  Widget _bottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionKey(
          icon: Icons.backspace_outlined,
          onTap: enabled ? onBackspace : null,
        ),
        _key('0'),
        _actionKey(icon: Icons.clear, onTap: enabled ? onClear : null),
      ],
    );
  }

  Widget _key(String digit) {
    return _KeypadButton(
      onTap: enabled ? () => onDigit?.call(digit) : null,
      child: Text(
        digit,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _actionKey({required IconData icon, required VoidCallback? onTap}) {
    return _KeypadButton(
      onTap: onTap,
      child: Icon(icon, color: AppColors.textSecondary, size: 24),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _KeypadButton({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            width: 72,
            height: 56,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
