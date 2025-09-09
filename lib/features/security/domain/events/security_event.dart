import 'package:equatable/equatable.dart';
import 'package:shemanit/features/security/domain/value_objects/security_threat.dart';
import 'package:shemanit/features/security/domain/value_objects/threat_level.dart';
import 'package:shemanit/features/security/domain/value_objects/device_fingerprint.dart';

abstract class SecurityDomainEvent extends Equatable {
  const SecurityDomainEvent({required this.occurredAt});

  final DateTime occurredAt;

  @override
  List<Object?> get props => [occurredAt];
}

class SecurityThreatDetected extends SecurityDomainEvent {
  const SecurityThreatDetected({
    required this.threat,
    required this.deviceFingerprint,
    required super.occurredAt,
  });

  final SecurityThreat threat;
  final DeviceFingerprint deviceFingerprint;

  @override
  List<Object?> get props => [...super.props, threat, deviceFingerprint];
}

class SecurityAssessmentCompleted extends SecurityDomainEvent {
  const SecurityAssessmentCompleted({
    required this.overallThreatLevel,
    required this.detectedThreats,
    required this.deviceFingerprint,
    required super.occurredAt,
  });

  final ThreatLevel overallThreatLevel;
  final List<SecurityThreat> detectedThreats;
  final DeviceFingerprint deviceFingerprint;

  @override
  List<Object?> get props => [
        ...super.props,
        overallThreatLevel,
        detectedThreats,
        deviceFingerprint,
      ];
}

class AppAccessBlocked extends SecurityDomainEvent {
  const AppAccessBlocked({
    required this.reason,
    required this.threatLevel,
    required this.deviceFingerprint,
    required super.occurredAt,
  });

  final String reason;
  final ThreatLevel threatLevel;
  final DeviceFingerprint deviceFingerprint;

  @override
  List<Object?> get props => [
        ...super.props,
        reason,
        threatLevel,
        deviceFingerprint,
      ];
}

class ForceUpdateRequired extends SecurityDomainEvent {
  const ForceUpdateRequired({
    required this.currentVersion,
    required this.requiredVersion,
    required this.reason,
    required super.occurredAt,
  });

  final String currentVersion;
  final String requiredVersion;
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        currentVersion,
        requiredVersion,
        reason,
      ];
}
