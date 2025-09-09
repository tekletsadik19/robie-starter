import 'package:flutter_test/flutter_test.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_date.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_site.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/mission_name.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/rocket_info.dart';

void main() {
  group('LaunchEntity', () {
    late LaunchEntity launchEntity;
    late MissionName missionName;
    late LaunchDate launchDate;
    late LaunchSite launchSite;
    late RocketInfo rocket;

    setUp(() {
      missionName = MissionName('Starlink-4');
      launchDate = LaunchDate(DateTime(2023, 6, 15));
      launchSite = const LaunchSite(
        name: 'KSC LC-39A',
        longName: 'Kennedy Space Center LC-39A',
      );
      rocket = const RocketInfo(
        id: 'falcon9',
        name: 'Falcon 9',
        type: 'FT',
      );

      launchEntity = LaunchEntity(
        id: '1',
        missionName: missionName,
        launchDate: launchDate,
        launchSite: launchSite,
        rocket: rocket,
        launchSuccess: true,
        details: 'Starlink mission to deploy satellites',
      );
    });

    test('should create a launch entity with all properties', () {
      expect(launchEntity.id, '1');
      expect(launchEntity.missionName, missionName);
      expect(launchEntity.launchDate, launchDate);
      expect(launchEntity.launchSite, launchSite);
      expect(launchEntity.rocket, rocket);
      expect(launchEntity.launchSuccess, true);
      expect(launchEntity.details, 'Starlink mission to deploy satellites');
    });

    test('should create successful launch using factory', () {
      final successfulLaunch = LaunchEntity.successful(
        id: '2',
        missionName: missionName,
        launchDate: launchDate,
        launchSite: launchSite,
        rocket: rocket,
      );

      expect(successfulLaunch.launchSuccess, true);
      expect(successfulLaunch.wasSuccessful, true);
      expect(successfulLaunch.hasFailed, false);
      expect(successfulLaunch.hasUnknownOutcome, false);
    });

    test('should create failed launch using factory', () {
      final failedLaunch = LaunchEntity.failed(
        id: '3',
        missionName: missionName,
        launchDate: launchDate,
        launchSite: launchSite,
        rocket: rocket,
      );

      expect(failedLaunch.launchSuccess, false);
      expect(failedLaunch.wasSuccessful, false);
      expect(failedLaunch.hasFailed, true);
      expect(failedLaunch.hasUnknownOutcome, false);
    });

    test('should handle unknown outcome', () {
      final unknownLaunch = LaunchEntity(
        id: '4',
        missionName: missionName,
        launchDate: launchDate,
        launchSite: launchSite,
        rocket: rocket,
        launchSuccess: null,
      );

      expect(unknownLaunch.launchSuccess, null);
      expect(unknownLaunch.wasSuccessful, false);
      expect(unknownLaunch.hasFailed, false);
      expect(unknownLaunch.hasUnknownOutcome, true);
    });

    test('should return formatted mission info', () {
      final formattedInfo = launchEntity.formattedMissionInfo;
      expect(formattedInfo, contains('Starlink-4'));
      expect(formattedInfo, contains('-'));
    });

    test('should return correct status text', () {
      expect(launchEntity.statusText, 'Successful');

      final failedLaunch = LaunchEntity(
        id: launchEntity.id,
        missionName: launchEntity.missionName,
        launchDate: launchEntity.launchDate,
        launchSite: launchEntity.launchSite,
        rocket: launchEntity.rocket,
        launchSuccess: false,
      );
      expect(failedLaunch.statusText, 'Failed');

      final unknownLaunch = LaunchEntity(
        id: launchEntity.id,
        missionName: launchEntity.missionName,
        launchDate: launchEntity.launchDate,
        launchSite: launchEntity.launchSite,
        rocket: launchEntity.rocket,
        launchSuccess: null,
      );
      expect(unknownLaunch.statusText, 'Unknown');
    });

    test('should support equality', () {
      final anotherLaunch = LaunchEntity(
        id: '1',
        missionName: missionName,
        launchDate: launchDate,
        launchSite: launchSite,
        rocket: rocket,
        launchSuccess: true,
        details: 'Starlink mission to deploy satellites',
      );

      expect(launchEntity, equals(anotherLaunch));
    });

    test('should support creating new instances with different values', () {
      final newLaunch = LaunchEntity(
        id: launchEntity.id,
        missionName: launchEntity.missionName,
        launchDate: launchEntity.launchDate,
        launchSite: launchEntity.launchSite,
        rocket: launchEntity.rocket,
        launchSuccess: false,
        details: 'Updated details',
      );

      expect(newLaunch.id, launchEntity.id);
      expect(newLaunch.launchSuccess, false);
      expect(newLaunch.details, 'Updated details');
      expect(newLaunch.missionName, launchEntity.missionName);
    });
  });
}

extension LaunchEntityCopyWith on LaunchEntity {
  LaunchEntity copyWith({
    String? id,
    MissionName? missionName,
    LaunchDate? launchDate,
    LaunchSite? launchSite,
    RocketInfo? rocket,
    bool? launchSuccess,
    String? details,
    String? missionPatch,
    String? missionPatchSmall,
  }) {
    return LaunchEntity(
      id: id ?? this.id,
      missionName: missionName ?? this.missionName,
      launchDate: launchDate ?? this.launchDate,
      launchSite: launchSite ?? this.launchSite,
      rocket: rocket ?? this.rocket,
      launchSuccess: launchSuccess ?? this.launchSuccess,
      details: details ?? this.details,
      missionPatch: missionPatch ?? this.missionPatch,
      missionPatchSmall: missionPatchSmall ?? this.missionPatchSmall,
    );
  }
}
