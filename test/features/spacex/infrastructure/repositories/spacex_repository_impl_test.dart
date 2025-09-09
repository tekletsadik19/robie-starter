import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robbie_starter/core/errors/exceptions.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/infrastructure/datasources/spacex_datasource.dart';
import 'package:robbie_starter/features/spacex/infrastructure/models/launch_model.dart';
import 'package:robbie_starter/features/spacex/infrastructure/repositories/spacex_repository_impl.dart';

class MockSpaceXDataSource extends Mock implements SpaceXDataSource {}

void main() {
  group('SpaceXRepositoryImpl', () {
    late SpaceXRepositoryImpl repository;
    late MockSpaceXDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockSpaceXDataSource();
      repository = SpaceXRepositoryImpl(mockDataSource);
    });

    final tLaunchModels = [
      const LaunchModel(
        id: '1',
        missionName: 'Starlink-4',
        launchDateLocal: '2023-06-15T10:00:00-04:00',
        launchSuccess: true,
        launchSite: LaunchSiteModel(
          siteName: 'KSC LC-39A',
          siteNameLong: 'Kennedy Space Center LC-39A',
        ),
        rocket: RocketModel(
          id: 'falcon9',
          rocketName: 'Falcon 9',
          rocketType: 'FT',
        ),
        details: 'Starlink mission',
        links: LinksModel(
          missionPatch: 'https://example.com/patch.png',
          missionPatchSmall: 'https://example.com/patch_small.png',
        ),
      ),
    ];

    group('getPastLaunches', () {
      test('should return list of launch entities when data source succeeds',
          () async {
        // arrange
        when(
          () => mockDataSource.getPastLaunches(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => tLaunchModels);

        // act
        final result = await repository.getPastLaunches(limit: 10, offset: 0);

        // assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Expected success, got failure'),
          (launches) {
            expect(launches.length, 1);
            expect(launches[0].id, '1');
            expect(launches[0].missionName.value, 'Starlink-4');
          },
        );
        verify(() => mockDataSource.getPastLaunches(limit: 10, offset: 0))
            .called(1);
      });

      test(
          'should return NetworkFailure when data source throws NetworkException',
          () async {
        // arrange
        when(
          () => mockDataSource.getPastLaunches(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenThrow(const NetworkException(message: 'No internet'));

        // act
        final result = await repository.getPastLaunches(limit: 10, offset: 0);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'No internet');
          },
          (launches) => fail('Expected failure, got success'),
        );
      });

      test(
          'should return ServerFailure when data source throws ServerException',
          () async {
        // arrange
        when(
          () => mockDataSource.getPastLaunches(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenThrow(const ServerException(message: 'Server error'));

        // act
        final result = await repository.getPastLaunches(limit: 10, offset: 0);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Server error');
          },
          (launches) => fail('Expected failure, got success'),
        );
      });

      test(
          'should return ServerFailure when data source throws unexpected exception',
          () async {
        // arrange
        when(
          () => mockDataSource.getPastLaunches(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenThrow(Exception('Unexpected error'));

        // act
        final result = await repository.getPastLaunches(limit: 10, offset: 0);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains('Failed to get past launches'));
          },
          (launches) => fail('Expected failure, got success'),
        );
      });
    });

    group('getLatestLaunch', () {
      test('should return launch entity when data source succeeds', () async {
        // arrange
        when(() => mockDataSource.getLatestLaunch())
            .thenAnswer((_) async => tLaunchModels.first);

        // act
        final result = await repository.getLatestLaunch();

        // assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Expected success, got failure'),
          (launch) {
            expect(launch, isNotNull);
            expect(launch!.id, '1');
            expect(launch.missionName.value, 'Starlink-4');
          },
        );
        verify(() => mockDataSource.getLatestLaunch()).called(1);
      });

      test('should return null when data source returns null', () async {
        // arrange
        when(() => mockDataSource.getLatestLaunch())
            .thenAnswer((_) async => null);

        // act
        final result = await repository.getLatestLaunch();

        // assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Expected success, got failure'),
          (launch) => expect(launch, isNull),
        );
      });

      test(
          'should return NetworkFailure when data source throws NetworkException',
          () async {
        // arrange
        when(() => mockDataSource.getLatestLaunch())
            .thenThrow(const NetworkException(message: 'No internet'));

        // act
        final result = await repository.getLatestLaunch();

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'No internet');
          },
          (launch) => fail('Expected failure, got success'),
        );
      });
    });

    group('searchLaunches', () {
      test('should return filtered launches based on mission name', () async {
        // arrange
        final tLaunchModelsWithDifferentNames = [
          tLaunchModels.first,
          const LaunchModel(
            id: '2',
            missionName: 'Demo-2',
            launchDateLocal: '2023-05-30T10:00:00-04:00',
            launchSuccess: true,
            launchSite: LaunchSiteModel(
              siteName: 'KSC LC-39A',
              siteNameLong: 'Kennedy Space Center LC-39A',
            ),
            rocket: RocketModel(
              id: 'falcon9',
              rocketName: 'Falcon 9',
              rocketType: 'FT',
            ),
            details: null,
            links: null,
          ),
        ];

        when(() => mockDataSource.getPastLaunches(limit: any(named: 'limit')))
            .thenAnswer((_) async => tLaunchModelsWithDifferentNames);

        // act
        final result = await repository.searchLaunches(query: 'starlink');

        // assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Expected success, got failure'),
          (launches) {
            expect(launches.length, 1);
            expect(launches[0].missionName.value, 'Starlink-4');
          },
        );
      });

      test('should return empty list when no matches found', () async {
        // arrange
        when(() => mockDataSource.getPastLaunches(limit: any(named: 'limit')))
            .thenAnswer((_) async => tLaunchModels);

        // act
        final result = await repository.searchLaunches(query: 'nonexistent');

        // assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Expected success, got failure'),
          (launches) => expect(launches, isEmpty),
        );
      });
    });
  });
}
