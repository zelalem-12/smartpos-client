import '../repositories/store_config_repository.dart';
import '../repositories/user_repository.dart';
import '../router/app_router.dart';

/// Determines the correct initial route based on device and user state.
///
/// Encapsulates the guard logic that was previously embedded in the
/// GoRouter redirect callback. This makes the logic testable and
/// reusable without depending on router internals.
class SessionService {
  final StoreConfigRepository _storeConfigRepo;
  final UserRepository _userRepo;

  const SessionService({
    required this._storeConfigRepo,
    required this._userRepo,
  });

  /// Evaluate redirect based on current device/user state and the
  /// requested [path].
  ///
  /// Returns a redirect path, or `null` if no redirect is needed.
  ///
  /// Guard logic:
  /// 1. Device not activated -> force /activation
  /// 2. No manager exists -> force /manager-setup
  /// 3. Already activated + going to /activation -> skip to login/setup
  Future<String?> evaluateRedirect(String path) async {
    final isActivated = await _storeConfigRepo.isDeviceActivated();

    // Guard 1: Device not activated -> force activation
    if (!isActivated && path != AppRoutes.activation) {
      return AppRoutes.activation;
    }

    // Guard 2: No manager exists -> force manager setup
    if (isActivated && path != AppRoutes.managerSetup) {
      final hasManager = await _userRepo.hasManager();
      if (!hasManager && path != AppRoutes.activation) {
        return AppRoutes.managerSetup;
      }
    }

    // If already activated and trying to go to activation, skip ahead
    if (isActivated && path == AppRoutes.activation) {
      final hasManager = await _userRepo.hasManager();
      if (!hasManager) return AppRoutes.managerSetup;
      return AppRoutes.pinLogin;
    }

    return null; // No redirect
  }
}
