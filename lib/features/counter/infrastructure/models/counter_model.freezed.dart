// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CounterModel _$CounterModelFromJson(Map<String, dynamic> json) {
  return _CounterModel.fromJson(json);
}

/// @nodoc
mixin _$CounterModel {
  String get id => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CounterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CounterModelCopyWith<CounterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterModelCopyWith<$Res> {
  factory $CounterModelCopyWith(
          CounterModel value, $Res Function(CounterModel) then) =
      _$CounterModelCopyWithImpl<$Res, CounterModel>;
  @useResult
  $Res call({String id, int value, DateTime createdAt, DateTime? updatedAt});
}

/// @nodoc
class _$CounterModelCopyWithImpl<$Res, $Val extends CounterModel>
    implements $CounterModelCopyWith<$Res> {
  _$CounterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CounterModelImplCopyWith<$Res>
    implements $CounterModelCopyWith<$Res> {
  factory _$$CounterModelImplCopyWith(
          _$CounterModelImpl value, $Res Function(_$CounterModelImpl) then) =
      __$$CounterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int value, DateTime createdAt, DateTime? updatedAt});
}

/// @nodoc
class __$$CounterModelImplCopyWithImpl<$Res>
    extends _$CounterModelCopyWithImpl<$Res, _$CounterModelImpl>
    implements _$$CounterModelImplCopyWith<$Res> {
  __$$CounterModelImplCopyWithImpl(
      _$CounterModelImpl _value, $Res Function(_$CounterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CounterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CounterModelImpl extends _CounterModel {
  const _$CounterModelImpl(
      {required this.id,
      required this.value,
      required this.createdAt,
      this.updatedAt})
      : super._();

  factory _$CounterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CounterModelImplFromJson(json);

  @override
  final String id;
  @override
  final int value;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CounterModel(id: $id, value: $value, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, value, createdAt, updatedAt);

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterModelImplCopyWith<_$CounterModelImpl> get copyWith =>
      __$$CounterModelImplCopyWithImpl<_$CounterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CounterModelImplToJson(
      this,
    );
  }
}

abstract class _CounterModel extends CounterModel {
  const factory _CounterModel(
      {required final String id,
      required final int value,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$CounterModelImpl;
  const _CounterModel._() : super._();

  factory _CounterModel.fromJson(Map<String, dynamic> json) =
      _$CounterModelImpl.fromJson;

  @override
  String get id;
  @override
  int get value;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CounterModelImplCopyWith<_$CounterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
