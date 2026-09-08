import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/create_manager.dart';
import 'manager_setup_state.dart';

/// Manages the manager setup screen state.
///
/// Validates the form (matching PINs) and delegates to [CreateManager]
/// for persistence. Emits [ManagerSetupLoading], [ManagerSetupSuccess],
/// or [ManagerSetupError].
class ManagerSetupCubit extends Cubit<ManagerSetupState> {
  final CreateManager _createManager;

  ManagerSetupCubit(this._createManager) : super(const ManagerSetupInitial());

  /// Submit the manager setup form.
  ///
  /// [pin] and [confirmPin] must match. The use case validates
  /// name length, PIN format, and uniqueness.
  Future<void> submit({
    required String name,
    required String pin,
    required String confirmPin,
  }) async {
    emit(const ManagerSetupLoading());

    if (pin != confirmPin) {
      emit(const ManagerSetupError('PINs do not match'));
      return;
    }

    try {
      final manager = await _createManager(name: name, pin: pin);
      emit(ManagerSetupSuccess(manager));
    } on Failure catch (e) {
      emit(ManagerSetupError(e.message));
    } catch (e) {
      emit(ManagerSetupError('Unexpected error: $e'));
    }
  }
}
