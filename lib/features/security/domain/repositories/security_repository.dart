import 'package:dartz/dartz.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/security/domain/aggregates/security_assessment.dart';
import 'package:robbie_starter/features/security/domain/value_objects/device_fingerprint.dart';

abstract class SecurityRepository {
  Future<Either<Failure, SecurityAssessment>> performSecurityAssessment();
  Future<Either<Failure, DeviceFingerprint>> getDeviceFingerprint();
  Future<Either<Failure, void>> reportSecurityViolation(
    SecurityAssessment assessment,
  );
}
