import 'package:equatable/equatable.dart';
import 'package:robbie_starter/core/errors/exceptions.dart';

/// Value object for mission name
class MissionName extends Equatable {
  factory MissionName(String value) {
    if (value.trim().isEmpty) {
      throw const ValidationException(message: 'Mission name cannot be empty');
    }

    if (value.length > 100) {
      throw const ValidationException(
        message: 'Mission name cannot exceed 100 characters',
      );
    }

    return MissionName._(value.trim());
  }
  const MissionName._(this.value);

  final String value;

  /// Get abbreviated mission name (first 20 characters)
  String get abbreviated {
    if (value.length <= 20) return value;
    return '${value.substring(0, 17)}...';
  }

  /// Check if mission name contains a specific keyword
  bool contains(String keyword) {
    return value.toLowerCase().contains(keyword.toLowerCase());
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
