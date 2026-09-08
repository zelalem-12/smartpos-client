import 'package:equatable/equatable.dart';

/// Domain entity representing a product category.
class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    isActive,
    createdAt,
    updatedAt,
  ];
}
