import 'package:equatable/equatable.dart';

/// Domain entity representing a POS user (manager or cashier).
///
/// Decoupled from the Drift-generated [User] data class. Use cases
/// and cubits work with this entity; the data layer maps to/from it.
class UserEntity extends Equatable {
  final String id;
  final String username;
  final String fullName;
  final String role;
  final String passwordHash;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    required this.passwordHash,
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
    username,
    fullName,
    role,
    passwordHash,
    isActive,
    createdAt,
    updatedAt,
  ];
}
