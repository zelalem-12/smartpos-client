import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import 'mock_interceptor.dart';

/// Creates the Dio HTTP client with mock interceptor.
///
/// To switch to a real backend: remove MockInterceptor and update baseUrl.
Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Mock interceptor: returns hardcoded responses for all endpoints
  dio.interceptors.add(MockInterceptor());

  return dio;
}
