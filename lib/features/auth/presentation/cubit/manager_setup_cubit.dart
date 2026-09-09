import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/session_service.dart';
import '../../domain/usecases/create_manager.dart';
import 'manager_setup_state.dart';

/// Manages the manager setup screen state.
///
/// Validates the form (matching passwords) and delegates to [CreateManager]
/// for persistence. Emits [ManagerSetupLoading], [ManagerSetupSuccess],
/// or [ManagerSetupError].
class ManagerSetupCubit extends Cubit<ManagerSetupState> {
  final CreateManager _createManager;
  final SessionService _sessionService;

  ManagerSetupCubit(this._createManager, this._sessionService)
    : super(const ManagerSetupInitial());

  /// Submit the manager setup form.
  ///
  /// [password] and [confirmPassword] must match. The use case validates
  /// username, full name, password, and uniqueness.
  Future<void> submit({
    required String username,
    required String fullName,
    required String password,
    required String confirmPassword,
  }) async {
    emit(const ManagerSetupLoading());

    if (password != confirmPassword) {
      emit(const ManagerSetupError('Passwords do not match'));
      return;
    }

    try {
      final manager = await _createManager(
        username: username,
        fullName: fullName,
        password: password,
      );
      // Refresh cached startup state so the router redirect picks up the
      // newly-created manager without an extra DB hit per navigation.
      await _sessionService.refresh();
      emit(ManagerSetupSuccess(manager));
    } on Failure catch (e) {
      emit(ManagerSetupError(e.message));
    } catch (e) {
      emit(ManagerSetupError('Unexpected error: $e'));
    }
  }
}
