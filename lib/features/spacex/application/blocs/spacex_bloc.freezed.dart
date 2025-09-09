// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spacex_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SpaceXEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int limit, int offset) loadPastLaunches,
    required TResult Function(int limit, int offset) loadUpcomingLaunches,
    required TResult Function() loadLatestLaunch,
    required TResult Function() loadAllData,
    required TResult Function() refreshData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int limit, int offset)? loadPastLaunches,
    TResult? Function(int limit, int offset)? loadUpcomingLaunches,
    TResult? Function()? loadLatestLaunch,
    TResult? Function()? loadAllData,
    TResult? Function()? refreshData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int limit, int offset)? loadPastLaunches,
    TResult Function(int limit, int offset)? loadUpcomingLaunches,
    TResult Function()? loadLatestLaunch,
    TResult Function()? loadAllData,
    TResult Function()? refreshData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPastLaunches value) loadPastLaunches,
    required TResult Function(_LoadUpcomingLaunches value) loadUpcomingLaunches,
    required TResult Function(_LoadLatestLaunch value) loadLatestLaunch,
    required TResult Function(_LoadAllData value) loadAllData,
    required TResult Function(_RefreshData value) refreshData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult? Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult? Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult? Function(_LoadAllData value)? loadAllData,
    TResult? Function(_RefreshData value)? refreshData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult Function(_LoadAllData value)? loadAllData,
    TResult Function(_RefreshData value)? refreshData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceXEventCopyWith<$Res> {
  factory $SpaceXEventCopyWith(
          SpaceXEvent value, $Res Function(SpaceXEvent) then) =
      _$SpaceXEventCopyWithImpl<$Res, SpaceXEvent>;
}

/// @nodoc
class _$SpaceXEventCopyWithImpl<$Res, $Val extends SpaceXEvent>
    implements $SpaceXEventCopyWith<$Res> {
  _$SpaceXEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadPastLaunchesImplCopyWith<$Res> {
  factory _$$LoadPastLaunchesImplCopyWith(_$LoadPastLaunchesImpl value,
          $Res Function(_$LoadPastLaunchesImpl) then) =
      __$$LoadPastLaunchesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int limit, int offset});
}

/// @nodoc
class __$$LoadPastLaunchesImplCopyWithImpl<$Res>
    extends _$SpaceXEventCopyWithImpl<$Res, _$LoadPastLaunchesImpl>
    implements _$$LoadPastLaunchesImplCopyWith<$Res> {
  __$$LoadPastLaunchesImplCopyWithImpl(_$LoadPastLaunchesImpl _value,
      $Res Function(_$LoadPastLaunchesImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(_$LoadPastLaunchesImpl(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadPastLaunchesImpl implements _LoadPastLaunches {
  const _$LoadPastLaunchesImpl({this.limit = 10, this.offset = 0});

  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'SpaceXEvent.loadPastLaunches(limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPastLaunchesImpl &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit, offset);

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadPastLaunchesImplCopyWith<_$LoadPastLaunchesImpl> get copyWith =>
      __$$LoadPastLaunchesImplCopyWithImpl<_$LoadPastLaunchesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int limit, int offset) loadPastLaunches,
    required TResult Function(int limit, int offset) loadUpcomingLaunches,
    required TResult Function() loadLatestLaunch,
    required TResult Function() loadAllData,
    required TResult Function() refreshData,
  }) {
    return loadPastLaunches(limit, offset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int limit, int offset)? loadPastLaunches,
    TResult? Function(int limit, int offset)? loadUpcomingLaunches,
    TResult? Function()? loadLatestLaunch,
    TResult? Function()? loadAllData,
    TResult? Function()? refreshData,
  }) {
    return loadPastLaunches?.call(limit, offset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int limit, int offset)? loadPastLaunches,
    TResult Function(int limit, int offset)? loadUpcomingLaunches,
    TResult Function()? loadLatestLaunch,
    TResult Function()? loadAllData,
    TResult Function()? refreshData,
    required TResult orElse(),
  }) {
    if (loadPastLaunches != null) {
      return loadPastLaunches(limit, offset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPastLaunches value) loadPastLaunches,
    required TResult Function(_LoadUpcomingLaunches value) loadUpcomingLaunches,
    required TResult Function(_LoadLatestLaunch value) loadLatestLaunch,
    required TResult Function(_LoadAllData value) loadAllData,
    required TResult Function(_RefreshData value) refreshData,
  }) {
    return loadPastLaunches(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult? Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult? Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult? Function(_LoadAllData value)? loadAllData,
    TResult? Function(_RefreshData value)? refreshData,
  }) {
    return loadPastLaunches?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult Function(_LoadAllData value)? loadAllData,
    TResult Function(_RefreshData value)? refreshData,
    required TResult orElse(),
  }) {
    if (loadPastLaunches != null) {
      return loadPastLaunches(this);
    }
    return orElse();
  }
}

