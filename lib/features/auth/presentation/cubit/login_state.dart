import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

/// States for the credential login flow.
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

/// Initial state — waiting for credentials.
class LoginInitial extends LoginState {
  const LoginInitial();
}

/// Credentials are being verified.
class LoginLoading extends LoginState {
  const LoginLoading();
}

/// Credentials are correct and user is authenticated.
class LoginSuccess extends LoginState {
  final UserEntity user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// Credentials are incorrect or verification failed.
class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
