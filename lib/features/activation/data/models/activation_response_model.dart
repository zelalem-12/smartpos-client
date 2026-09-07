import '../../domain/entities/store_config_entity.dart';

/// Maps the activation API JSON response to a [StoreConfigEntity].
class ActivationResponseModel {
  final String businessName;
  final String tradeName;
  final String tin;
  final String vatRegNo;
  final String sector;
  final String address;
  final String deviceSerial;

  const ActivationResponseModel({
    required this.businessName,
    required this.tradeName,
    required this.tin,
    required this.vatRegNo,
    required this.sector,
    required this.address,
    required this.deviceSerial,
  });

  factory ActivationResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivationResponseModel(
      businessName: json['business_name'] as String,
      tradeName: json['trade_name'] as String,
      tin: json['tin'] as String,
      vatRegNo: json['vat_reg_no'] as String,
      sector: json['sector'] as String,
      address: json['address'] as String,
      deviceSerial: json['device_serial'] as String,
    );
  }

  /// Convert to a domain entity, attaching the [licenseKey] used.
  StoreConfigEntity toEntity(String licenseKey) {
    return StoreConfigEntity(
      licenseKey: licenseKey,
      businessName: businessName,
      tradeName: tradeName,
      tin: tin,
      vatRegNo: vatRegNo,
      sector: sector,
      address: address,
      deviceSerial: deviceSerial,
    );
  }
}