abstract class _LoadPastLaunches implements SpaceXEvent {
  const factory _LoadPastLaunches({final int limit, final int offset}) =
      _$LoadPastLaunchesImpl;

  int get limit;
  int get offset;

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadPastLaunchesImplCopyWith<_$LoadPastLaunchesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadUpcomingLaunchesImplCopyWith<$Res> {
  factory _$$LoadUpcomingLaunchesImplCopyWith(_$LoadUpcomingLaunchesImpl value,
          $Res Function(_$LoadUpcomingLaunchesImpl) then) =
      __$$LoadUpcomingLaunchesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int limit, int offset});
}

/// @nodoc
class __$$LoadUpcomingLaunchesImplCopyWithImpl<$Res>
    extends _$SpaceXEventCopyWithImpl<$Res, _$LoadUpcomingLaunchesImpl>
    implements _$$LoadUpcomingLaunchesImplCopyWith<$Res> {
  __$$LoadUpcomingLaunchesImplCopyWithImpl(_$LoadUpcomingLaunchesImpl _value,
      $Res Function(_$LoadUpcomingLaunchesImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(_$LoadUpcomingLaunchesImpl(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadUpcomingLaunchesImpl implements _LoadUpcomingLaunches {
  const _$LoadUpcomingLaunchesImpl({this.limit = 10, this.offset = 0});

  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'SpaceXEvent.loadUpcomingLaunches(limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadUpcomingLaunchesImpl &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit, offset);

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadUpcomingLaunchesImplCopyWith<_$LoadUpcomingLaunchesImpl>
      get copyWith =>
          __$$LoadUpcomingLaunchesImplCopyWithImpl<_$LoadUpcomingLaunchesImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int limit, int offset) loadPastLaunches,
    required TResult Function(int limit, int offset) loadUpcomingLaunches,
    required TResult Function() loadLatestLaunch,
    required TResult Function() loadAllData,
    required TResult Function() refreshData,
  }) {
    return loadUpcomingLaunches(limit, offset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int limit, int offset)? loadPastLaunches,
    TResult? Function(int limit, int offset)? loadUpcomingLaunches,
    TResult? Function()? loadLatestLaunch,
    TResult? Function()? loadAllData,
    TResult? Function()? refreshData,
  }) {
    return loadUpcomingLaunches?.call(limit, offset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int limit, int offset)? loadPastLaunches,
    TResult Function(int limit, int offset)? loadUpcomingLaunches,
    TResult Function()? loadLatestLaunch,
    TResult Function()? loadAllData,
    TResult Function()? refreshData,
    required TResult orElse(),
  }) {
    if (loadUpcomingLaunches != null) {
      return loadUpcomingLaunches(limit, offset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPastLaunches value) loadPastLaunches,
    required TResult Function(_LoadUpcomingLaunches value) loadUpcomingLaunches,
    required TResult Function(_LoadLatestLaunch value) loadLatestLaunch,
    required TResult Function(_LoadAllData value) loadAllData,
    required TResult Function(_RefreshData value) refreshData,
  }) {
    return loadUpcomingLaunches(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult? Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult? Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult? Function(_LoadAllData value)? loadAllData,
    TResult? Function(_RefreshData value)? refreshData,
  }) {
    return loadUpcomingLaunches?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult Function(_LoadAllData value)? loadAllData,
    TResult Function(_RefreshData value)? refreshData,
    required TResult orElse(),
  }) {
    if (loadUpcomingLaunches != null) {
      return loadUpcomingLaunches(this);
    }
    return orElse();
  }
}

abstract class _LoadUpcomingLaunches implements SpaceXEvent {
  const factory _LoadUpcomingLaunches({final int limit, final int offset}) =
      _$LoadUpcomingLaunchesImpl;

