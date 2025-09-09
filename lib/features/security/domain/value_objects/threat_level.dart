import 'package:equatable/equatable.dart';

class ThreatLevel extends Equatable {
  factory ThreatLevel.fromString(String value) {
    return values.firstWhere(
      (level) => level.value == value.toLowerCase(),
      orElse: () => none,
    );
  }
  const ThreatLevel._(this.value, this.severity);

  final String value;
  final int severity;

  static const ThreatLevel none = ThreatLevel._('none', 0);
  static const ThreatLevel low = ThreatLevel._('low', 1);
  static const ThreatLevel medium = ThreatLevel._('medium', 2);
  static const ThreatLevel high = ThreatLevel._('high', 3);
  static const ThreatLevel critical = ThreatLevel._('critical', 4);

  static const List<ThreatLevel> values = [none, low, medium, high, critical];

  bool get isSecure => this == none;
  bool get requiresAction => severity >= medium.severity;
  bool get shouldBlockApp => severity >= high.severity;
  bool get isCritical => this == critical;

  String get displayName {
    switch (this) {
      case none:
        return 'Secure';
      case low:
        return 'Low Risk';
      case medium:
        return 'Medium Risk';
      case high:
        return 'High Risk';
      case critical:
        return 'Critical Risk';
      default:
        return 'Unknown Risk';
    }
  }

  bool isMoreSevereThan(ThreatLevel other) => severity > other.severity;
  bool isLessSevereThan(ThreatLevel other) => severity < other.severity;

  ThreatLevel escalateTo(ThreatLevel other) {
    return isMoreSevereThan(other) ? this : other;
  }

  @override
  List<Object?> get props => [value, severity];

  @override
  String toString() => value;
}
