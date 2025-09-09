// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'launch_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LaunchModel _$LaunchModelFromJson(Map<String, dynamic> json) {
  return _LaunchModel.fromJson(json);
}

/// @nodoc
mixin _$LaunchModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'mission_name')
  String get missionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'launch_date_local')
  String get launchDateLocal => throw _privateConstructorUsedError;
  @JsonKey(name: 'launch_success')
  bool? get launchSuccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'launch_site')
  LaunchSiteModel get launchSite => throw _privateConstructorUsedError;
  RocketModel get rocket => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  @JsonKey(name: 'links')
  LinksModel? get links => throw _privateConstructorUsedError;

  /// Serializes this LaunchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LaunchModelCopyWith<LaunchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaunchModelCopyWith<$Res> {
  factory $LaunchModelCopyWith(
          LaunchModel value, $Res Function(LaunchModel) then) =
      _$LaunchModelCopyWithImpl<$Res, LaunchModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'mission_name') String missionName,
      @JsonKey(name: 'launch_date_local') String launchDateLocal,
      @JsonKey(name: 'launch_success') bool? launchSuccess,
      @JsonKey(name: 'launch_site') LaunchSiteModel launchSite,
      RocketModel rocket,
      String? details,
      @JsonKey(name: 'links') LinksModel? links});

  $LaunchSiteModelCopyWith<$Res> get launchSite;
  $RocketModelCopyWith<$Res> get rocket;
  $LinksModelCopyWith<$Res>? get links;
}