  int get limit;
  int get offset;

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadUpcomingLaunchesImplCopyWith<_$LoadUpcomingLaunchesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadLatestLaunchImplCopyWith<$Res> {
  factory _$$LoadLatestLaunchImplCopyWith(_$LoadLatestLaunchImpl value,
          $Res Function(_$LoadLatestLaunchImpl) then) =
      __$$LoadLatestLaunchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadLatestLaunchImplCopyWithImpl<$Res>
    extends _$SpaceXEventCopyWithImpl<$Res, _$LoadLatestLaunchImpl>
    implements _$$LoadLatestLaunchImplCopyWith<$Res> {
  __$$LoadLatestLaunchImplCopyWithImpl(_$LoadLatestLaunchImpl _value,
      $Res Function(_$LoadLatestLaunchImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadLatestLaunchImpl implements _LoadLatestLaunch {
  const _$LoadLatestLaunchImpl();

  @override
  String toString() {
    return 'SpaceXEvent.loadLatestLaunch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadLatestLaunchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int limit, int offset) loadPastLaunches,
    required TResult Function(int limit, int offset) loadUpcomingLaunches,
    required TResult Function() loadLatestLaunch,
    required TResult Function() loadAllData,
    required TResult Function() refreshData,
  }) {
    return loadLatestLaunch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int limit, int offset)? loadPastLaunches,
    TResult? Function(int limit, int offset)? loadUpcomingLaunches,
    TResult? Function()? loadLatestLaunch,
    TResult? Function()? loadAllData,
    TResult? Function()? refreshData,
  }) {
    return loadLatestLaunch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int limit, int offset)? loadPastLaunches,
    TResult Function(int limit, int offset)? loadUpcomingLaunches,
    TResult Function()? loadLatestLaunch,
    TResult Function()? loadAllData,
    TResult Function()? refreshData,
    required TResult orElse(),
  }) {
    if (loadLatestLaunch != null) {
      return loadLatestLaunch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPastLaunches value) loadPastLaunches,
    required TResult Function(_LoadUpcomingLaunches value) loadUpcomingLaunches,
    required TResult Function(_LoadLatestLaunch value) loadLatestLaunch,
    required TResult Function(_LoadAllData value) loadAllData,
    required TResult Function(_RefreshData value) refreshData,
  }) {
    return loadLatestLaunch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult? Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult? Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult? Function(_LoadAllData value)? loadAllData,
    TResult? Function(_RefreshData value)? refreshData,
  }) {
    return loadLatestLaunch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult Function(_LoadAllData value)? loadAllData,
    TResult Function(_RefreshData value)? refreshData,
    required TResult orElse(),
  }) {
    if (loadLatestLaunch != null) {
      return loadLatestLaunch(this);
    }
    return orElse();
  }
}

abstract class _LoadLatestLaunch implements SpaceXEvent {
  const factory _LoadLatestLaunch() = _$LoadLatestLaunchImpl;
}

/// @nodoc
abstract class _$$LoadAllDataImplCopyWith<$Res> {
  factory _$$LoadAllDataImplCopyWith(
          _$LoadAllDataImpl value, $Res Function(_$LoadAllDataImpl) then) =
      __$$LoadAllDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadAllDataImplCopyWithImpl<$Res>
    extends _$SpaceXEventCopyWithImpl<$Res, _$LoadAllDataImpl>
    implements _$$LoadAllDataImplCopyWith<$Res> {
  __$$LoadAllDataImplCopyWithImpl(
      _$LoadAllDataImpl _value, $Res Function(_$LoadAllDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadAllDataImpl implements _LoadAllData {
  const _$LoadAllDataImpl();

  @override
  String toString() {
    return 'SpaceXEvent.loadAllData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadAllDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int limit, int offset) loadPastLaunches,
    required TResult Function(int limit, int offset) loadUpcomingLaunches,
    required TResult Function() loadLatestLaunch,
    required TResult Function() loadAllData,
    required TResult Function() refreshData,
  }) {
    return loadAllData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int limit, int offset)? loadPastLaunches,
    TResult? Function(int limit, int offset)? loadUpcomingLaunches,
    TResult? Function()? loadLatestLaunch,
    TResult? Function()? loadAllData,
    TResult? Function()? refreshData,
  }) {
    return loadAllData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int limit, int offset)? loadPastLaunches,
    TResult Function(int limit, int offset)? loadUpcomingLaunches,
    TResult Function()? loadLatestLaunch,
    TResult Function()? loadAllData,
    TResult Function()? refreshData,
    required TResult orElse(),
  }) {
    if (loadAllData != null) {
      return loadAllData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPastLaunches value) loadPastLaunches,
    required TResult Function(_LoadUpcomingLaunches value) loadUpcomingLaunches,
    required TResult Function(_LoadLatestLaunch value) loadLatestLaunch,
    required TResult Function(_LoadAllData value) loadAllData,
    required TResult Function(_RefreshData value) refreshData,
  }) {
    return loadAllData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult? Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult? Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult? Function(_LoadAllData value)? loadAllData,
    TResult? Function(_RefreshData value)? refreshData,
  }) {
    return loadAllData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult Function(_LoadAllData value)? loadAllData,
    TResult Function(_RefreshData value)? refreshData,
    required TResult orElse(),
  }) {
    if (loadAllData != null) {
      return loadAllData(this);
    }
    return orElse();
  }
}

