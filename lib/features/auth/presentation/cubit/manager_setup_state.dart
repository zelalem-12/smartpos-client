import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

/// States for the manager setup flow.
sealed class ManagerSetupState extends Equatable {
  const ManagerSetupState();

  @override
  List<Object?> get props => [];
}

/// Initial state — form is ready for input.
class ManagerSetupInitial extends ManagerSetupState {
  const ManagerSetupInitial();
}

/// Manager is being created.
class ManagerSetupLoading extends ManagerSetupState {
  const ManagerSetupLoading();
}

/// Manager created successfully.
class ManagerSetupSuccess extends ManagerSetupState {
  final UserEntity manager;

  const ManagerSetupSuccess(this.manager);

  @override
  List<Object?> get props => [manager];
}

/// Manager creation failed.
class ManagerSetupError extends ManagerSetupState {
  final String message;

  const ManagerSetupError(this.message);

  @override
  List<Object?> get props => [message];
}