/// @nodoc
class _$LaunchModelCopyWithImpl<$Res, $Val extends LaunchModel>
    implements $LaunchModelCopyWith<$Res> {
  _$LaunchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? missionName = null,
    Object? launchDateLocal = null,
    Object? launchSuccess = freezed,
    Object? launchSite = null,
    Object? rocket = null,
    Object? details = freezed,
    Object? links = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      missionName: null == missionName
          ? _value.missionName
          : missionName // ignore: cast_nullable_to_non_nullable
              as String,
      launchDateLocal: null == launchDateLocal
          ? _value.launchDateLocal
          : launchDateLocal // ignore: cast_nullable_to_non_nullable
              as String,
      launchSuccess: freezed == launchSuccess
          ? _value.launchSuccess
          : launchSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      launchSite: null == launchSite
          ? _value.launchSite
          : launchSite // ignore: cast_nullable_to_non_nullable
              as LaunchSiteModel,
      rocket: null == rocket
          ? _value.rocket
          : rocket // ignore: cast_nullable_to_non_nullable
              as RocketModel,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as LinksModel?,
    ) as $Val);
  }

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LaunchSiteModelCopyWith<$Res> get launchSite {
    return $LaunchSiteModelCopyWith<$Res>(_value.launchSite, (value) {
      return _then(_value.copyWith(launchSite: value) as $Val);
    });
  }

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RocketModelCopyWith<$Res> get rocket {
    return $RocketModelCopyWith<$Res>(_value.rocket, (value) {
      return _then(_value.copyWith(rocket: value) as $Val);
    });
  }

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinksModelCopyWith<$Res>? get links {
    if (_value.links == null) {
      return null;
    }

    return $LinksModelCopyWith<$Res>(_value.links!, (value) {
      return _then(_value.copyWith(links: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LaunchModelImplCopyWith<$Res>
    implements $LaunchModelCopyWith<$Res> {
  factory _$$LaunchModelImplCopyWith(
          _$LaunchModelImpl value, $Res Function(_$LaunchModelImpl) then) =
      __$$LaunchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'mission_name') String missionName,
      @JsonKey(name: 'launch_date_local') String launchDateLocal,
      @JsonKey(name: 'launch_success') bool? launchSuccess,
      @JsonKey(name: 'launch_site') LaunchSiteModel launchSite,
      RocketModel rocket,
      String? details,
      @JsonKey(name: 'links') LinksModel? links});

  @override
  $LaunchSiteModelCopyWith<$Res> get launchSite;
  @override
  $RocketModelCopyWith<$Res> get rocket;
  @override
  $LinksModelCopyWith<$Res>? get links;
}

/// @nodoc
class __$$LaunchModelImplCopyWithImpl<$Res>
    extends _$LaunchModelCopyWithImpl<$Res, _$LaunchModelImpl>
    implements _$$LaunchModelImplCopyWith<$Res> {
  __$$LaunchModelImplCopyWithImpl(
      _$LaunchModelImpl _value, $Res Function(_$LaunchModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? missionName = null,
    Object? launchDateLocal = null,
    Object? launchSuccess = freezed,
    Object? launchSite = null,
    Object? rocket = null,
    Object? details = freezed,
    Object? links = freezed,
  }) {
    return _then(_$LaunchModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      missionName: null == missionName
          ? _value.missionName
          : missionName // ignore: cast_nullable_to_non_nullable
              as String,
      launchDateLocal: null == launchDateLocal
          ? _value.launchDateLocal
          : launchDateLocal // ignore: cast_nullable_to_non_nullable
              as String,
      launchSuccess: freezed == launchSuccess
          ? _value.launchSuccess
          : launchSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      launchSite: null == launchSite
          ? _value.launchSite
          : launchSite // ignore: cast_nullable_to_non_nullable
              as LaunchSiteModel,
      rocket: null == rocket
          ? _value.rocket
          : rocket // ignore: cast_nullable_to_non_nullable
              as RocketModel,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as LinksModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LaunchModelImpl implements _LaunchModel {
  const _$LaunchModelImpl(
      {required this.id,
      @JsonKey(name: 'mission_name') required this.missionName,
      @JsonKey(name: 'launch_date_local') required this.launchDateLocal,
      @JsonKey(name: 'launch_success') required this.launchSuccess,
      @JsonKey(name: 'launch_site') required this.launchSite,
      required this.rocket,
      required this.details,
      @JsonKey(name: 'links') required this.links});

  factory _$LaunchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaunchModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'mission_name')
  final String missionName;
  @override
  @JsonKey(name: 'launch_date_local')
  final String launchDateLocal;
  @override
  @JsonKey(name: 'launch_success')
  final bool? launchSuccess;
  @override
  @JsonKey(name: 'launch_site')
  final LaunchSiteModel launchSite;
  @override
  final RocketModel rocket;
  @override
  final String? details;
  @override
  @JsonKey(name: 'links')
  final LinksModel? links;

  @override
  String toString() {
    return 'LaunchModel(id: $id, missionName: $missionName, launchDateLocal: $launchDateLocal, launchSuccess: $launchSuccess, launchSite: $launchSite, rocket: $rocket, details: $details, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaunchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.missionName, missionName) ||
                other.missionName == missionName) &&
            (identical(other.launchDateLocal, launchDateLocal) ||
                other.launchDateLocal == launchDateLocal) &&
            (identical(other.launchSuccess, launchSuccess) ||
                other.launchSuccess == launchSuccess) &&
            (identical(other.launchSite, launchSite) ||
                other.launchSite == launchSite) &&
            (identical(other.rocket, rocket) || other.rocket == rocket) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.links, links) || other.links == links));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, missionName, launchDateLocal,
      launchSuccess, launchSite, rocket, details, links);

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LaunchModelImplCopyWith<_$LaunchModelImpl> get copyWith =>
      __$$LaunchModelImplCopyWithImpl<_$LaunchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaunchModelImplToJson(
      this,
    );
  }
}

abstract class _LaunchModel implements LaunchModel {
  const factory _LaunchModel(
      {required final String id,
      @JsonKey(name: 'mission_name') required final String missionName,
      @JsonKey(name: 'launch_date_local') required final String launchDateLocal,
      @JsonKey(name: 'launch_success') required final bool? launchSuccess,
      @JsonKey(name: 'launch_site') required final LaunchSiteModel launchSite,
      required final RocketModel rocket,
      required final String? details,
      @JsonKey(name: 'links')
      required final LinksModel? links}) = _$LaunchModelImpl;

  factory _LaunchModel.fromJson(Map<String, dynamic> json) =
      _$LaunchModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'mission_name')
  String get missionName;
  @override
  @JsonKey(name: 'launch_date_local')
  String get launchDateLocal;
  @override
  @JsonKey(name: 'launch_success')
  bool? get launchSuccess;
  @override
  @JsonKey(name: 'launch_site')
  LaunchSiteModel get launchSite;
  @override
  RocketModel get rocket;
  @override
  String? get details;
  @override
  @JsonKey(name: 'links')
  LinksModel? get links;

  /// Create a copy of LaunchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LaunchModelImplCopyWith<_$LaunchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LaunchSiteModel _$LaunchSiteModelFromJson(Map<String, dynamic> json) {
  return _LaunchSiteModel.fromJson(json);
}

