import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart' hide PrinterStatus;

import '../error/failures.dart';
import 'printer_service.dart';

/// Production-safe [PrinterService] implementation for Sunmi Android devices.
///
/// This service binds to the built-in Sunmi thermal printer and converts the
/// generic [PrintLine] model into the plugin's [SunmiText] / [SunmiTextStyle]
/// calls. It is only registered on Android; on all other platforms the
/// [MockPrinterService] is used so tests and desktop builds do not crash.
///
/// Real Sunmi hardware cannot be exercised in this environment, so the actual
/// printer calls are wrapped in production-safe try/catch blocks. If the
/// Sunmi service cannot be bound or the printer is not ready, the error is
/// surfaced as a user-visible [CacheFailure] rather than a platform crash.
class SunmiPrinterService implements PrinterService {
  final SunmiPrinterPlus _sunmi;
  bool _initialized = false;

  SunmiPrinterService() : _sunmi = SunmiPrinterPlus();

  @override
  Future<void> init() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw const CacheFailure('Sunmi printer is only supported on Android');
    }

    if (_initialized) return;

    try {
      final bound = await _sunmi.rebindPrinter();
      if (bound != true) {
        throw const CacheFailure('Unable to bind to Sunmi printer service');
      }

      final status = await _sunmi.getStatus();
      if (status == null || status.toUpperCase() != 'READY') {
        throw CacheFailure('Sunmi printer not ready: ${status ?? 'unknown'}');
      }

      _initialized = true;
    } on MissingPluginException {
      throw const CacheFailure(
        'Sunmi printer plugin is not available on this device',
      );
    } on PlatformException catch (e) {
      throw CacheFailure('Sunmi printer error: ${e.message ?? e.code}');
    } catch (e) {
      throw CacheFailure('Sunmi printer initialization failed: $e');
    }
  }

  @override
  Future<bool> printReceipt(List<PrintLine> lines) async {
    try {
      if (!_initialized) await init();

      await SunmiPrinter.lineWrap(1);

      for (final line in lines) {
        final style = SunmiTextStyle(
          fontSize: _fontSize(line.fontSize),
          align: _alignment(line.alignment),
          bold: line.bold,
        );
        await SunmiPrinter.printText(line.text, style: style);
      }

      await SunmiPrinter.lineWrap(2);
      return true;
    } on Failure {
      rethrow;
    } on MissingPluginException {
      throw const CacheFailure(
        'Sunmi printer plugin is not available on this device',
      );
    } on PlatformException catch (e) {
      throw CacheFailure('Sunmi print error: ${e.message ?? e.code}');
    } catch (e) {
      throw CacheFailure('Sunmi print failed: $e');
    }
  }

  @override
  Future<bool> printQrCode(String data, {int size = 8}) async {
    try {
      if (!_initialized) await init();

      final clampedSize = size.clamp(1, 16);
      await SunmiPrinter.printQRCode(
        data,
        style: SunmiQrcodeStyle(
          qrcodeSize: clampedSize,
          align: SunmiPrintAlign.CENTER,
        ),
      );
      return true;
    } on Failure {
      rethrow;
    } on MissingPluginException {
      throw const CacheFailure(
        'Sunmi printer plugin is not available on this device',
      );
    } on PlatformException catch (e) {
      throw CacheFailure('Sunmi QR error: ${e.message ?? e.code}');
    } catch (e) {
      throw CacheFailure('Sunmi QR print failed: $e');
    }
  }

  @override
  Future<void> cutPaper() async {
    try {
      if (!_initialized) await init();
      await SunmiPrinter.cutPaper();
    } on Failure {
      rethrow;
    } on MissingPluginException {
      throw const CacheFailure(
        'Sunmi printer plugin is not available on this device',
      );
    } on PlatformException catch (e) {
      throw CacheFailure('Sunmi cut error: ${e.message ?? e.code}');
    } catch (e) {
      throw CacheFailure('Sunmi paper cut failed: $e');
    }
  }

  @override
  Future<PrinterStatus> getStatus() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return PrinterStatus.notConnected;
    }

    try {
      final status = await _sunmi.getStatus();
      if (status == null || status.isEmpty) {
        return PrinterStatus.notConnected;
      }

      final upper = status.toUpperCase();
      if (upper.contains('READY')) return PrinterStatus.ready;
      if (upper.contains('HOT')) return PrinterStatus.overheating;
      if (upper.contains('OUT') || upper.contains('JAM')) {
        return PrinterStatus.noPaper;
      }
      if (upper.contains('OFFLINE') || upper.contains('COMM')) {
        return PrinterStatus.notConnected;
      }
      return PrinterStatus.unknown;
    } on MissingPluginException {
      return PrinterStatus.notConnected;
    } on PlatformException {
      return PrinterStatus.unknown;
    } catch (_) {
      return PrinterStatus.unknown;
    }
  }

  int _fontSize(PrintFontSize size) {
    switch (size) {
      case PrintFontSize.small:
        return 20;
      case PrintFontSize.normal:
        return 24;
      case PrintFontSize.large:
        return 32;
      case PrintFontSize.extraLarge:
        return 40;
    }
  }

  SunmiPrintAlign _alignment(PrintAlignment alignment) {
    switch (alignment) {
      case PrintAlignment.left:
        return SunmiPrintAlign.LEFT;
      case PrintAlignment.center:
        return SunmiPrintAlign.CENTER;
      case PrintAlignment.right:
        return SunmiPrintAlign.RIGHT;
    }
  }
}
