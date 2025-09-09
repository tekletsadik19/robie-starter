import 'package:robbie_starter/shared/domain/entities/base_entity.dart';

/// Counter domain entity
class CounterEntity extends BaseEntity {
  const CounterEntity({
    required super.id,
    required this.value,
    required this.createdAt,
    this.updatedAt,
  });

  /// Current counter value
  final int value;

  /// When the counter was created
  final DateTime createdAt;

  /// When the counter was last updated
  final DateTime? updatedAt;

  /// Create a new counter with incremented value
  CounterEntity increment() => CounterEntity(
        id: id,
        value: value + 1,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );

  /// Create a new counter with decremented value
  CounterEntity decrement() => CounterEntity(
        id: id,
        value: value - 1,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );

  /// Reset counter to zero
  CounterEntity reset() => CounterEntity(
        id: id,
        value: 0,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [id, value, createdAt, updatedAt];

  @override
  String toString() => 'CounterEntity(id: $id, value: $value, '
      'createdAt: $createdAt, updatedAt: $updatedAt)';
}
