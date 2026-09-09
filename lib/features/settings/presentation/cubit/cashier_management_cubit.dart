import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/repositories/user_repository.dart';
import '../../../auth/domain/usecases/create_cashier.dart';
import 'cashier_management_state.dart';

/// Manages cashier accounts from the Settings screen.
///
/// Lists active users, creates new cashiers, and toggles cashier active
/// status. Manager accounts are never deactivated from this UI.
class CashierManagementCubit extends Cubit<CashierManagementState> {
  final UserRepository _userRepository;
  final CreateCashier _createCashier;

  CashierManagementCubit(this._userRepository, this._createCashier)
    : super(const CashierManagementInitial());

  /// Load all active users (managers and cashiers).
  Future<void> loadUsers() async {
    emit(const CashierManagementLoading());
    try {
      final users = await _userRepository.getAllUsers();
      emit(CashierManagementLoaded(users));
    } on Failure catch (e) {
      emit(CashierManagementError(e.message));
    } catch (e) {
      emit(CashierManagementError('Failed to load users: $e'));
    }
  }

  /// Create a new cashier account.
  ///
  /// Throws validation errors through [CreateCashier].
  Future<void> createCashier({
    required String username,
    required String fullName,
    required String password,
  }) async {
    emit(const CashierManagementLoading());
    try {
      await _createCashier(
        username: username,
        fullName: fullName,
        password: password,
      );
      await loadUsers();
    } on Failure catch (e) {
      await loadUsers();
      emit(CashierManagementError(e.message));
    } catch (e) {
      await loadUsers();
      emit(CashierManagementError('Failed to create cashier: $e'));
    }
  }

  /// Toggle a user's active status.
  ///
  /// Manager accounts cannot be deactivated. The caller should still guard
  /// the UI; this method adds a defensive runtime check.
  Future<void> toggleActive(User user) async {
    if (user.role == 'MANAGER' && user.isActive) {
      emit(
        const CashierManagementError(
          'Manager accounts cannot be deactivated from this screen',
        ),
      );
      return;
    }

    emit(const CashierManagementLoading());
    try {
      await _userRepository.updateUser(
        UsersCompanion(
          id: Value(user.id),
          isActive: Value(!user.isActive),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await loadUsers();
    } on Failure catch (e) {
      emit(CashierManagementError(e.message));
    } catch (e) {
      emit(CashierManagementError('Failed to update user: $e'));
    }
  }
}
