import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/session_service.dart';
import '../../domain/usecases/login_with_credentials.dart';
import 'login_state.dart';

/// Manages the username/password login screen state.
///
/// Delegates verification to [LoginWithCredentials], sets the active
/// [SessionService] user on success, and emits [LoginSuccess] or
/// [LoginError].
class LoginCubit extends Cubit<LoginState> {
  final LoginWithCredentials _loginWithCredentials;
  final SessionService _sessionService;

  LoginCubit(this._loginWithCredentials, this._sessionService)
    : super(const LoginInitial());

  /// Submit username and password for authentication.
  Future<void> submit({
    required String username,
    required String password,
  }) async {
    emit(const LoginLoading());

    try {
      final user = await _loginWithCredentials(
        username: username,
        password: password,
      );
      _sessionService.setUser(user.id, user.fullName, user.role);
      emit(LoginSuccess(user));
    } on Failure catch (e) {
      emit(LoginError(e.message));
    } catch (e) {
      emit(LoginError('Unexpected error: $e'));
    }
  }
}
