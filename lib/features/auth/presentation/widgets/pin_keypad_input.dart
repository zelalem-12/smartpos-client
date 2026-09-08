import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/pin_input_widget.dart';
import 'numeric_keypad.dart';

/// PIN entry with dot indicator and numeric keypad.
///
/// Emits [onChanged] for every digit and [onCompleted] when the PIN
/// reaches [pinLength].
class PinKeypadInput extends StatefulWidget {
  final int pinLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool hasError;
  final bool enabled;

  const PinKeypadInput({
    super.key,
    this.pinLength = AppConstants.pinLength,
    this.onChanged,
    this.onCompleted,
    this.hasError = false,
    this.enabled = true,
  });

  @override
  State<PinKeypadInput> createState() => _PinKeypadInputState();
}

class _PinKeypadInputState extends State<PinKeypadInput> {
  String _pin = '';

  void _addDigit(String digit) {
    if (!widget.enabled || _pin.length >= widget.pinLength) return;
    setState(() {
      _pin += digit;
    });
    widget.onChanged?.call(_pin);
    if (_pin.length == widget.pinLength) {
      widget.onCompleted?.call(_pin);
    }
  }

  void _backspace() {
    if (!widget.enabled || _pin.isEmpty) return;
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
    });
    widget.onChanged?.call(_pin);
  }

  void _clear() {
    if (!widget.enabled || _pin.isEmpty) return;
    setState(() {
      _pin = '';
    });
    widget.onChanged?.call(_pin);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PinInputWidget(
          filledCount: _pin.length,
          pinLength: widget.pinLength,
          hasError: widget.hasError,
        ),
        const SizedBox(height: 16),
        NumericKeypad(
          onDigit: _addDigit,
          onBackspace: _backspace,
          onClear: _clear,
          enabled: widget.enabled,
        ),
      ],
    );
  }
}
