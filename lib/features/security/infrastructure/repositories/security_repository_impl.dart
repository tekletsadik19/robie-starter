import 'package:dartz/dartz.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/security/domain/aggregates/security_assessment.dart';
import 'package:robbie_starter/features/security/domain/repositories/security_repository.dart';
import 'package:robbie_starter/features/security/domain/services/security_assessment_service.dart';
import 'package:robbie_starter/features/security/domain/value_objects/device_fingerprint.dart';
import 'package:robbie_starter/features/security/infrastructure/services/device_fingerprint_service.dart';

class SecurityRepositoryImpl implements SecurityRepository {
  const SecurityRepositoryImpl(
    this._securityAssessmentService,
    this._deviceFingerprintService,
  );

  final SecurityAssessmentService _securityAssessmentService;
  final DeviceFingerprintService _deviceFingerprintService;

  @override
  Future<Either<Failure, SecurityAssessment>>
      performSecurityAssessment() async {
    try {
      final deviceFingerprint =
          await _deviceFingerprintService.generateFingerprint();
      final assessment = await _securityAssessmentService
          .assessDeviceSecurity(deviceFingerprint);
      return Right(assessment);
    } catch (e) {
      // For security failures, we fail secure - treat as critical security violation
      return Left(ServerFailure(message: 'CRITICAL SECURITY FAILURE: $e'));
    }
  }

  @override
  Future<Either<Failure, DeviceFingerprint>> getDeviceFingerprint() async {
    try {
      final fingerprint = await _deviceFingerprintService.generateFingerprint();
      return Right(fingerprint);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to generate device fingerprint: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reportSecurityViolation(
    SecurityAssessment assessment,
  ) async {
    try {
      // In a real implementation, this would send the security violation to a backend service
      // For now, we'll just log it locally or store it for later reporting

      // TODO(security): Implement actual reporting mechanism
      // - Send to security monitoring service
      // - Log to analytics
      // - Store for compliance reporting

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to report security violation: $e'),
      );
    }
  }
}
