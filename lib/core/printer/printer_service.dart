/// Abstract printer interface.
///
/// Concrete implementations:
/// - SunmiPrinterService: for Sunmi V2/P2 built-in thermal printer
/// - MockPrinterService: for emulator/desktop testing
abstract class PrinterService {
  /// Initialize and bind to the printer hardware.
  Future<void> init();

  /// Print a full receipt from formatted lines.
  Future<bool> printReceipt(List<PrintLine> lines);

  /// Print a QR code with the given data payload.
  Future<bool> printQrCode(String data, {int size = 8});

  /// Cut the paper (if supported by hardware).
  Future<void> cutPaper();

  /// Get the current printer status.
  Future<PrinterStatus> getStatus();
}

/// A single line in a receipt.
class PrintLine {
  final String text;
  final PrintAlignment alignment;
  final bool bold;
  final PrintFontSize fontSize;

  const PrintLine(
    this.text, {
    this.alignment = PrintAlignment.left,
    this.bold = false,
    this.fontSize = PrintFontSize.normal,
  });

  const PrintLine.center(this.text, {this.bold = false, this.fontSize = PrintFontSize.normal})
      : alignment = PrintAlignment.center;

  const PrintLine.right(this.text, {this.bold = false, this.fontSize = PrintFontSize.normal})
      : alignment = PrintAlignment.right;

  const PrintLine.bold(this.text, {this.alignment = PrintAlignment.left, this.fontSize = PrintFontSize.normal})
      : bold = true;
}

enum PrintAlignment { left, center, right }

enum PrintFontSize { small, normal, large, extraLarge }

enum PrinterStatus { ready, noPaper, overheating, notConnected, unknown }
