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

  /// GraphQL query for getting countries (simulating past launches)
  static const String _pastLaunchesQuery = '''
    query GetCountries {
      countries {
        code
        name
        capital
        currency
        continent {
          name
          code
        }
        languages {
          name
          code
        }
      }
    }
  ''';

  /// GraphQL query for getting upcoming launches (same as countries for demo)
  static const String _upcomingLaunchesQuery = '''
    query GetCountries {
      countries {
        code
        name
        capital
        currency
        continent {
          name
          code
        }
        languages {
          name
          code
        }
      }
    }
  ''';

  /// GraphQL query for getting latest launch (single country for demo)
  static const String _latestLaunchQuery = '''
    query GetCountry {
      country(code: "US") {
        code
        name
        capital
        currency
        continent {
          name
          code
        }
        languages {
          name
          code
        }
      }
    }
  ''';

  /// GraphQL query for getting next launch (another country for demo)
  static const String _nextLaunchQuery = '''
    query GetCountry {
      country(code: "CA") {
        code
        name
        capital
        currency
        continent {
          name
          code
        }
        languages {
          name
          code
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
      );

      if (result.hasException) {
        Logger.error('GraphQL Error: ${result.exception}');
        throw const ServerException(message: 'Failed to fetch past launches');
      }

      final data = result.data;
      if (data == null || data['countries'] == null) {
        return [];
      }

      final countriesData = data['countries'] as List<dynamic>;
      // Convert countries to launch models for demo
      return countriesData.take(limit ?? 10).map((country) {
        final countryMap = country as Map<String, dynamic>;
        return LaunchModel.fromJson({
          'id': countryMap['code'],
          'mission_name': countryMap['name'],
          'launch_date_local': DateTime.now().toIso8601String(),
          'launch_success': true,
          'details': 'Demo launch for ${countryMap['name']} (${countryMap['capital']})',
          'launch_site': {
            'site_name': countryMap['capital'] ?? 'Unknown',
            'site_name_long': '${countryMap['name']} Launch Site',
          },
          'rocket': {
            'rocket_name': '${countryMap['name']} Rocket',
            'rocket_type': countryMap['continent']?['name'] ?? 'Unknown',
          },
          'links': {
            'mission_patch': null,
            'mission_patch_small': null,
          },
        });
      }).toList();
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
      );

      if (result.hasException) {
        Logger.error('GraphQL Error: ${result.exception}');
        throw const ServerException(
          message: 'Failed to fetch upcoming launches',
        );
      }

      final data = result.data;
      if (data == null || data['countries'] == null) {
        return [];
      }

      final countriesData = data['countries'] as List<dynamic>;
      // Convert countries to launch models for demo - take different subset
      return countriesData.skip(10).take(limit ?? 5).map((country) {
        final countryMap = country as Map<String, dynamic>;
        return LaunchModel.fromJson({
          'id': '${countryMap['code']}_upcoming',
          'mission_name': '${countryMap['name']} Future Mission',
          'launch_date_local': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
          'launch_success': null,
          'details': 'Upcoming launch mission for ${countryMap['name']}',
          'launch_site': {
            'site_name': countryMap['capital'] ?? 'Unknown',
            'site_name_long': '${countryMap['name']} Future Launch Site',
          },
          'rocket': {
            'rocket_name': '${countryMap['name']} Next-Gen Rocket',
            'rocket_type': countryMap['continent']?['name'] ?? 'Unknown',
          },
          'links': {
            'mission_patch': null,
            'mission_patch_small': null,
          },
        });
      }).toList();
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
      if (data == null || data['country'] == null) {
        return null;
      }

      final countryMap = data['country'] as Map<String, dynamic>;
      return LaunchModel.fromJson({
        'id': '${countryMap['code']}_latest',
        'mission_name': '${countryMap['name']} Latest Mission',
        'launch_date_local': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'launch_success': true,
        'details': 'Latest successful launch from ${countryMap['name']} (${countryMap['capital']})',
        'launch_site': {
          'site_name': countryMap['capital'] ?? 'Unknown',
          'site_name_long': '${countryMap['name']} Primary Launch Site',
        },
        'rocket': {
          'rocket_name': '${countryMap['name']} Advanced Rocket',
          'rocket_type': countryMap['continent']?['name'] ?? 'Unknown',
        },
        'links': {
          'mission_patch': null,
          'mission_patch_small': null,
        },
      });
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
      if (data == null || data['country'] == null) {
        return null;
      }

      final countryMap = data['country'] as Map<String, dynamic>;
      return LaunchModel.fromJson({
        'id': '${countryMap['code']}_next',
        'mission_name': '${countryMap['name']} Next Mission',
        'launch_date_local': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        'launch_success': null,
        'details': 'Next scheduled launch from ${countryMap['name']} (${countryMap['capital']})',
        'launch_site': {
          'site_name': countryMap['capital'] ?? 'Unknown',
          'site_name_long': '${countryMap['name']} Next Launch Site',
        },
        'rocket': {
          'rocket_name': '${countryMap['name']} Future Rocket',
          'rocket_type': countryMap['continent']?['name'] ?? 'Unknown',
        },
        'links': {
          'mission_patch': null,
          'mission_patch_small': null,
        },
      });
    } catch (e) {
      Logger.error('SpaceX DataSource Error: $e');
      if (e is AppException) rethrow;
      throw ServerException(message: 'Failed to fetch next launch: $e');
    }
  }
}
