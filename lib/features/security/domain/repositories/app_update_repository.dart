import 'package:dartz/dartz.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/features/security/domain/aggregates/app_update_policy.dart';
import 'package:shemanit/features/security/domain/value_objects/app_version.dart';

abstract class AppUpdateRepository {
  Future<Either<Failure, AppUpdatePolicy>> getUpdatePolicy();
  Future<Either<Failure, AppVersion>> getCurrentAppVersion();
  Future<Either<Failure, void>> initiateUpdate(String downloadUrl);
}
