import 'package:equatable/equatable.dart';

/// Base failure class. All domain-level failures extend this.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure from a remote server call.
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Failure from local database operations.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local storage error']);
}

/// Failure from input validation.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Failure from authentication (wrong PIN, expired session).
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Failure when a resource is not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

/// Failure for conflicting operations (e.g., duplicate barcode).
class ConflictFailure extends Failure {
  const ConflictFailure(super.message);
}

/// Failure when an operation has already been performed (e.g., Z-Report already run today).
class AlreadyCompletedFailure extends Failure {
  const AlreadyCompletedFailure(super.message);
}

/// Failure from network connectivity issues.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}
