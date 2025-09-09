import 'package:dartz/dartz.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/shared/application/use_cases/base_use_case.dart';
import 'package:shemanit/features/security/domain/aggregates/security_assessment.dart';
import 'package:shemanit/features/security/domain/repositories/security_repository.dart';

class PerformSecurityAssessment extends NoParamsUseCase<SecurityAssessment> {
  PerformSecurityAssessment(this._repository);

  final SecurityRepository _repository;

  @override
  Future<Either<Failure, SecurityAssessment>> execute() async {
    return _repository.performSecurityAssessment();
  }
}
