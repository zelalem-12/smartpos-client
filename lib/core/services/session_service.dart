import '../repositories/store_config_repository.dart';
import '../repositories/user_repository.dart';
import '../router/app_routes.dart';

/// In-memory representation of the currently authenticated user.
class Session {
  final String id;
  final String name;
  final String role;

  const Session({required this.id, required this.name, required this.role});
}

/// Determines the correct initial route based on device and user state
/// and tracks the currently authenticated user in memory.
///
/// Encapsulates the guard logic that was previously embedded in the
/// GoRouter redirect callback. This makes the logic testable and
/// reusable without depending on router internals.
class SessionService {
  final StoreConfigRepository _storeConfigRepo;
  final UserRepository _userRepo;

  Session? _currentSession;

  Session? get currentSession => _currentSession;

  bool get isAuthenticated => _currentSession != null;

  bool get isManager => _currentSession?.role == 'MANAGER';

  bool get isCashier => _currentSession?.role == 'CASHIER';

  String? get currentUserName => _currentSession?.name;

  String? get currentUserRole => _currentSession?.role;

  SessionService(this._storeConfigRepo, this._userRepo);

  /// Set the currently authenticated user.
  void setUser(String id, String name, String role) {
    _currentSession = Session(id: id, name: name, role: role);
  }

  /// Clear the current session (e.g., logout or app termination).
  void clear() {
    _currentSession = null;
  }

  /// The default landing route for the currently authenticated user.
  ///
  /// Returns `null` when no user is logged in.
  String? get homeRoute {
    if (isManager) return AppRoutes.manager;
    if (isCashier) return AppRoutes.cashier;
    return null;
  }

  /// Whether the current user is allowed to access [path].
  bool canAccess(String path) {
    if (!isAuthenticated) return false;

    // Manager has access to all authenticated routes.
    if (isManager) return true;

    // Only a recognized cashier role receives access to core sales flows.
    if (!isCashier) return false;

    const cashierAllowed = {
      AppRoutes.cashier,
      AppRoutes.pos,
      AppRoutes.checkout,
      AppRoutes.receipt,
    };

    return cashierAllowed.contains(path);
  }

  /// Check whether [path] is one of the public (non-authenticated) routes.
  static const _publicPaths = {
    AppRoutes.activation,
    AppRoutes.managerSetup,
    AppRoutes.login,
  };

  /// Evaluate redirect based on current device/user state and the
  /// requested [path].
  ///
  /// Returns a redirect path, or `null` if no redirect is needed.
  Future<String?> evaluateRedirect(String path) async {
    final isActivated = await _storeConfigRepo.isDeviceActivated();

    // Guard 1: Device not activated -> force activation
    if (!isActivated && path != AppRoutes.activation) {
      return AppRoutes.activation;
    }

    // Guard 2: No manager exists -> force manager setup
    final hasManager = await _userRepo.hasManager();

    if (isActivated && !hasManager && path != AppRoutes.managerSetup) {
      return AppRoutes.managerSetup;
    }

    // Guard 3: Already activated and trying to go to activation, skip ahead
    if (isActivated && path == AppRoutes.activation) {
      if (!hasManager) return AppRoutes.managerSetup;
      return isAuthenticated ? homeRoute : AppRoutes.login;
    }

    if (isActivated && hasManager && path == AppRoutes.managerSetup) {
      return isAuthenticated ? homeRoute : AppRoutes.login;
    }

    // Guard 4: Authenticated user on a public route -> send to home.
    // An unrecognized role has no authenticated home and remains denied.
    if (isAuthenticated && _publicPaths.contains(path)) {
      return homeRoute;
    }

    // Guard 5: Activated + manager exists but not logged in -> force pin login
    // for all non-public routes
    if (isActivated &&
        hasManager &&
        !isAuthenticated &&
        !_publicPaths.contains(path)) {
      return AppRoutes.login;
    }

    // Guard 6: Enforce role-specific dashboards even though managers may use
    // every authenticated sales route.
    if (isManager && path == AppRoutes.cashier) return AppRoutes.manager;
    if (isCashier && path == AppRoutes.manager) return AppRoutes.cashier;

    // Guard 7: Authenticated but trying to access a restricted route. Unknown
    // roles have no home and are sent safely to login without gaining access.
    if (isAuthenticated && !canAccess(path)) {
      return homeRoute ?? AppRoutes.login;
    }

    return null; // No redirect
  }
}
