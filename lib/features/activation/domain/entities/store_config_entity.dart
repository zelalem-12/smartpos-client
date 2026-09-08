import 'package:equatable/equatable.dart';

/// Domain entity representing the merchant's store configuration.
///
/// This is the clean domain representation, decoupled from the
/// Drift-generated [StoreConfig] data class. Use cases and cubits
/// work with this entity; the data layer maps to/from it.
class StoreConfigEntity extends Equatable {
  final String licenseKey;
  final String businessName;
  final String tradeName;
  final String tin;
  final String vatRegNo;
  final String sector;
  final String address;
  final String deviceSerial;

  const StoreConfigEntity({
    required this.licenseKey,
    required this.businessName,
    required this.tradeName,
    required this.tin,
    required this.vatRegNo,
    required this.sector,
    required this.address,
    required this.deviceSerial,
  });

  @override
  List<Object?> get props => [
    licenseKey,
    businessName,
    tradeName,
    tin,
    vatRegNo,
    sector,
    address,
    deviceSerial,
  ];
}
