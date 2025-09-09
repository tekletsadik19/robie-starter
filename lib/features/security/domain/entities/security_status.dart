import 'package:equatable/equatable.dart';
import 'package:shemanit/features/security/domain/value_objects/threat_level.dart';
import 'package:shemanit/features/security/domain/aggregates/security_assessment.dart';

class SecurityStatus extends Equatable {
  const SecurityStatus({
    required this.assessment,
    required this.isSecure,
    required this.requiresAction,
    required this.shouldBlockApp,
    required this.lastChecked,
  });

  final SecurityAssessment assessment;
  final bool isSecure;
  final bool requiresAction;
  final bool shouldBlockApp;
  final DateTime lastChecked;

  ThreatLevel get threatLevel => assessment.overallThreatLevel;

  bool get hasThreats => assessment.hasThreats;
  bool get hasCriticalThreats => assessment.hasCriticalThreats;
  bool get hasHighThreats => assessment.hasHighThreats;

  String get primaryRecommendation => assessment.primaryRecommendation;

  SecurityStatus copyWith({
    SecurityAssessment? assessment,
    bool? isSecure,
    bool? requiresAction,
    bool? shouldBlockApp,
    DateTime? lastChecked,
  }) {
    return SecurityStatus(
      assessment: assessment ?? this.assessment,
      isSecure: isSecure ?? this.isSecure,
      requiresAction: requiresAction ?? this.requiresAction,
      shouldBlockApp: shouldBlockApp ?? this.shouldBlockApp,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }

  @override
  List<Object?> get props => [
        assessment,
        isSecure,
        requiresAction,
        shouldBlockApp,
        lastChecked,
      ];
}