abstract class _LoadAllData implements SpaceXEvent {
  const factory _LoadAllData() = _$LoadAllDataImpl;
}

/// @nodoc
abstract class _$$RefreshDataImplCopyWith<$Res> {
  factory _$$RefreshDataImplCopyWith(
          _$RefreshDataImpl value, $Res Function(_$RefreshDataImpl) then) =
      __$$RefreshDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshDataImplCopyWithImpl<$Res>
    extends _$SpaceXEventCopyWithImpl<$Res, _$RefreshDataImpl>
    implements _$$RefreshDataImplCopyWith<$Res> {
  __$$RefreshDataImplCopyWithImpl(
      _$RefreshDataImpl _value, $Res Function(_$RefreshDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceXEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshDataImpl implements _RefreshData {
  const _$RefreshDataImpl();

  @override
  String toString() {
    return 'SpaceXEvent.refreshData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int limit, int offset) loadPastLaunches,
    required TResult Function(int limit, int offset) loadUpcomingLaunches,
    required TResult Function() loadLatestLaunch,
    required TResult Function() loadAllData,
    required TResult Function() refreshData,
  }) {
    return refreshData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int limit, int offset)? loadPastLaunches,
    TResult? Function(int limit, int offset)? loadUpcomingLaunches,
    TResult? Function()? loadLatestLaunch,
    TResult? Function()? loadAllData,
    TResult? Function()? refreshData,
  }) {
    return refreshData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int limit, int offset)? loadPastLaunches,
    TResult Function(int limit, int offset)? loadUpcomingLaunches,
    TResult Function()? loadLatestLaunch,
    TResult Function()? loadAllData,
    TResult Function()? refreshData,
    required TResult orElse(),
  }) {
    if (refreshData != null) {
      return refreshData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPastLaunches value) loadPastLaunches,
    required TResult Function(_LoadUpcomingLaunches value) loadUpcomingLaunches,
    required TResult Function(_LoadLatestLaunch value) loadLatestLaunch,
    required TResult Function(_LoadAllData value) loadAllData,
    required TResult Function(_RefreshData value) refreshData,
  }) {
    return refreshData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult? Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult? Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult? Function(_LoadAllData value)? loadAllData,
    TResult? Function(_RefreshData value)? refreshData,
  }) {
    return refreshData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPastLaunches value)? loadPastLaunches,
    TResult Function(_LoadUpcomingLaunches value)? loadUpcomingLaunches,
    TResult Function(_LoadLatestLaunch value)? loadLatestLaunch,
    TResult Function(_LoadAllData value)? loadAllData,
    TResult Function(_RefreshData value)? refreshData,
    required TResult orElse(),
  }) {
    if (refreshData != null) {
      return refreshData(this);
    }
    return orElse();
  }
}

abstract class _RefreshData implements SpaceXEvent {
  const factory _RefreshData() = _$RefreshDataImpl;
}

