enum SecurityThreatLevel {
  none,
  low,
  medium,
  high,
  critical;

  int get severity {
    switch (this) {
      case SecurityThreatLevel.none:
        return 0;
      case SecurityThreatLevel.low:
        return 1;
      case SecurityThreatLevel.medium:
        return 2;
      case SecurityThreatLevel.high:
        return 3;
      case SecurityThreatLevel.critical:
        return 4;
    }
  }

  bool get isSecure => this == SecurityThreatLevel.none;
  bool get requiresAction => severity >= SecurityThreatLevel.medium.severity;
  bool get shouldBlockApp => severity >= SecurityThreatLevel.high.severity;
  bool get isCritical => this == SecurityThreatLevel.critical;

  String get displayName {
    switch (this) {
      case SecurityThreatLevel.none:
        return 'Secure';
      case SecurityThreatLevel.low:
        return 'Low Risk';
      case SecurityThreatLevel.medium:
        return 'Medium Risk';
      case SecurityThreatLevel.high:
        return 'High Risk';
      case SecurityThreatLevel.critical:
        return 'Critical Risk';
    }
  }

  bool isMoreSevereThan(SecurityThreatLevel other) => severity > other.severity;
  bool isLessSevereThan(SecurityThreatLevel other) => severity < other.severity;

  SecurityThreatLevel escalateTo(SecurityThreatLevel other) {
    return isMoreSevereThan(other) ? this : other;
  }
}
