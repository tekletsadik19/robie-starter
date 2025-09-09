import 'package:dartz/dartz.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/security/domain/aggregates/app_update_policy.dart';
import 'package:robbie_starter/features/security/domain/repositories/app_update_repository.dart';
import 'package:robbie_starter/features/security/domain/services/app_update_service.dart';
import 'package:robbie_starter/features/security/domain/value_objects/app_version.dart';

class AppUpdateRepositoryImpl implements AppUpdateRepository {
  const AppUpdateRepositoryImpl(this._appUpdateService);

  final AppUpdateService _appUpdateService;

  @override
  Future<Either<Failure, AppUpdatePolicy>> getUpdatePolicy() async {
    try {
      final policy = await _appUpdateService.evaluateUpdatePolicy();
      return Right(policy);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to evaluate update policy: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, AppVersion>> getCurrentAppVersion() async {
    try {
      final policy = await _appUpdateService.evaluateUpdatePolicy();
      return Right(policy.currentVersion);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get current app version: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> initiateUpdate(String downloadUrl) async {
    try {
      final uri = Uri.parse(downloadUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return const Right(null);
      } else {
        return Left(
          ServerFailure(message: 'Cannot launch update URL: $downloadUrl'),
        );
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to initiate update: $e'));
    }
  }
}