/// @nodoc
mixin _$SpaceXState {
  SpaceXStatus get pastLaunchesStatus => throw _privateConstructorUsedError;
  SpaceXStatus get upcomingLaunchesStatus => throw _privateConstructorUsedError;
  SpaceXStatus get latestLaunchStatus => throw _privateConstructorUsedError;
  List<LaunchEntity> get pastLaunches => throw _privateConstructorUsedError;
  List<LaunchEntity> get upcomingLaunches => throw _privateConstructorUsedError;
  LaunchEntity? get latestLaunch => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of SpaceXState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpaceXStateCopyWith<SpaceXState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceXStateCopyWith<$Res> {
  factory $SpaceXStateCopyWith(
          SpaceXState value, $Res Function(SpaceXState) then) =
      _$SpaceXStateCopyWithImpl<$Res, SpaceXState>;
  @useResult
  $Res call(
      {SpaceXStatus pastLaunchesStatus,
      SpaceXStatus upcomingLaunchesStatus,
      SpaceXStatus latestLaunchStatus,
      List<LaunchEntity> pastLaunches,
      List<LaunchEntity> upcomingLaunches,
      LaunchEntity? latestLaunch,
      String? errorMessage});
}

/// @nodoc
class _$SpaceXStateCopyWithImpl<$Res, $Val extends SpaceXState>
    implements $SpaceXStateCopyWith<$Res> {
  _$SpaceXStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpaceXState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pastLaunchesStatus = null,
    Object? upcomingLaunchesStatus = null,
    Object? latestLaunchStatus = null,
    Object? pastLaunches = null,
    Object? upcomingLaunches = null,
    Object? latestLaunch = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      pastLaunchesStatus: null == pastLaunchesStatus
          ? _value.pastLaunchesStatus
          : pastLaunchesStatus // ignore: cast_nullable_to_non_nullable
              as SpaceXStatus,
      upcomingLaunchesStatus: null == upcomingLaunchesStatus
          ? _value.upcomingLaunchesStatus
          : upcomingLaunchesStatus // ignore: cast_nullable_to_non_nullable
              as SpaceXStatus,
      latestLaunchStatus: null == latestLaunchStatus
          ? _value.latestLaunchStatus
          : latestLaunchStatus // ignore: cast_nullable_to_non_nullable
              as SpaceXStatus,
      pastLaunches: null == pastLaunches
          ? _value.pastLaunches
          : pastLaunches // ignore: cast_nullable_to_non_nullable
              as List<LaunchEntity>,
      upcomingLaunches: null == upcomingLaunches
          ? _value.upcomingLaunches
          : upcomingLaunches // ignore: cast_nullable_to_non_nullable
              as List<LaunchEntity>,
      latestLaunch: freezed == latestLaunch
          ? _value.latestLaunch
          : latestLaunch // ignore: cast_nullable_to_non_nullable
              as LaunchEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpaceXStateImplCopyWith<$Res>
    implements $SpaceXStateCopyWith<$Res> {
  factory _$$SpaceXStateImplCopyWith(
          _$SpaceXStateImpl value, $Res Function(_$SpaceXStateImpl) then) =
      __$$SpaceXStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SpaceXStatus pastLaunchesStatus,
      SpaceXStatus upcomingLaunchesStatus,
      SpaceXStatus latestLaunchStatus,
      List<LaunchEntity> pastLaunches,
      List<LaunchEntity> upcomingLaunches,
      LaunchEntity? latestLaunch,
      String? errorMessage});
}

