import 'dart:developer' as developer;
import 'printer_service.dart';

/// Mock printer for emulator and desktop testing.
///
/// Logs receipt content to the debug console instead of printing.
class MockPrinterService implements PrinterService {
  bool _initialized = false;

  @override
  Future<void> init() async {
    _initialized = true;
    developer.log('[MockPrinter] Initialized', name: 'Printer');
  }

  @override
  Future<bool> printReceipt(List<PrintLine> lines) async {
    if (!_initialized) await init();

    developer.log('[MockPrinter] === RECEIPT START ===', name: 'Printer');
    for (final line in lines) {
      final prefix = line.bold ? '[B] ' : '    ';
      final alignLabel = line.alignment.name.toUpperCase();
      developer.log('$prefix[$alignLabel] ${line.text}', name: 'Printer');
    }
    developer.log('[MockPrinter] === RECEIPT END ===', name: 'Printer');

    // Simulate print delay
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Future<bool> printQrCode(String data, {int size = 8}) async {
    developer.log('[MockPrinter] QR Code: $data (size=$size)', name: 'Printer');
    return true;
  }

  @override
  Future<void> cutPaper() async {
    developer.log('[MockPrinter] Paper cut', name: 'Printer');
  }

  @override
  Future<PrinterStatus> getStatus() async {
    return PrinterStatus.ready;
  }
}
