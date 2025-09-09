import 'package:shemanit/features/security/domain/aggregates/security_assessment.dart';
import 'package:shemanit/features/security/domain/value_objects/device_fingerprint.dart';
import 'package:shemanit/features/security/domain/value_objects/security_threat.dart';

abstract class ISecurityDetectionService {
  Future<bool> isDeviceJailbroken();
  Future<bool> isDeviceRooted();
  Future<bool> isRunningOnEmulator();
  Future<bool> isDevelopmentModeEnabled();
  Future<bool> isDebuggingEnabled();
  Future<List<String>> detectTamperingAttempts();
}

class SecurityAssessmentService {
  const SecurityAssessmentService(this._detectionService);

  final ISecurityDetectionService _detectionService;

  Future<SecurityAssessment> assessDeviceSecurity(
    DeviceFingerprint deviceFingerprint,
  ) async {
    final threats = <SecurityThreat>[];

    // Check for jailbreak/root
    if (deviceFingerprint.isIOS &&
        await _detectionService.isDeviceJailbroken()) {
      threats.add(SecurityThreat.jailbreak());
    }

    if (deviceFingerprint.isAndroid &&
        await _detectionService.isDeviceRooted()) {
      threats.add(SecurityThreat.root());
    }

    // Check for emulator - only use official platform detection
    if (await _detectionService.isRunningOnEmulator()) {
      threats.add(SecurityThreat.emulator());
    }

    // Check development settings
    if (await _detectionService.isDevelopmentModeEnabled()) {
      threats.add(SecurityThreat.developmentMode());
    }

    if (await _detectionService.isDebuggingEnabled()) {
      threats.add(SecurityThreat.debugging());
    }

    // Check for tampering
    final tamperingAttempts = await _detectionService.detectTamperingAttempts();
    for (final attempt in tamperingAttempts) {
      threats.add(SecurityThreat.tampering(attempt));
    }

    return SecurityAssessment.create(
      deviceFingerprint: deviceFingerprint,
      detectedThreats: threats,
    );
  }

  /// Business rule: Determines if the app should continue running
  bool shouldAllowAppAccess(SecurityAssessment assessment) {
    // Critical threats always block access
    if (assessment.hasCriticalThreats) {
      return false;
    }

    // Multiple high threats block access
    if (assessment.highThreats.length >= 2) {
      return false;
    }

    // Single high threat on emulator blocks access
    if (assessment.hasHighThreats && assessment.deviceFingerprint.isEmulator) {
      return false;
    }

    return true;
  }

  /// Business rule: Determines threat escalation
  bool shouldEscalateThreat(SecurityAssessment assessment) {
    // Escalate if running on jailbroken/rooted device with debugging enabled
    final hasRootAccess = assessment.detectedThreats.any(
      (t) => t.type == ThreatType.jailbreak || t.type == ThreatType.root,
    );
    final hasDebugging = assessment.detectedThreats.any(
      (t) => t.type == ThreatType.debugging,
    );

    return hasRootAccess && hasDebugging;
  }
}