/// @nodoc
mixin _$LaunchSiteModel {
  @JsonKey(name: 'site_name')
  String get siteName => throw _privateConstructorUsedError;
  @JsonKey(name: 'site_name_long')
  String get siteNameLong => throw _privateConstructorUsedError;

  /// Serializes this LaunchSiteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LaunchSiteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LaunchSiteModelCopyWith<LaunchSiteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaunchSiteModelCopyWith<$Res> {
  factory $LaunchSiteModelCopyWith(
          LaunchSiteModel value, $Res Function(LaunchSiteModel) then) =
      _$LaunchSiteModelCopyWithImpl<$Res, LaunchSiteModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'site_name') String siteName,
      @JsonKey(name: 'site_name_long') String siteNameLong});
}

/// @nodoc
class _$LaunchSiteModelCopyWithImpl<$Res, $Val extends LaunchSiteModel>
    implements $LaunchSiteModelCopyWith<$Res> {
  _$LaunchSiteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LaunchSiteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? siteName = null,
    Object? siteNameLong = null,
  }) {
    return _then(_value.copyWith(
      siteName: null == siteName
          ? _value.siteName
          : siteName // ignore: cast_nullable_to_non_nullable
              as String,
      siteNameLong: null == siteNameLong
          ? _value.siteNameLong
          : siteNameLong // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LaunchSiteModelImplCopyWith<$Res>
    implements $LaunchSiteModelCopyWith<$Res> {
  factory _$$LaunchSiteModelImplCopyWith(_$LaunchSiteModelImpl value,
          $Res Function(_$LaunchSiteModelImpl) then) =
      __$$LaunchSiteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'site_name') String siteName,
      @JsonKey(name: 'site_name_long') String siteNameLong});
}

/// @nodoc
class __$$LaunchSiteModelImplCopyWithImpl<$Res>
    extends _$LaunchSiteModelCopyWithImpl<$Res, _$LaunchSiteModelImpl>
    implements _$$LaunchSiteModelImplCopyWith<$Res> {
  __$$LaunchSiteModelImplCopyWithImpl(
      _$LaunchSiteModelImpl _value, $Res Function(_$LaunchSiteModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LaunchSiteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? siteName = null,
    Object? siteNameLong = null,
  }) {
    return _then(_$LaunchSiteModelImpl(
      siteName: null == siteName
          ? _value.siteName
          : siteName // ignore: cast_nullable_to_non_nullable
              as String,
      siteNameLong: null == siteNameLong
          ? _value.siteNameLong
          : siteNameLong // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LaunchSiteModelImpl implements _LaunchSiteModel {
  const _$LaunchSiteModelImpl(
      {@JsonKey(name: 'site_name') required this.siteName,
      @JsonKey(name: 'site_name_long') required this.siteNameLong});

  factory _$LaunchSiteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaunchSiteModelImplFromJson(json);

  @override
  @JsonKey(name: 'site_name')
  final String siteName;
  @override
  @JsonKey(name: 'site_name_long')
  final String siteNameLong;

  @override
  String toString() {
    return 'LaunchSiteModel(siteName: $siteName, siteNameLong: $siteNameLong)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaunchSiteModelImpl &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
            (identical(other.siteNameLong, siteNameLong) ||
                other.siteNameLong == siteNameLong));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, siteName, siteNameLong);

  /// Create a copy of LaunchSiteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LaunchSiteModelImplCopyWith<_$LaunchSiteModelImpl> get copyWith =>
      __$$LaunchSiteModelImplCopyWithImpl<_$LaunchSiteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaunchSiteModelImplToJson(
      this,
    );
  }
}

abstract class _LaunchSiteModel implements LaunchSiteModel {
  const factory _LaunchSiteModel(
      {@JsonKey(name: 'site_name') required final String siteName,
      @JsonKey(name: 'site_name_long')
      required final String siteNameLong}) = _$LaunchSiteModelImpl;

  factory _LaunchSiteModel.fromJson(Map<String, dynamic> json) =
      _$LaunchSiteModelImpl.fromJson;

  @override
  @JsonKey(name: 'site_name')
  String get siteName;
  @override
  @JsonKey(name: 'site_name_long')
  String get siteNameLong;

  /// Create a copy of LaunchSiteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LaunchSiteModelImplCopyWith<_$LaunchSiteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RocketModel _$RocketModelFromJson(Map<String, dynamic> json) {
  return _RocketModel.fromJson(json);
}

/// @nodoc
mixin _$RocketModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'rocket_name')
  String get rocketName => throw _privateConstructorUsedError;
  @JsonKey(name: 'rocket_type')
  String get rocketType => throw _privateConstructorUsedError;

  /// Serializes this RocketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RocketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RocketModelCopyWith<RocketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RocketModelCopyWith<$Res> {
  factory $RocketModelCopyWith(
          RocketModel value, $Res Function(RocketModel) then) =
      _$RocketModelCopyWithImpl<$Res, RocketModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'rocket_name') String rocketName,
      @JsonKey(name: 'rocket_type') String rocketType});
}

