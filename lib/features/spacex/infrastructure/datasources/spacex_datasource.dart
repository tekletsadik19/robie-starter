import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/exceptions.dart';
import 'package:robbie_starter/core/utils/logger.dart';
import 'package:robbie_starter/features/spacex/infrastructure/models/launch_model.dart';
import 'package:robbie_starter/shared/infrastructure/graphql/graphql_client.dart';

/// Data source for SpaceX GraphQL API
@injectable
class SpaceXDataSource {
  const SpaceXDataSource(this._graphQLClient);

  final GraphQLClientService _graphQLClient;

  /// GraphQL query for getting past launches
  static const String _pastLaunchesQuery = r'''
    query GetPastLaunches($limit: Int, $offset: Int) {
      launchesPast(limit: $limit, offset: $offset) {
        id
        mission_name
        launch_date_local
        launch_success
        details
        launch_site {
          site_name
          site_name_long
        }
        rocket {
          rocket_name
          rocket_type
        }
        links {
          mission_patch
          mission_patch_small
        }
      }
    }
  ''';

  /// GraphQL query for getting upcoming launches
  static const String _upcomingLaunchesQuery = r'''
    query GetUpcomingLaunches($limit: Int, $offset: Int) {
      launchesUpcoming(limit: $limit, offset: $offset) {
        id
        mission_name
        launch_date_local
        launch_success
        details
        launch_site {
          site_name
          site_name_long
        }
        rocket {
          rocket_name
          rocket_type
        }
        links {
          mission_patch
          mission_patch_small
        }
      }
    }
  ''';

  /// GraphQL query for getting latest launch
  static const String _latestLaunchQuery = '''
    query GetLatestLaunch {
      launchLatest {
        id
        mission_name
        launch_date_local
        launch_success
        details
        launch_site {
          site_name
          site_name_long
        }
        rocket {
          rocket_name
          rocket_type
        }
        links {
          mission_patch
          mission_patch_small
        }
      }
    }
  ''';

  /// GraphQL query for getting next launch
  static const String _nextLaunchQuery = '''
    query GetNextLaunch {
      launchNext {
        id
        mission_name
        launch_date_local
        launch_success
        details
        launch_site {
          site_name
          site_name_long
        }
        rocket {
          rocket_name
          rocket_type
        }
        links {
          mission_patch
          mission_patch_small
        }
      }
    }
  ''';

  /// Get past launches
  Future<List<LaunchModel>> getPastLaunches({
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await _graphQLClient.query(
        client: _graphQLClient.spaceXClient,
        query: _pastLaunchesQuery,
        variables: {
          if (limit != null) 'limit': limit,
          if (offset != null) 'offset': offset,
        },
      );

      if (result.hasException) {
        Logger.error('GraphQL Error: ${result.exception}');
        throw const ServerException(message: 'Failed to fetch past launches');
      }

      final data = result.data;
      if (data == null || data['launchesPast'] == null) {
        return [];
      }

      final launchesData = data['launchesPast'] as List<dynamic>;
      return launchesData
          .map((json) => LaunchModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('SpaceX DataSource Error: $e');
      if (e is AppException) rethrow;
      throw ServerException(message: 'Failed to fetch past launches: $e');
    }
  }

  /// Get upcoming launches
  Future<List<LaunchModel>> getUpcomingLaunches({
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await _graphQLClient.query(
        client: _graphQLClient.spaceXClient,
        query: _upcomingLaunchesQuery,
        variables: {
          if (limit != null) 'limit': limit,
          if (offset != null) 'offset': offset,
        },
      );

      if (result.hasException) {
        Logger.error('GraphQL Error: ${result.exception}');
        throw const ServerException(
          message: 'Failed to fetch upcoming launches',
        );
      }

      final data = result.data;
      if (data == null || data['launchesUpcoming'] == null) {
        return [];
      }

      final launchesData = data['launchesUpcoming'] as List<dynamic>;
      return launchesData
          .map((json) => LaunchModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('SpaceX DataSource Error: $e');
      if (e is AppException) rethrow;
      throw ServerException(message: 'Failed to fetch upcoming launches: $e');
    }
  }

  /// Get latest launch
  Future<LaunchModel?> getLatestLaunch() async {
    try {
      final result = await _graphQLClient.query(
        client: _graphQLClient.spaceXClient,
        query: _latestLaunchQuery,
      );

      if (result.hasException) {
        Logger.error('GraphQL Error: ${result.exception}');
        throw const ServerException(message: 'Failed to fetch latest launch');
      }

      final data = result.data;
      if (data == null || data['launchLatest'] == null) {
        return null;
      }

      return LaunchModel.fromJson(data['launchLatest'] as Map<String, dynamic>);
    } catch (e) {
      Logger.error('SpaceX DataSource Error: $e');
      if (e is AppException) rethrow;
      throw ServerException(message: 'Failed to fetch latest launch: $e');
    }
  }

  /// Get next launch
  Future<LaunchModel?> getNextLaunch() async {
    try {
      final result = await _graphQLClient.query(
        client: _graphQLClient.spaceXClient,
        query: _nextLaunchQuery,
      );

      if (result.hasException) {
        Logger.error('GraphQL Error: ${result.exception}');
        throw const ServerException(message: 'Failed to fetch next launch');
      }

      final data = result.data;
      if (data == null || data['launchNext'] == null) {
        return null;
      }

      return LaunchModel.fromJson(data['launchNext'] as Map<String, dynamic>);
    } catch (e) {
      Logger.error('SpaceX DataSource Error: $e');
      if (e is AppException) rethrow;
      throw ServerException(message: 'Failed to fetch next launch: $e');
    }
  }
}
