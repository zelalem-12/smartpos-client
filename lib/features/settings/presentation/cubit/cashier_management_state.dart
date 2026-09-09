import 'package:equatable/equatable.dart';

import '../../../../core/database/app_database.dart';

/// States for [CashierManagementCubit].
sealed class CashierManagementState extends Equatable {
  const CashierManagementState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any users are loaded.
class CashierManagementInitial extends CashierManagementState {
  const CashierManagementInitial();
}

/// Users are being loaded or a mutation is in progress.
class CashierManagementLoading extends CashierManagementState {
  const CashierManagementLoading();
}

/// Users loaded successfully.
class CashierManagementLoaded extends CashierManagementState {
  final List<User> users;

  const CashierManagementLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

/// An operation failed.
class CashierManagementError extends CashierManagementState {
  final String message;

  const CashierManagementError(this.message);

  @override
  List<Object?> get props => [message];
}
