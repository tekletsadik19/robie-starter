import 'package:equatable/equatable.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_date.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_site.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/rocket_info.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/mission_name.dart';

/// Launch entity representing a SpaceX launch
class LaunchEntity extends Equatable {
  const LaunchEntity({
    required this.id,
    required this.missionName,
    required this.launchDate,
    required this.launchSite,
    required this.rocket,
    required this.launchSuccess,
    this.details,
    this.missionPatch,
    this.missionPatchSmall,
  });

  /// Create a successful launch
  factory LaunchEntity.successful({
    required String id,
    required MissionName missionName,
    required LaunchDate launchDate,
    required LaunchSite launchSite,
    required RocketInfo rocket,
    String? details,
    String? missionPatch,
    String? missionPatchSmall,
  }) {
    return LaunchEntity(
      id: id,
      missionName: missionName,
      launchDate: launchDate,
      launchSite: launchSite,
      rocket: rocket,
      launchSuccess: true,
      details: details,
      missionPatch: missionPatch,
      missionPatchSmall: missionPatchSmall,
    );
  }

  /// Create a failed launch
  factory LaunchEntity.failed({
    required String id,
    required MissionName missionName,
    required LaunchDate launchDate,
    required LaunchSite launchSite,
    required RocketInfo rocket,
    String? details,
    String? missionPatch,
    String? missionPatchSmall,
  }) {
    return LaunchEntity(
      id: id,
      missionName: missionName,
      launchDate: launchDate,
      launchSite: launchSite,
      rocket: rocket,
      launchSuccess: false,
      details: details,
      missionPatch: missionPatch,
      missionPatchSmall: missionPatchSmall,
    );
  }

  final String id;
  final MissionName missionName;
  final LaunchDate launchDate;
  final LaunchSite launchSite;
  final RocketInfo rocket;
  final bool? launchSuccess;
  final String? details;
  final String? missionPatch;
  final String? missionPatchSmall;

  /// Check if launch was successful
  bool get wasSuccessful => launchSuccess == true;

  /// Check if launch failed
  bool get hasFailed => launchSuccess == false;

  /// Check if launch outcome is unknown
  bool get hasUnknownOutcome => launchSuccess == null;

  /// Get formatted mission information
  String get formattedMissionInfo {
    return '${missionName.value} - ${launchDate.formatted}';
  }

  /// Get launch status text
  String get statusText {
    if (wasSuccessful) return 'Successful';
    if (hasFailed) return 'Failed';
    return 'Unknown';
  }

  @override
  List<Object?> get props => [
        id,
        missionName,
        launchDate,
        launchSite,
        rocket,
        launchSuccess,
        details,
        missionPatch,
        missionPatchSmall,
      ];
}
