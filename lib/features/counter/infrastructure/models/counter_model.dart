import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shemanit/features/counter/domain/entities/counter_entity.dart';

part 'counter_model.freezed.dart';
part 'counter_model.g.dart';

/// Data model for counter serialization
@freezed
class CounterModel with _$CounterModel {
  const factory CounterModel({
    required String id,
    required int value,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _CounterModel;

  /// Create from domain entity
  factory CounterModel.fromEntity(CounterEntity entity) => CounterModel(
        id: entity.id,
        value: entity.value,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  factory CounterModel.fromJson(Map<String, dynamic> json) =>
      _$CounterModelFromJson(json);

  const CounterModel._();

  /// Convert to domain entity
  CounterEntity toEntity() => CounterEntity(
        id: id,
        value: value,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
