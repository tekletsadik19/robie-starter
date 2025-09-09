// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LaunchModelImpl _$$LaunchModelImplFromJson(Map<String, dynamic> json) =>
    _$LaunchModelImpl(
      id: json['id'] as String,
      missionName: json['mission_name'] as String,
      launchDateLocal: json['launch_date_local'] as String,
      launchSuccess: json['launch_success'] as bool?,
      launchSite:
          LaunchSiteModel.fromJson(json['launch_site'] as Map<String, dynamic>),
      rocket: RocketModel.fromJson(json['rocket'] as Map<String, dynamic>),
      details: json['details'] as String?,
      links: json['links'] == null
          ? null
          : LinksModel.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LaunchModelImplToJson(_$LaunchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mission_name': instance.missionName,
      'launch_date_local': instance.launchDateLocal,
      'launch_success': instance.launchSuccess,
      'launch_site': instance.launchSite,
      'rocket': instance.rocket,
      'details': instance.details,
      'links': instance.links,
    };

_$LaunchSiteModelImpl _$$LaunchSiteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LaunchSiteModelImpl(
      siteName: json['site_name'] as String,
      siteNameLong: json['site_name_long'] as String,
    );

Map<String, dynamic> _$$LaunchSiteModelImplToJson(
        _$LaunchSiteModelImpl instance) =>
    <String, dynamic>{
      'site_name': instance.siteName,
      'site_name_long': instance.siteNameLong,
    };

_$RocketModelImpl _$$RocketModelImplFromJson(Map<String, dynamic> json) =>
    _$RocketModelImpl(
      id: json['id'] as String,
      rocketName: json['rocket_name'] as String,
      rocketType: json['rocket_type'] as String,
    );

Map<String, dynamic> _$$RocketModelImplToJson(_$RocketModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rocket_name': instance.rocketName,
      'rocket_type': instance.rocketType,
    };

_$LinksModelImpl _$$LinksModelImplFromJson(Map<String, dynamic> json) =>
    _$LinksModelImpl(
      missionPatch: json['mission_patch'] as String?,
      missionPatchSmall: json['mission_patch_small'] as String?,
    );

Map<String, dynamic> _$$LinksModelImplToJson(_$LinksModelImpl instance) =>
    <String, dynamic>{
      'mission_patch': instance.missionPatch,
      'mission_patch_small': instance.missionPatchSmall,
    };
