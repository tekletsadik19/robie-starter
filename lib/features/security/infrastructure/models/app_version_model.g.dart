// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppVersionModelImpl _$$AppVersionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AppVersionModelImpl(
      currentVersion: json['currentVersion'] as String,
      latestVersion: json['latestVersion'] as String,
      minimumSupportedVersion: json['minimumSupportedVersion'] as String,
      forceUpdate: json['forceUpdate'] as bool,
      recommendUpdate: json['recommendUpdate'] as bool,
      updateMessage: json['updateMessage'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      releaseNotes: (json['releaseNotes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$AppVersionModelImplToJson(
        _$AppVersionModelImpl instance) =>
    <String, dynamic>{
      'currentVersion': instance.currentVersion,
      'latestVersion': instance.latestVersion,
      'minimumSupportedVersion': instance.minimumSupportedVersion,
      'forceUpdate': instance.forceUpdate,
      'recommendUpdate': instance.recommendUpdate,
      'updateMessage': instance.updateMessage,
      'downloadUrl': instance.downloadUrl,
      'releaseNotes': instance.releaseNotes,
    };
