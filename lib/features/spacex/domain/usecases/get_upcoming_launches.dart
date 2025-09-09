import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/repositories/spacex_repository.dart';
import 'package:robbie_starter/shared/application/use_cases/base_use_case.dart';

/// Use case to get upcoming SpaceX launches
@injectable
class GetUpcomingLaunches
    implements UseCase<List<LaunchEntity>, GetUpcomingLaunchesParams> {
  const GetUpcomingLaunches(this._repository);

  final SpaceXRepository _repository;

  @override
  String get useCaseName => 'GetUpcomingLaunches';

  @override
  Future<Either<Failure, List<LaunchEntity>>> call(
    GetUpcomingLaunchesParams params,
  ) {
    return _repository.getUpcomingLaunches(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

/// Parameters for getting upcoming launches
class GetUpcomingLaunchesParams extends UseCaseParams {
  const GetUpcomingLaunchesParams({
    this.limit = 10,
    this.offset = 0,
  });

  final int limit;
  final int offset;

  @override
  List<Object?> get props => [limit, offset];
}