/// @nodoc
class __$$SpaceXStateImplCopyWithImpl<$Res>
    extends _$SpaceXStateCopyWithImpl<$Res, _$SpaceXStateImpl>
    implements _$$SpaceXStateImplCopyWith<$Res> {
  __$$SpaceXStateImplCopyWithImpl(
      _$SpaceXStateImpl _value, $Res Function(_$SpaceXStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceXState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pastLaunchesStatus = null,
    Object? upcomingLaunchesStatus = null,
    Object? latestLaunchStatus = null,
    Object? pastLaunches = null,
    Object? upcomingLaunches = null,
    Object? latestLaunch = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$SpaceXStateImpl(
      pastLaunchesStatus: null == pastLaunchesStatus
          ? _value.pastLaunchesStatus
          : pastLaunchesStatus // ignore: cast_nullable_to_non_nullable
              as SpaceXStatus,
      upcomingLaunchesStatus: null == upcomingLaunchesStatus
          ? _value.upcomingLaunchesStatus
          : upcomingLaunchesStatus // ignore: cast_nullable_to_non_nullable
              as SpaceXStatus,
      latestLaunchStatus: null == latestLaunchStatus
          ? _value.latestLaunchStatus
          : latestLaunchStatus // ignore: cast_nullable_to_non_nullable
              as SpaceXStatus,
      pastLaunches: null == pastLaunches
          ? _value._pastLaunches
          : pastLaunches // ignore: cast_nullable_to_non_nullable
              as List<LaunchEntity>,
      upcomingLaunches: null == upcomingLaunches
          ? _value._upcomingLaunches
          : upcomingLaunches // ignore: cast_nullable_to_non_nullable
              as List<LaunchEntity>,
      latestLaunch: freezed == latestLaunch
          ? _value.latestLaunch
          : latestLaunch // ignore: cast_nullable_to_non_nullable
              as LaunchEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SpaceXStateImpl extends _SpaceXState {
  const _$SpaceXStateImpl(
      {this.pastLaunchesStatus = SpaceXStatus.initial,
      this.upcomingLaunchesStatus = SpaceXStatus.initial,
      this.latestLaunchStatus = SpaceXStatus.initial,
      final List<LaunchEntity> pastLaunches = const [],
      final List<LaunchEntity> upcomingLaunches = const [],
      this.latestLaunch,
      this.errorMessage})
      : _pastLaunches = pastLaunches,
        _upcomingLaunches = upcomingLaunches,
        super._();

  @override
  @JsonKey()
  final SpaceXStatus pastLaunchesStatus;
  @override
  @JsonKey()
  final SpaceXStatus upcomingLaunchesStatus;
  @override
  @JsonKey()
  final SpaceXStatus latestLaunchStatus;
  final List<LaunchEntity> _pastLaunches;
  @override
  @JsonKey()
  List<LaunchEntity> get pastLaunches {
    if (_pastLaunches is EqualUnmodifiableListView) return _pastLaunches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pastLaunches);
  }

  final List<LaunchEntity> _upcomingLaunches;
  @override
  @JsonKey()
  List<LaunchEntity> get upcomingLaunches {
    if (_upcomingLaunches is EqualUnmodifiableListView)
      return _upcomingLaunches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingLaunches);
  }

  @override
  final LaunchEntity? latestLaunch;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SpaceXState(pastLaunchesStatus: $pastLaunchesStatus, upcomingLaunchesStatus: $upcomingLaunchesStatus, latestLaunchStatus: $latestLaunchStatus, pastLaunches: $pastLaunches, upcomingLaunches: $upcomingLaunches, latestLaunch: $latestLaunch, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpaceXStateImpl &&
            (identical(other.pastLaunchesStatus, pastLaunchesStatus) ||
                other.pastLaunchesStatus == pastLaunchesStatus) &&
            (identical(other.upcomingLaunchesStatus, upcomingLaunchesStatus) ||
                other.upcomingLaunchesStatus == upcomingLaunchesStatus) &&
            (identical(other.latestLaunchStatus, latestLaunchStatus) ||
                other.latestLaunchStatus == latestLaunchStatus) &&
            const DeepCollectionEquality()
                .equals(other._pastLaunches, _pastLaunches) &&
            const DeepCollectionEquality()
                .equals(other._upcomingLaunches, _upcomingLaunches) &&
            (identical(other.latestLaunch, latestLaunch) ||
                other.latestLaunch == latestLaunch) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pastLaunchesStatus,
      upcomingLaunchesStatus,
      latestLaunchStatus,
      const DeepCollectionEquality().hash(_pastLaunches),
      const DeepCollectionEquality().hash(_upcomingLaunches),
      latestLaunch,
      errorMessage);

  /// Create a copy of SpaceXState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpaceXStateImplCopyWith<_$SpaceXStateImpl> get copyWith =>
      __$$SpaceXStateImplCopyWithImpl<_$SpaceXStateImpl>(this, _$identity);
}

abstract class _SpaceXState extends SpaceXState {
  const factory _SpaceXState(
      {final SpaceXStatus pastLaunchesStatus,
      final SpaceXStatus upcomingLaunchesStatus,
      final SpaceXStatus latestLaunchStatus,
      final List<LaunchEntity> pastLaunches,
      final List<LaunchEntity> upcomingLaunches,
      final LaunchEntity? latestLaunch,
      final String? errorMessage}) = _$SpaceXStateImpl;
  const _SpaceXState._() : super._();

  @override
  SpaceXStatus get pastLaunchesStatus;
  @override
  SpaceXStatus get upcomingLaunchesStatus;
  @override
  SpaceXStatus get latestLaunchStatus;
  @override
  List<LaunchEntity> get pastLaunches;
  @override
  List<LaunchEntity> get upcomingLaunches;
  @override
  LaunchEntity? get latestLaunch;
  @override
  String? get errorMessage;

  /// Create a copy of SpaceXState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpaceXStateImplCopyWith<_$SpaceXStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
