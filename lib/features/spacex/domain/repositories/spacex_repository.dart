import 'package:dartz/dartz.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';

/// Repository interface for SpaceX data
abstract class SpaceXRepository {
  /// Get past launches
  Future<Either<Failure, List<LaunchEntity>>> getPastLaunches({
    int? limit,
    int? offset,
  });

  /// Get upcoming launches
  Future<Either<Failure, List<LaunchEntity>>> getUpcomingLaunches({
    int? limit,
    int? offset,
  });

  /// Get latest launch
  Future<Either<Failure, LaunchEntity?>> getLatestLaunch();

  /// Get next launch
  Future<Either<Failure, LaunchEntity?>> getNextLaunch();

  /// Get launch by ID
  Future<Either<Failure, LaunchEntity?>> getLaunchById(String id);

  /// Search launches by mission name
  Future<Either<Failure, List<LaunchEntity>>> searchLaunches({
    required String query,
    int? limit,
  });
}
