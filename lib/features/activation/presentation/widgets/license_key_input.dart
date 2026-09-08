import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/app_text_field.dart';

/// Styled license key input field with format hint and validation.
class LicenseKeyInput extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const LicenseKeyInput({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'License Key',
      hint: AppConstants.mockLicenseKey,
      controller: controller,
      errorText: errorText,
      readOnly: !enabled,
      maxLength: AppConstants.licenseKeyLength,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\-]')),
        UpperCaseTextFormatter(),
      ],
      onChanged: onChanged,
      suffixIcon: const Icon(Icons.vpn_key_outlined),
    );
  }
}

/// Converts typed text to uppercase in real-time.
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