/// @nodoc
class _$RocketModelCopyWithImpl<$Res, $Val extends RocketModel>
    implements $RocketModelCopyWith<$Res> {
  _$RocketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RocketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? rocketName = null,
    Object? rocketType = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      rocketName: null == rocketName
          ? _value.rocketName
          : rocketName // ignore: cast_nullable_to_non_nullable
              as String,
      rocketType: null == rocketType
          ? _value.rocketType
          : rocketType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RocketModelImplCopyWith<$Res>
    implements $RocketModelCopyWith<$Res> {
  factory _$$RocketModelImplCopyWith(
          _$RocketModelImpl value, $Res Function(_$RocketModelImpl) then) =
      __$$RocketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'rocket_name') String rocketName,
      @JsonKey(name: 'rocket_type') String rocketType});
}

/// @nodoc
class __$$RocketModelImplCopyWithImpl<$Res>
    extends _$RocketModelCopyWithImpl<$Res, _$RocketModelImpl>
    implements _$$RocketModelImplCopyWith<$Res> {
  __$$RocketModelImplCopyWithImpl(
      _$RocketModelImpl _value, $Res Function(_$RocketModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RocketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? rocketName = null,
    Object? rocketType = null,
  }) {
    return _then(_$RocketModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      rocketName: null == rocketName
          ? _value.rocketName
          : rocketName // ignore: cast_nullable_to_non_nullable
              as String,
      rocketType: null == rocketType
          ? _value.rocketType
          : rocketType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RocketModelImpl implements _RocketModel {
  const _$RocketModelImpl(
      {required this.id,
      @JsonKey(name: 'rocket_name') required this.rocketName,
      @JsonKey(name: 'rocket_type') required this.rocketType});

  factory _$RocketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RocketModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'rocket_name')
  final String rocketName;
  @override
  @JsonKey(name: 'rocket_type')
  final String rocketType;

  @override
  String toString() {
    return 'RocketModel(id: $id, rocketName: $rocketName, rocketType: $rocketType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RocketModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.rocketName, rocketName) ||
                other.rocketName == rocketName) &&
            (identical(other.rocketType, rocketType) ||
                other.rocketType == rocketType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, rocketName, rocketType);

  /// Create a copy of RocketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RocketModelImplCopyWith<_$RocketModelImpl> get copyWith =>
      __$$RocketModelImplCopyWithImpl<_$RocketModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RocketModelImplToJson(
      this,
    );
  }
}

abstract class _RocketModel implements RocketModel {
  const factory _RocketModel(
          {required final String id,
          @JsonKey(name: 'rocket_name') required final String rocketName,
          @JsonKey(name: 'rocket_type') required final String rocketType}) =
      _$RocketModelImpl;

  factory _RocketModel.fromJson(Map<String, dynamic> json) =
      _$RocketModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'rocket_name')
  String get rocketName;
  @override
  @JsonKey(name: 'rocket_type')
  String get rocketType;

  /// Create a copy of RocketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RocketModelImplCopyWith<_$RocketModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LinksModel _$LinksModelFromJson(Map<String, dynamic> json) {
  return _LinksModel.fromJson(json);
}

