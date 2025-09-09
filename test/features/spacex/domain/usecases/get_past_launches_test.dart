import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/repositories/spacex_repository.dart';
import 'package:robbie_starter/features/spacex/domain/usecases/get_past_launches.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_date.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/launch_site.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/mission_name.dart';
import 'package:robbie_starter/features/spacex/domain/value_objects/rocket_info.dart';

class MockSpaceXRepository extends Mock implements SpaceXRepository {}

void main() {
  group('GetPastLaunches', () {
    late GetPastLaunches usecase;
    late MockSpaceXRepository mockRepository;

    setUp(() {
      mockRepository = MockSpaceXRepository();
      usecase = GetPastLaunches(mockRepository);
    });

    final tLaunches = [
      LaunchEntity(
        id: '1',
        missionName: MissionName('Starlink-4'),
        launchDate: LaunchDate(DateTime(2023, 6, 15)),
        launchSite: const LaunchSite(
          name: 'KSC LC-39A',
          longName: 'Kennedy Space Center LC-39A',
        ),
        rocket: const RocketInfo(
          id: 'falcon9',
          name: 'Falcon 9',
          type: 'FT',
        ),
        launchSuccess: true,
      ),
      LaunchEntity(
        id: '2',
        missionName: MissionName('Demo-2'),
        launchDate: LaunchDate(DateTime(2023, 5, 30)),
        launchSite: const LaunchSite(
          name: 'KSC LC-39A',
          longName: 'Kennedy Space Center LC-39A',
        ),
        rocket: const RocketInfo(
          id: 'falcon9',
          name: 'Falcon 9',
          type: 'FT',
        ),
        launchSuccess: true,
      ),
    ];

    test('should get past launches from the repository', () async {
      // arrange
      when(
        () => mockRepository.getPastLaunches(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => Right(tLaunches));

      // act
      final result = await usecase(const GetPastLaunchesParams());

      // assert
      expect(result, Right(tLaunches));
      verify(
        () => mockRepository.getPastLaunches(
          limit: 10,
          offset: 0,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should get past launches with custom params', () async {
      // arrange
      when(
        () => mockRepository.getPastLaunches(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => Right(tLaunches));

      const params = GetPastLaunchesParams(limit: 5, offset: 10);

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(tLaunches));
      verify(
        () => mockRepository.getPastLaunches(
          limit: 5,
          offset: 10,
        ),
      ).called(1);
    });

    test('should return failure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(
        () => mockRepository.getPastLaunches(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(const GetPastLaunchesParams());

      // assert
      expect(result, const Left(tFailure));
      verify(
        () => mockRepository.getPastLaunches(
          limit: 10,
          offset: 0,
        ),
      ).called(1);
    });
  });

  group('GetPastLaunchesParams', () {
    test('should have default values', () {
      const params = GetPastLaunchesParams();
      expect(params.limit, 10);
      expect(params.offset, 0);
    });

    test('should allow custom values', () {
      const params = GetPastLaunchesParams(limit: 5, offset: 20);
      expect(params.limit, 5);
      expect(params.offset, 20);
    });

    test('should support equality', () {
      const params1 = GetPastLaunchesParams(limit: 5, offset: 10);
      const params2 = GetPastLaunchesParams(limit: 5, offset: 10);
      const params3 = GetPastLaunchesParams(offset: 10);

      expect(params1, equals(params2));
      expect(params1, isNot(equals(params3)));
    });
  });
}
