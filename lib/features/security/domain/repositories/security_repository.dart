import 'package:dartz/dartz.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/features/security/domain/aggregates/security_assessment.dart';
import 'package:shemanit/features/security/domain/value_objects/device_fingerprint.dart';

abstract class SecurityRepository {
  Future<Either<Failure, SecurityAssessment>> performSecurityAssessment();
  Future<Either<Failure, DeviceFingerprint>> getDeviceFingerprint();
  Future<Either<Failure, void>> reportSecurityViolation(
    SecurityAssessment assessment,
  );
}
