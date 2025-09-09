import 'package:equatable/equatable.dart';

/// Value object for launch site information
class LaunchSite extends Equatable {
  const LaunchSite({
    required this.name,
    required this.longName,
  });

  /// Create a launch site from basic name
  factory LaunchSite.fromName(String name) {
    return LaunchSite(
      name: name,
      longName: name,
    );
  }

  final String name;
  final String longName;

  /// Check if this is Kennedy Space Center
  bool get isKennedySpaceCenter {
    return name.toLowerCase().contains('ksc') ||
        name.toLowerCase().contains('kennedy') ||
        longName.toLowerCase().contains('kennedy');
  }

  /// Check if this is Vandenberg
  bool get isVandenberg {
    return name.toLowerCase().contains('vafb') ||
        name.toLowerCase().contains('vandenberg') ||
        longName.toLowerCase().contains('vandenberg');
  }

  /// Get display name (use long name if available, otherwise short name)
  String get displayName {
    return longName.isNotEmpty ? longName : name;
  }

  /// Get abbreviated name for display in limited space
  String get abbreviatedName {
    if (name.length <= 15) return name;
    return '${name.substring(0, 12)}...';
  }

  @override
  List<Object?> get props => [name, longName];

  @override
  String toString() => displayName;
}
