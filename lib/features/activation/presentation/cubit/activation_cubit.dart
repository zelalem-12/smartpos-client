import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/activate_device.dart';
import 'activation_state.dart';

/// Manages the activation screen state.
///
/// Emits [ActivationLoading] while the API call is in progress,
/// then [ActivationSuccess] or [ActivationError].
class ActivationCubit extends Cubit<ActivationState> {
  final ActivateDevice _activateDevice;

  ActivationCubit(this._activateDevice) : super(const ActivationInitial());

  /// Submit the license key for activation.
  Future<void> activate(String licenseKey) async {
    emit(const ActivationLoading());

    try {
      final storeConfig = await _activateDevice(licenseKey);
      emit(ActivationSuccess(storeConfig));
    } on Failure catch (e) {
      emit(ActivationError(e.message));
    } catch (e) {
      emit(ActivationError('Unexpected error: $e'));
    }
  }
}