/// @nodoc
mixin _$LinksModel {
  @JsonKey(name: 'mission_patch')
  String? get missionPatch => throw _privateConstructorUsedError;
  @JsonKey(name: 'mission_patch_small')
  String? get missionPatchSmall => throw _privateConstructorUsedError;

  /// Serializes this LinksModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LinksModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinksModelCopyWith<LinksModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinksModelCopyWith<$Res> {
  factory $LinksModelCopyWith(
          LinksModel value, $Res Function(LinksModel) then) =
      _$LinksModelCopyWithImpl<$Res, LinksModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'mission_patch') String? missionPatch,
      @JsonKey(name: 'mission_patch_small') String? missionPatchSmall});
}

/// @nodoc
class _$LinksModelCopyWithImpl<$Res, $Val extends LinksModel>
    implements $LinksModelCopyWith<$Res> {
  _$LinksModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinksModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missionPatch = freezed,
    Object? missionPatchSmall = freezed,
  }) {
    return _then(_value.copyWith(
      missionPatch: freezed == missionPatch
          ? _value.missionPatch
          : missionPatch // ignore: cast_nullable_to_non_nullable
              as String?,
      missionPatchSmall: freezed == missionPatchSmall
          ? _value.missionPatchSmall
          : missionPatchSmall // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinksModelImplCopyWith<$Res>
    implements $LinksModelCopyWith<$Res> {
  factory _$$LinksModelImplCopyWith(
          _$LinksModelImpl value, $Res Function(_$LinksModelImpl) then) =
      __$$LinksModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'mission_patch') String? missionPatch,
      @JsonKey(name: 'mission_patch_small') String? missionPatchSmall});
}

/// @nodoc
class __$$LinksModelImplCopyWithImpl<$Res>
    extends _$LinksModelCopyWithImpl<$Res, _$LinksModelImpl>
    implements _$$LinksModelImplCopyWith<$Res> {
  __$$LinksModelImplCopyWithImpl(
      _$LinksModelImpl _value, $Res Function(_$LinksModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinksModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missionPatch = freezed,
    Object? missionPatchSmall = freezed,
  }) {
    return _then(_$LinksModelImpl(
      missionPatch: freezed == missionPatch
          ? _value.missionPatch
          : missionPatch // ignore: cast_nullable_to_non_nullable
              as String?,
      missionPatchSmall: freezed == missionPatchSmall
          ? _value.missionPatchSmall
          : missionPatchSmall // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinksModelImpl implements _LinksModel {
  const _$LinksModelImpl(
      {@JsonKey(name: 'mission_patch') required this.missionPatch,
      @JsonKey(name: 'mission_patch_small') required this.missionPatchSmall});

  factory _$LinksModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinksModelImplFromJson(json);

  @override
  @JsonKey(name: 'mission_patch')
  final String? missionPatch;
  @override
  @JsonKey(name: 'mission_patch_small')
  final String? missionPatchSmall;

  @override
  String toString() {
    return 'LinksModel(missionPatch: $missionPatch, missionPatchSmall: $missionPatchSmall)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinksModelImpl &&
            (identical(other.missionPatch, missionPatch) ||
                other.missionPatch == missionPatch) &&
            (identical(other.missionPatchSmall, missionPatchSmall) ||
                other.missionPatchSmall == missionPatchSmall));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, missionPatch, missionPatchSmall);

  /// Create a copy of LinksModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinksModelImplCopyWith<_$LinksModelImpl> get copyWith =>
      __$$LinksModelImplCopyWithImpl<_$LinksModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinksModelImplToJson(
      this,
    );
  }
}

abstract class _LinksModel implements LinksModel {
  const factory _LinksModel(
      {@JsonKey(name: 'mission_patch') required final String? missionPatch,
      @JsonKey(name: 'mission_patch_small')
      required final String? missionPatchSmall}) = _$LinksModelImpl;

  factory _LinksModel.fromJson(Map<String, dynamic> json) =
      _$LinksModelImpl.fromJson;

  @override
  @JsonKey(name: 'mission_patch')
  String? get missionPatch;
  @override
  @JsonKey(name: 'mission_patch_small')
  String? get missionPatchSmall;

  /// Create a copy of LinksModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinksModelImplCopyWith<_$LinksModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
