import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_date.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_site.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/mission_name.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/rocket_info.dart';

part 'launch_model.freezed.dart';
part 'launch_model.g.dart';

/// Model for SpaceX launch data from GraphQL API
@freezed
class LaunchModel with _$LaunchModel {
  const factory LaunchModel({
    required String id,
    @JsonKey(name: 'mission_name') required String missionName,
    @JsonKey(name: 'launch_date_local') required String launchDateLocal,
    @JsonKey(name: 'launch_success') required bool? launchSuccess,
    @JsonKey(name: 'launch_site') required LaunchSiteModel launchSite,
    required RocketModel rocket,
    required String? details,
    @JsonKey(name: 'links') required LinksModel? links,
  }) = _LaunchModel;

  factory LaunchModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchModelFromJson(json);
}

/// Model for launch site data
@freezed
class LaunchSiteModel with _$LaunchSiteModel {
  const factory LaunchSiteModel({
    @JsonKey(name: 'site_name') required String siteName,
    @JsonKey(name: 'site_name_long') required String siteNameLong,
  }) = _LaunchSiteModel;

  factory LaunchSiteModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchSiteModelFromJson(json);
}

/// Model for rocket data
@freezed
class RocketModel with _$RocketModel {
  const factory RocketModel({
    required String id,
    @JsonKey(name: 'rocket_name') required String rocketName,
    @JsonKey(name: 'rocket_type') required String rocketType,
  }) = _RocketModel;

  factory RocketModel.fromJson(Map<String, dynamic> json) =>
      _$RocketModelFromJson(json);
}

/// Model for links data
@freezed
class LinksModel with _$LinksModel {
  const factory LinksModel({
    @JsonKey(name: 'mission_patch') required String? missionPatch,
    @JsonKey(name: 'mission_patch_small') required String? missionPatchSmall,
  }) = _LinksModel;

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);
}

/// Extension to convert model to domain entity
extension LaunchModelX on LaunchModel {
  LaunchEntity toDomain() {
    return LaunchEntity(
      id: id,
      missionName: MissionName(missionName),
      launchDate: LaunchDate.fromString(launchDateLocal),
      launchSite: LaunchSite(
        name: launchSite.siteName,
        longName: launchSite.siteNameLong,
      ),
      rocket: RocketInfo(
        id: rocket.id,
        name: rocket.rocketName,
        type: rocket.rocketType,
      ),
      launchSuccess: launchSuccess,
      details: details,
      missionPatch: links?.missionPatch,
      missionPatchSmall: links?.missionPatchSmall,
    );
  }
}
