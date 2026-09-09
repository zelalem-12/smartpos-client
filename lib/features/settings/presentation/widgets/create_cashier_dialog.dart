import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';

/// Dialog for creating a new cashier account.
///
/// Returns a [CreateCashierResult] when the form is submitted and validated.
class CreateCashierDialog extends StatefulWidget {
  const CreateCashierDialog({super.key});

  @override
  State<CreateCashierDialog> createState() => _CreateCashierDialogState();
}

class _CreateCashierDialogState extends State<CreateCashierDialog> {
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorText;

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _usernameController.text.trim().isNotEmpty &&
      _fullNameController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  void _submit() {
    if (!_canSubmit) return;

    final username = _usernameController.text.trim();
    final fullName = _fullNameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() => _errorText = 'Passwords do not match');
      return;
    }

    Navigator.of(context).pop(
      CreateCashierResult(
        username: username,
        fullName: fullName,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Cashier'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              key: const ValueKey('createCashierUsernameField'),
              label: 'Username',
              hint: 'e.g. cashier01',
              controller: _usernameController,
              textInputAction: TextInputAction.next,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            AppTextField(
              key: const ValueKey('createCashierFullNameField'),
              label: 'Full Name',
              hint: 'e.g. Chala Kebede',
              controller: _fullNameController,
              textInputAction: TextInputAction.next,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            AppTextField(
              key: const ValueKey('createCashierPasswordField'),
              label: 'Password',
              hint: 'Min. 4 characters',
              controller: _passwordController,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              onChanged: (_) => setState(() {}),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            const SizedBox(height: 12),
            AppTextField(
              key: const ValueKey('createCashierConfirmPasswordField'),
              label: 'Confirm Password',
              hint: 'Re-enter password',
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              onChanged: (_) => setState(() {}),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                ),
              ),
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorText!,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: AppColors.error),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        AppButton(
          key: const ValueKey('createCashierSubmitButton'),
          label: 'Create',
          onPressed: _canSubmit ? _submit : null,
        ),
      ],
    );
  }
}

/// Data returned when a cashier creation form is submitted.
class CreateCashierResult {
  final String username;
  final String fullName;
  final String password;

  const CreateCashierResult({
    required this.username,
    required this.fullName,
    required this.password,
  });
}
