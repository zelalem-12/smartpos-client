import 'package:flutter/foundation.dart';

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

/// Determines the correct initial route based on device and user state and
/// tracks the currently authenticated user in memory.
///
/// Startup state (device activation, manager existence) is loaded **once**
/// by [init] and cached so that [evaluateRedirect] is synchronous — the
/// GoRouter redirect callback must not perform async DB work on every
/// navigation. After any state-changing operation (login, logout,
/// activation, manager setup) call [refresh] to re-query the cached state
/// and notify the router via [ChangeNotifier].
///
/// This class is a [ChangeNotifier] so GoRouter's `refreshListenable` can
/// re-evaluate redirects when the session changes.
class SessionService extends ChangeNotifier {
  final StoreConfigRepository _storeConfigRepo;
  final UserRepository _userRepo;

  Session? _currentSession;
  bool _isActivated = false;
  bool _hasManager = false;
  bool _initialized = false;

  SessionService(this._storeConfigRepo, this._userRepo);

  Session? get currentSession => _currentSession;

  bool get isAuthenticated => _currentSession != null;

  bool get isManager => _currentSession?.role == 'MANAGER';

  bool get isCashier => _currentSession?.role == 'CASHIER';

  String? get currentUserName => _currentSession?.name;

  String? get currentUserRole => _currentSession?.role;

  /// Whether [init] has completed at least once.
  bool get isInitialized => _initialized;

  /// Cached device activation flag (loaded by [init], refreshed by [refresh]).
  bool get isDeviceActivated => _isActivated;

  /// Cached manager-existence flag (loaded by [init], refreshed by [refresh]).
  bool get hasManager => _hasManager;

  /// Load activation and manager state from the database exactly once at
  /// startup. Must complete before the router is created so that
  /// [evaluateRedirect] can run synchronously.
  Future<void> init() async {
    await _loadStartupState();
    _initialized = true;
  }

  Future<void> _loadStartupState() async {
    _isActivated = await _storeConfigRepo.isDeviceActivated();
    _hasManager = await _userRepo.hasManager();
  }

  /// Set the currently authenticated user.
  void setUser(String id, String name, String role) {
    _currentSession = Session(id: id, name: name, role: role);
    notifyListeners();
  }

  /// Clear the current session (e.g., logout).
  void clear() {
    _currentSession = null;
    notifyListeners();
  }

  /// Re-query the cached startup state and notify listeners.
  ///
  /// Call this after any operation that changes device activation or manager
  /// existence (activation, manager setup, manager deactivation). Login and
  /// logout use [setUser]/[clear] which notify on their own.
  Future<void> refresh() async {
    await _loadStartupState();
    notifyListeners();
  }

  /// Test-only seam to seed the cached startup state without a database.
  ///
  /// Marks the service as initialized and sets the cached flags, then
  /// notifies listeners so a router with `refreshListenable` re-evaluates.
  @visibleForTesting
  void seedStartupState({required bool isActivated, required bool hasManager}) {
    _isActivated = isActivated;
    _hasManager = hasManager;
    _initialized = true;
    notifyListeners();
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

  /// Evaluate redirect based on the cached device/user state and the
  /// requested [path]. Synchronous by design — call [init] (or [refresh])
  /// first so the cache is current.
  ///
  /// Returns a redirect path, or `null` if no redirect is needed.
  String? evaluateRedirect(String path) {
    // Guard 1: Device not activated -> force activation
    if (!_isActivated && path != AppRoutes.activation) {
      return AppRoutes.activation;
    }

    // Guard 2: No manager exists -> force manager setup
    if (_isActivated && !_hasManager && path != AppRoutes.managerSetup) {
      return AppRoutes.managerSetup;
    }

    // Guard 3: Already activated and trying to go to activation, skip ahead
    if (_isActivated && path == AppRoutes.activation) {
      if (!_hasManager) return AppRoutes.managerSetup;
      return isAuthenticated ? homeRoute : AppRoutes.login;
    }

    if (_isActivated && _hasManager && path == AppRoutes.managerSetup) {
      return isAuthenticated ? homeRoute : AppRoutes.login;
    }

    // Guard 4: Authenticated user on a public route -> send to home.
    // An unrecognized role has no authenticated home and remains denied.
    if (isAuthenticated && _publicPaths.contains(path)) {
      return homeRoute;
    }

    // Guard 5: Activated + manager exists but not logged in -> force pin login
    // for all non-public routes
    if (_isActivated &&
        _hasManager &&
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
