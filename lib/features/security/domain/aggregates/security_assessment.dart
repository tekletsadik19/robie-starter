import 'package:equatable/equatable.dart';
import 'package:shemanit/features/security/domain/value_objects/threat_level.dart';
import 'package:shemanit/features/security/domain/value_objects/security_threat.dart';
import 'package:shemanit/features/security/domain/value_objects/device_fingerprint.dart';
import 'package:shemanit/features/security/domain/events/security_event.dart';

class SecurityAssessment extends Equatable {
  factory SecurityAssessment.create({
    required DeviceFingerprint deviceFingerprint,
    required List<SecurityThreat> detectedThreats,
  }) {
    final assessmentTime = DateTime.now();
    final overallThreatLevel = _calculateOverallThreatLevel(detectedThreats);
    final isAccessAllowed = _determineAccessPermission(overallThreatLevel);

    final events = <SecurityDomainEvent>[];

    // Generate events for each detected threat
    for (final threat in detectedThreats) {
      events.add(
        SecurityThreatDetected(
          threat: threat,
          deviceFingerprint: deviceFingerprint,
          occurredAt: assessmentTime,
        ),
      );
    }

    // Generate assessment completion event
    events.add(
      SecurityAssessmentCompleted(
        overallThreatLevel: overallThreatLevel,
        detectedThreats: detectedThreats,
        deviceFingerprint: deviceFingerprint,
        occurredAt: assessmentTime,
      ),
    );

    // Generate access blocked event if necessary
    if (!isAccessAllowed) {
      events.add(
        AppAccessBlocked(
          reason: _buildBlockingReason(detectedThreats),
          threatLevel: overallThreatLevel,
          deviceFingerprint: deviceFingerprint,
          occurredAt: assessmentTime,
        ),
      );
    }

    return SecurityAssessment._(
      deviceFingerprint: deviceFingerprint,
      detectedThreats: detectedThreats,
      overallThreatLevel: overallThreatLevel,
      assessmentTime: assessmentTime,
      isAccessAllowed: isAccessAllowed,
      domainEvents: events,
    );
  }
  const SecurityAssessment._({
    required this.deviceFingerprint,
    required this.detectedThreats,
    required this.overallThreatLevel,
    required this.assessmentTime,
    required this.isAccessAllowed,
    required this.domainEvents,
  });

  final DeviceFingerprint deviceFingerprint;
  final List<SecurityThreat> detectedThreats;
  final ThreatLevel overallThreatLevel;
  final DateTime assessmentTime;
  final bool isAccessAllowed;
  final List<SecurityDomainEvent> domainEvents;

  bool get hasThreats => detectedThreats.isNotEmpty;
  bool get hasCriticalThreats => detectedThreats.any((t) => t.isCritical);
  bool get hasHighThreats => detectedThreats.any((t) => t.isHigh);

  List<SecurityThreat> get criticalThreats =>
      detectedThreats.where((t) => t.isCritical).toList();

  List<SecurityThreat> get highThreats =>
      detectedThreats.where((t) => t.isHigh).toList();

  String get primaryRecommendation {
    if (criticalThreats.isNotEmpty) {
      return criticalThreats.first.recommendation ??
          'Address critical security issues.';
    }
    if (highThreats.isNotEmpty) {
      return highThreats.first.recommendation ??
          'Address high security issues.';
    }
    if (detectedThreats.isNotEmpty) {
      return detectedThreats.first.recommendation ?? 'Address security issues.';
    }
    return 'Device is secure.';
  }

  static ThreatLevel _calculateOverallThreatLevel(
    List<SecurityThreat> threats,
  ) {
    if (threats.isEmpty) return ThreatLevel.none;

    final maxSeverity =
        threats.map((t) => t.severity).reduce((a, b) => a > b ? a : b);

    if (maxSeverity >= 10) return ThreatLevel.critical;
    if (maxSeverity >= 8) return ThreatLevel.high;
    if (maxSeverity >= 5) return ThreatLevel.medium;
    if (maxSeverity >= 3) return ThreatLevel.low;
    return ThreatLevel.none;
  }

  static bool _determineAccessPermission(ThreatLevel threatLevel) {
    return !threatLevel.shouldBlockApp;
  }

  static String _buildBlockingReason(List<SecurityThreat> threats) {
    final criticalThreats = threats.where((t) => t.isCritical).toList();
    if (criticalThreats.isNotEmpty) {
      return 'Critical security threats detected: ${criticalThreats.map((t) => t.description).join(', ')}';
    }

    final highThreats = threats.where((t) => t.isHigh).toList();
    if (highThreats.isNotEmpty) {
      return 'High security threats detected: ${highThreats.map((t) => t.description).join(', ')}';
    }

    return 'Security threats detected that require attention.';
  }

  SecurityAssessment clearEvents() {
    return SecurityAssessment._(
      deviceFingerprint: deviceFingerprint,
      detectedThreats: detectedThreats,
      overallThreatLevel: overallThreatLevel,
      assessmentTime: assessmentTime,
      isAccessAllowed: isAccessAllowed,
      domainEvents: const [],
    );
  }

  @override
  List<Object?> get props => [
        deviceFingerprint,
        detectedThreats,
        overallThreatLevel,
        assessmentTime,
        isAccessAllowed,
      ];
}
