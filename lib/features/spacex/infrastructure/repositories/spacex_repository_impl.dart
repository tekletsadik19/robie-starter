import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/exceptions.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/repositories/spacex_repository.dart';
import 'package:robbie_starter/features/spacex/infrastructure/datasources/spacex_datasource.dart';
import 'package:robbie_starter/features/spacex/infrastructure/models/launch_model.dart';

/// Implementation of SpaceX repository
@LazySingleton(as: SpaceXRepository)
class SpaceXRepositoryImpl implements SpaceXRepository {
  const SpaceXRepositoryImpl(this._dataSource);

  final SpaceXDataSource _dataSource;

  @override
  Future<Either<Failure, List<LaunchEntity>>> getPastLaunches({
    int? limit,
    int? offset,
  }) async {
    try {
      final models = await _dataSource.getPastLaunches(
        limit: limit,
        offset: offset,
      );
      final entities = models.map((model) => model.toDomain()).toList();
      return Right(entities);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get past launches: $e'));
    }
  }

  @override
  Future<Either<Failure, List<LaunchEntity>>> getUpcomingLaunches({
    int? limit,
    int? offset,
  }) async {
    try {
      final models = await _dataSource.getUpcomingLaunches(
        limit: limit,
        offset: offset,
      );
      final entities = models.map((model) => model.toDomain()).toList();
      return Right(entities);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get upcoming launches: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, LaunchEntity?>> getLatestLaunch() async {
    try {
      final model = await _dataSource.getLatestLaunch();
      final entity = model?.toDomain();
      return Right(entity);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get latest launch: $e'));
    }
  }

  @override
  Future<Either<Failure, LaunchEntity?>> getNextLaunch() async {
    try {
      final model = await _dataSource.getNextLaunch();
      final entity = model?.toDomain();
      return Right(entity);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get next launch: $e'));
    }
  }

  @override
  Future<Either<Failure, LaunchEntity?>> getLaunchById(String id) async {
    // Note: This would require a specific query by ID
    // For now, we'll search through past launches
    try {
      final models = await _dataSource.getPastLaunches(limit: 100);
      final model = models.where((m) => m.id == id).firstOrNull;
      final entity = model?.toDomain();
      return Right(entity);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get launch by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, List<LaunchEntity>>> searchLaunches({
    required String query,
    int? limit,
  }) async {
    try {
      // Get all launches and filter by mission name
      final models = await _dataSource.getPastLaunches(limit: limit ?? 50);
      final filteredModels = models.where(
        (model) =>
            model.missionName.toLowerCase().contains(query.toLowerCase()),
      );
      final entities = filteredModels.map((model) => model.toDomain()).toList();
      return Right(entities);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to search launches: $e'));
    }
  }
}
