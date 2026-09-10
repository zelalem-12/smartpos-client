import 'package:flutter/material.dart';

/// ChoiceChip wrapper that enforces a 48dp minimum touch target for POS use.
///
/// Material [ChoiceChip] defaults to ~32-40dp height. This widget wraps it
/// with [MaterialTapTargetSize.padded] and adds internal padding so the
/// entire chip meets the 48dp minimum touch target requirement.
class AppChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  const AppChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
  }
}
