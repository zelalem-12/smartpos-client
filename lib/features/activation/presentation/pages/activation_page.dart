import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../cubit/activation_cubit.dart';
import '../cubit/activation_state.dart';
import '../widgets/activation_progress.dart';
import '../widgets/license_key_input.dart';

/// Device activation screen.
///
/// Centered card layout with SmartPOS branding, a license key field,
/// and an "Activate" button. On success, shows a brief config summary
/// before navigating to manager setup.
class ActivationPage extends StatefulWidget {
  const ActivationPage({super.key});

  @override
  State<ActivationPage> createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  final _keyController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _keyController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _keyController.removeListener(_onTextChanged);
    _keyController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _keyController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: BlocConsumer<ActivationCubit, ActivationState>(
                listener: (context, state) {
                  // Navigation is now triggered manually by the user
                  // tapping the "Set Up Manager Account" button on the
                  // success card.
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo / branding
                      _buildHeader(theme),
                      const SizedBox(height: 32),

                      if (state is ActivationSuccess)
                        // Success summary card
                        ActivationProgress(
                          storeConfig: state.storeConfig,
                          onNext: () => context.go(AppRoutes.managerSetup),
                        )
                      else
                        // Input card
                        _buildInputCard(context, theme, state),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        // App icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.point_of_sale_rounded,
            color: Colors.white,
            size: 40,
          ),
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
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInputCard(
    BuildContext context,
    ThemeData theme,
    ActivationState state,
  ) {
    final isLoading = state is ActivationLoading;
    final errorText = state is ActivationError ? state.message : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Device Activation',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fast, reliable point of sale and e-invoicing for Ethiopian businesses — online or offline.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            LicenseKeyInput(
              controller: _keyController,
              errorText: errorText,
              enabled: !isLoading,
              onChanged: (_) {
                // Clear error when user edits
                if (state is ActivationError) {
                  // Force rebuild via cubit reset is not needed;
                  // the error clears on next activate() call.
                }
              },
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Activate',
              isLoading: isLoading,
              icon: Icons.verified_outlined,
              onPressed: !_hasText || isLoading
                  ? null
                  : () {
                      context.read<ActivationCubit>().activate(
                        _keyController.text,
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
