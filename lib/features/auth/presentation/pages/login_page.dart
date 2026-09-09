import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

/// Username and password login screen for managers and cashiers.
///
/// The user enters their username and password. On a match, the current
/// session is set and the app navigates to the role-appropriate home.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _usernameController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty;

  void _submit() {
    if (!_canSubmit) return;
    context.read<LoginCubit>().submit(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              final home = sl<SessionService>().homeRoute ?? AppRoutes.pos;
              context.go(home);
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;
            final errorText = state is LoginError ? state.message : null;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(theme),
                      const SizedBox(height: 32),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                key: const ValueKey('usernameField'),
                                hint: 'username',
                                controller: _usernameController,
                                enabled: !isLoading,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) => setState(() {}),
                              ),
                              const SizedBox(height: 20),
                              AppTextField(
                                key: const ValueKey('passwordField'),
                                hint: 'password',
                                controller: _passwordController,
                                enabled: !isLoading,
                                obscureText: _obscurePassword,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _submit(),
                                onChanged: (_) => setState(() {}),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              AppButton(
                                label: 'Log In',
                                isLoading: isLoading,
                                icon: Icons.login,
                                onPressed: _canSubmit && !isLoading
                                    ? _submit
                                    : null,
                              ),
                              if (errorText != null) ...[
                                const SizedBox(height: 16),
                                _buildErrorText(context, errorText),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.lock_outline, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 16),
        Text(
          AppConstants.appName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppConstants.appTagline,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorText(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
