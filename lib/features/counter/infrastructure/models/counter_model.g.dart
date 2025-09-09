// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CounterModelImpl _$$CounterModelImplFromJson(Map<String, dynamic> json) =>
    _$CounterModelImpl(
      id: json['id'] as String,
      value: (json['value'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CounterModelImplToJson(_$CounterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
