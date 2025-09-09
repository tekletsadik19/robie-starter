import 'package:equatable/equatable.dart';

/// Value object for rocket information
class RocketInfo extends Equatable {
  const RocketInfo({
    required this.id,
    required this.name,
    required this.type,
  });

  final String id;
  final String name;
  final String type;

  /// Check if this is a Falcon 9 rocket
  bool get isFalcon9 {
    return name.toLowerCase().contains('falcon 9') ||
        type.toLowerCase().contains('falcon 9');
  }

  /// Check if this is a Falcon Heavy rocket
  bool get isFalconHeavy {
    return name.toLowerCase().contains('falcon heavy') ||
        type.toLowerCase().contains('falcon heavy');
  }

  /// Check if this is a Starship rocket
  bool get isStarship {
    return name.toLowerCase().contains('starship') ||
        type.toLowerCase().contains('starship');
  }

  /// Get rocket family (Falcon, Starship, etc.)
  String get family {
    if (isFalcon9 || isFalconHeavy) return 'Falcon';
    if (isStarship) return 'Starship';
    return 'Other';
  }

  /// Get display name for the rocket
  String get displayName {
    return name.isNotEmpty ? name : type;
  }

  /// Get rocket description
  String get description {
    if (isFalcon9) {
      return 'Reusable two-stage rocket designed for reliable and safe transport';
    } else if (isFalconHeavy) {
      return 'Heavy-lift launch vehicle with three Falcon 9 boosters';
    } else if (isStarship) {
      return 'Next-generation fully reusable launch vehicle';
    }
    return 'SpaceX launch vehicle';
  }

  @override
  List<Object?> get props => [id, name, type];

  @override
  String toString() => displayName;
}
