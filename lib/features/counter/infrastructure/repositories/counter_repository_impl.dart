import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shemanit/core/errors/exceptions.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:shemanit/features/counter/domain/entities/counter_entity.dart';
import 'package:shemanit/features/counter/domain/repositories/counter_repository.dart';
import 'package:shemanit/features/counter/infrastructure/datasources/counter_local_data_source.dart';
import 'package:shemanit/features/counter/infrastructure/models/counter_model.dart';

@Singleton(as: CounterRepository)
class CounterRepositoryImpl implements CounterRepository {
  const CounterRepositoryImpl(this._localDataSource);

  final CounterLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, CounterEntity>> getCurrentCounter() async {
    try {
      final counterModel = await _localDataSource.getCachedCounter();
      return Right(counterModel.toEntity());
    } on CacheException catch (e) {
      Logger.error('Cache error in getCurrentCounter', e);
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      Logger.error('Unexpected error in getCurrentCounter', e);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> saveCounter(
    CounterEntity counter,
  ) async {
    try {
      final counterModel = CounterModel.fromEntity(counter);
      await _localDataSource.cacheCounter(counterModel);
      await _localDataSource.addToHistory(counterModel);
      return Right(counter);
    } on CacheException catch (e) {
      Logger.error('Cache error in saveCounter', e);
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      Logger.error('Unexpected error in saveCounter', e);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> resetCounter(String counterId) async {
    try {
      final currentCounter = await getCurrentCounter();
      return await currentCounter.fold(
        (failure) async => Left(failure),
        (counter) async {
          final resetCounter = counter.reset();
          return saveCounter(resetCounter);
        },
      );
    } catch (e) {
      Logger.error('Error in resetCounter', e);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CounterEntity>>> getCounterHistory({
    int limit = 10,
  }) async {
    try {
      final historyModels = await _localDataSource.getCachedCounterHistory();
      final limitedHistory = historyModels.take(limit).toList();
      final entities = limitedHistory.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      Logger.error('Cache error in getCounterHistory', e);
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      Logger.error('Unexpected error in getCounterHistory', e);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // Base repository methods implementation
  @override
  Future<Either<Failure, CounterEntity>> getById(String id) async =>
      getCurrentCounter();

  @override
  Future<Either<Failure, List<CounterEntity>>> getAll({
    int? limit,
    int? offset,
    Map<String, dynamic>? filters,
  }) async =>
      getCounterHistory(limit: limit ?? 10);

  @override
  Future<Either<Failure, CounterEntity>> create(CounterEntity entity) async =>
      saveCounter(entity);

  @override
  Future<Either<Failure, CounterEntity>> update(CounterEntity entity) async =>
      saveCounter(entity);

  @override
  Future<Either<Failure, bool>> delete(String id) async {
    try {
      await _localDataSource.clearCache();
      return const Right(true);
    } on CacheException catch (e) {
      Logger.error('Cache error in delete', e);
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      Logger.error('Unexpected error in delete', e);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> exists(String id) async {
    final result = await getCurrentCounter();
    return result.fold(
      Left.new,
      (counter) => Right(counter.id == id),
    );
  }
}
