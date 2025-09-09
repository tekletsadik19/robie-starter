import 'package:shemanit/features/security/domain/entities/security_status.dart';
import 'package:shemanit/features/security/domain/value_objects/security_threat_level.dart';
import 'package:shemanit/features/security/domain/aggregates/security_assessment.dart';
import 'package:shemanit/features/security/domain/value_objects/security_threat.dart';
import 'package:shemanit/features/security/domain/value_objects/device_fingerprint.dart';

class SecurityStatusModel {
  const SecurityStatusModel({
    required this.isJailbroken,
    required this.isRooted,
    required this.isEmulator,
    required this.isDevelopmentModeEnabled,
    required this.isDebuggingEnabled,
    required this.threatLevel,
    required this.detectedThreats,
  });

  factory SecurityStatusModel.fromJson(Map<String, dynamic> json) {
    return SecurityStatusModel(
      isJailbroken: json['isJailbroken'] as bool,
      isRooted: json['isRooted'] as bool,
      isEmulator: json['isEmulator'] as bool,
      isDevelopmentModeEnabled: json['isDevelopmentModeEnabled'] as bool,
      isDebuggingEnabled: json['isDebuggingEnabled'] as bool,
      threatLevel: SecurityThreatLevelModel.values.firstWhere(
        (e) => e.name == json['threatLevel'],
        orElse: () => SecurityThreatLevelModel.none,
      ),
      detectedThreats: List<String>.from(json['detectedThreats'] as List),
    );
  }

  final bool isJailbroken;
  final bool isRooted;
  final bool isEmulator;
  final bool isDevelopmentModeEnabled;
  final bool isDebuggingEnabled;
  final SecurityThreatLevelModel threatLevel;
  final List<String> detectedThreats;
}

enum SecurityThreatLevelModel {
  none,
  low,
  medium,
  high,
  critical,
}

extension SecurityStatusModelExtension on SecurityStatusModel {
  SecurityStatus toDomain() {
    // Create threats based on detected issues
    final threats = <SecurityThreat>[];

    if (isJailbroken) {
      threats.add(SecurityThreat.jailbreak());
    }
    if (isRooted) {
      threats.add(SecurityThreat.root());
    }
    if (isEmulator) {
      threats.add(SecurityThreat.emulator());
    }
    if (isDevelopmentModeEnabled) {
      threats.add(SecurityThreat.developmentMode());
    }
    if (isDebuggingEnabled) {
      threats.add(SecurityThreat.debugging());
    }

    // Create device fingerprint (simplified)
    const deviceFingerprint = DeviceFingerprint(
      deviceId: 'unknown',
      platform: 'unknown',
      osVersion: 'unknown',
      appVersion: 'unknown',
      isPhysicalDevice: true,
      model: 'unknown',
    );

    // Create security assessment
    final assessment = SecurityAssessment.create(
      deviceFingerprint: deviceFingerprint,
      detectedThreats: threats,
    );

    return SecurityStatus(
      assessment: assessment,
      isSecure: !isJailbroken && !isRooted && !isEmulator,
      requiresAction: threats.isNotEmpty,
      shouldBlockApp: isJailbroken || isRooted,
      lastChecked: DateTime.now(),
    );
  }
}

extension SecurityThreatLevelModelExtension on SecurityThreatLevelModel {
  SecurityThreatLevel toDomain() {
    switch (this) {
      case SecurityThreatLevelModel.none:
        return SecurityThreatLevel.none;
      case SecurityThreatLevelModel.low:
        return SecurityThreatLevel.low;
      case SecurityThreatLevelModel.medium:
        return SecurityThreatLevel.medium;
      case SecurityThreatLevelModel.high:
        return SecurityThreatLevel.high;
      case SecurityThreatLevelModel.critical:
        return SecurityThreatLevel.critical;
    }
  }
}
