import 'package:dio/dio.dart';
import 'api_endpoints.dart';

/// Intercepts all HTTP requests and returns mock JSON responses.
///
/// This interceptor simulates the Go backend so the POS app can be
/// developed and tested without a running server. To connect to the
/// real backend, simply remove this interceptor from Dio.
class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final path = options.path;

    if (path.endsWith(ApiEndpoints.activateDevice)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: _mockActivationResponse,
        ),
      );
    }

    if (path.endsWith(ApiEndpoints.syncInvoices)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {'status': 'synced', 'count': 1},
        ),
      );
    }

    if (path.endsWith(ApiEndpoints.usersSync)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {'status': 'synced'},
        ),
      );
    }

    // Default: pass through (will fail if no real server)
    handler.next(options);
  }

  static const Map<String, dynamic> _mockActivationResponse = {
    'business_name': 'Bole Roasters Cafe Private Limited Company',
    'trade_name': 'Bole Roasters Cafe',
    'tin': '0012345678',
    'vat_reg_no': '123456789',
    'sector': '18. Restaurants & Food Service (Offline Mandatory)',
    'address': 'Addis Ababa, Bole Subcity, Woreda 03, H.No 412',
    'device_serial': 'SUNMI-V2P-ET-89412',
  };
}
