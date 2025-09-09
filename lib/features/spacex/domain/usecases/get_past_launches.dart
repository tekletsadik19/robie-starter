import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/repositories/spacex_repository.dart';
import 'package:robbie_starter/shared/application/use_cases/base_use_case.dart';

/// Use case to get past SpaceX launches
@injectable
class GetPastLaunches
    implements UseCase<List<LaunchEntity>, GetPastLaunchesParams> {
  const GetPastLaunches(this._repository);

  final SpaceXRepository _repository;

  @override
  String get useCaseName => 'GetPastLaunches';

  @override
  Future<Either<Failure, List<LaunchEntity>>> call(
    GetPastLaunchesParams params,
  ) {
    return _repository.getPastLaunches(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

/// Parameters for getting past launches
class GetPastLaunchesParams extends UseCaseParams {
  const GetPastLaunchesParams({
    this.limit = 10,
    this.offset = 0,
  });

  final int limit;
  final int offset;

  @override
  List<Object?> get props => [limit, offset];
}
