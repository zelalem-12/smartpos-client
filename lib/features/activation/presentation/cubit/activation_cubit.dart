import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/session_service.dart';
import '../../domain/usecases/activate_device.dart';
import 'activation_state.dart';

/// Manages the activation screen state.
///
/// Emits [ActivationLoading] while the API call is in progress,
/// then [ActivationSuccess] or [ActivationError].
class ActivationCubit extends Cubit<ActivationState> {
  final ActivateDevice _activateDevice;
  final SessionService _sessionService;

  ActivationCubit(this._activateDevice, this._sessionService)
    : super(const ActivationInitial());

  /// Submit the license key for activation.
  Future<void> activate(String licenseKey) async {
    emit(const ActivationLoading());

    try {
      final storeConfig = await _activateDevice(licenseKey);
      // Refresh cached startup state so the router redirect picks up the
      // newly-activated device without an extra DB hit per navigation.
      await _sessionService.refresh();
      emit(ActivationSuccess(storeConfig));
    } on Failure catch (e) {
      emit(ActivationError(e.message));
    } catch (e) {
      emit(ActivationError('Unexpected error: $e'));
    }
  }
}
