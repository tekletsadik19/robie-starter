import 'package:equatable/equatable.dart';

/// Base class for all domain entities
abstract class BaseEntity extends Equatable {
  const BaseEntity({required this.id});

  /// Unique identifier for the entity
  final String id;

  @override
  List<Object?> get props => [id];
}
