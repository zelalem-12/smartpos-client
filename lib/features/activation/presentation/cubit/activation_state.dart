import 'package:equatable/equatable.dart';

import '../../domain/entities/store_config_entity.dart';

/// States for the activation flow.
sealed class ActivationState extends Equatable {
  const ActivationState();

  @override
  List<Object?> get props => [];
}

/// Initial state — awaiting user input.
class ActivationInitial extends ActivationState {
  const ActivationInitial();
}

/// License key is being verified and device is being activated.
class ActivationLoading extends ActivationState {
  const ActivationLoading();
}

/// Activation succeeded — store config received and persisted.
class ActivationSuccess extends ActivationState {
  final StoreConfigEntity storeConfig;

  const ActivationSuccess(this.storeConfig);

  @override
  List<Object?> get props => [storeConfig];
}

/// Activation failed — display error message.
class ActivationError extends ActivationState {
  final String message;

  const ActivationError(this.message);

  @override
  List<Object?> get props => [message];
}
