import '../../core/error/failures.dart';

/// Sanitizes an exception into a user-friendly message.
///
/// Returns the [Failure.message] for known failures, or a generic fallback
/// for unexpected errors so raw exception text never reaches the UI.
String sanitizeErrorMessage(Object e) {
  if (e is Failure) return e.message;
  return 'Something went wrong. Please try again.';
}
