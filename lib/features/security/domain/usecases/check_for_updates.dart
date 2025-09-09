import 'package:dartz/dartz.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/shared/application/use_cases/base_use_case.dart';
import 'package:shemanit/features/security/domain/aggregates/app_update_policy.dart';
import 'package:shemanit/features/security/domain/repositories/app_update_repository.dart';

class EvaluateUpdatePolicy extends NoParamsUseCase<AppUpdatePolicy> {
  EvaluateUpdatePolicy(this._repository);

  final AppUpdateRepository _repository;

  @override
  Future<Either<Failure, AppUpdatePolicy>> execute() async {
    return _repository.getUpdatePolicy();
  }
}
