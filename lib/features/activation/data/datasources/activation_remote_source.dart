import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/activation_response_model.dart';

/// Remote data source for device activation.
///
/// Calls the backend API (or mock interceptor) to verify a license key
/// and retrieve the store configuration.
class ActivationRemoteSource {
  final Dio _dio;

  const ActivationRemoteSource(this._dio);

  /// POST the license key to the activation endpoint.
  ///
  /// Returns an [ActivationResponseModel] on success.
  /// Throws [ServerFailure] on network/API errors.
  Future<ActivationResponseModel> activateDevice(String licenseKey) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.activateDevice,
        data: {'license_key': licenseKey},
      );

      return ActivationResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] as String? ??
            'Activation failed: ${e.message}',
      );
    }
  }
}
