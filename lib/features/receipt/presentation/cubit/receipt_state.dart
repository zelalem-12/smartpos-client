import 'package:equatable/equatable.dart';

import '../../domain/entities/receipt_data.dart';

/// Base class for receipt UI states.
sealed class ReceiptState extends Equatable {
  const ReceiptState();

  @override
  List<Object?> get props => [];
}

/// Receipt is being loaded from the local invoice ID.
class ReceiptLoading extends ReceiptState {
  const ReceiptLoading();
}

/// Something went wrong loading or printing the receipt.
///
/// [receipt] is kept so the user can still see a successfully loaded receipt
/// when a print fails.
class ReceiptError extends ReceiptState {
  final String message;
  final ReceiptData? receipt;
  final int? invoiceId;

  const ReceiptError(this.message, {this.receipt, this.invoiceId});

  @override
  List<Object?> get props => [message, receipt, invoiceId];
}

/// Receipt is loaded and ready to be printed.
class ReceiptReady extends ReceiptState {
  final ReceiptData receipt;
  final bool isDuplicate;
  final String? errorMessage;

  const ReceiptReady(
    this.receipt, {
    this.isDuplicate = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [receipt, isDuplicate, errorMessage];
}

/// Receipt is currently being printed.
class ReceiptPrinting extends ReceiptState {
  final ReceiptData receipt;
  final bool isDuplicate;

  const ReceiptPrinting(this.receipt, {this.isDuplicate = false});

  @override
  List<Object?> get props => [receipt, isDuplicate];
}

/// Receipt has been printed successfully.
class ReceiptPrinted extends ReceiptState {
  final ReceiptData receipt;
  final bool isDuplicate;

  const ReceiptPrinted(this.receipt, {this.isDuplicate = false});

  @override
  List<Object?> get props => [receipt, isDuplicate];
}
