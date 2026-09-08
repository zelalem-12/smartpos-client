import 'package:equatable/equatable.dart';

/// Domain entity representing a POS user (manager or cashier).
///
/// Decoupled from the Drift-generated [User] data class. Use cases
/// and cubits work with this entity; the data layer maps to/from it.
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String role;
  final String pinHash;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.pinHash,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  /// Convenience check for manager role.
  bool get isManager => role == 'MANAGER';

  /// Convenience check for cashier role.
  bool get isCashier => role == 'CASHIER';

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        pinHash,
        isActive,
        createdAt,
        updatedAt,
      ];
}
