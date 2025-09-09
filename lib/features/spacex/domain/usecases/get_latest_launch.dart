import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/repositories/spacex_repository.dart';
import 'package:robbie_starter/shared/application/use_cases/base_use_case.dart';

/// Use case to get the latest SpaceX launch
@injectable
class GetLatestLaunch implements UseCase<LaunchEntity?, NoParams> {
  const GetLatestLaunch(this._repository);

  final SpaceXRepository _repository;

  @override
  String get useCaseName => 'GetLatestLaunch';

  @override
  Future<Either<Failure, LaunchEntity?>> call(NoParams params) {
    return _repository.getLatestLaunch();
  }
}
