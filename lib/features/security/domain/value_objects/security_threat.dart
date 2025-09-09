import 'package:equatable/equatable.dart';

enum ThreatType {
  jailbreak,
  root,
  emulator,
  developmentMode,
  debugging,
  tampering,
  unknown,
}

class SecurityThreat extends Equatable {
  const SecurityThreat({
    required this.type,
    required this.description,
    required this.severity,
    this.recommendation,
  });

  factory SecurityThreat.jailbreak() => const SecurityThreat(
        type: ThreatType.jailbreak,
        description: 'Device is jailbroken',
        severity: 10,
        recommendation:
            'For your security, please use this app on a non-jailbroken device.',
      );

  factory SecurityThreat.root() => const SecurityThreat(
        type: ThreatType.root,
        description: 'Device is rooted',
        severity: 10,
        recommendation:
            'For your security, please use this app on a non-rooted device.',
      );

  factory SecurityThreat.emulator() => const SecurityThreat(
        type: ThreatType.emulator,
        description: 'Running on emulator/simulator',
        severity: 7,
        recommendation:
            'Please use this app on a physical device for the best security.',
      );

  factory SecurityThreat.developmentMode() => const SecurityThreat(
        type: ThreatType.developmentMode,
        description: 'Development mode is enabled',
        severity: 5,
        recommendation:
            'Please disable Developer Options in your device settings.',
      );

  factory SecurityThreat.debugging() => const SecurityThreat(
        type: ThreatType.debugging,
        description: 'USB debugging is enabled',
        severity: 5,
        recommendation: 'Please disable USB debugging in Developer Options.',
      );

  factory SecurityThreat.tampering(String details) => SecurityThreat(
        type: ThreatType.tampering,
        description: 'App tampering detected: $details',
        severity: 9,
        recommendation: 'Please reinstall the app from official sources.',
      );

  final ThreatType type;
  final String description;
  final int severity; // 1-10 scale
  final String? recommendation;

  bool get isCritical => severity >= 8;
  bool get isHigh => severity >= 6;
  bool get isMedium => severity >= 4;
  bool get isLow => severity < 4;

  @override
  List<Object?> get props => [type, description, severity, recommendation];
}
