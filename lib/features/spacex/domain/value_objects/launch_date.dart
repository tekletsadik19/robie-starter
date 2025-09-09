import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// Value object for launch date
class LaunchDate extends Equatable {
  factory LaunchDate(DateTime value) {
    return LaunchDate._(value);
  }
  const LaunchDate._(this.value);

  factory LaunchDate.fromString(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return LaunchDate._(date);
    } catch (e) {
      throw FormatException('Invalid date format: $dateString');
    }
  }

  final DateTime value;

  /// Get formatted date string (e.g., "March 2, 2020")
  String get formatted {
    return DateFormat('MMMM d, y').format(value);
  }

  /// Get short formatted date string (e.g., "Mar 2, 2020")
  String get shortFormatted {
    return DateFormat('MMM d, y').format(value);
  }

  /// Get formatted date and time string
  String get formattedWithTime {
    return DateFormat("MMMM d, y 'at' h:mm a").format(value);
  }

  /// Check if launch is in the past
  bool get isPast => value.isBefore(DateTime.now());

  /// Check if launch is in the future
  bool get isFuture => value.isAfter(DateTime.now());

  /// Check if launch is today
  bool get isToday {
    final now = DateTime.now();
    return value.year == now.year &&
        value.month == now.month &&
        value.day == now.day;
  }

  /// Get days until launch (negative if in the past)
  int get daysUntilLaunch {
    final now = DateTime.now();
    final difference = value.difference(now);
    return difference.inDays;
  }

  /// Get relative time description
  String get relativeTime {
    final days = daysUntilLaunch;

    if (isToday) return 'Today';
    if (days == 1) return 'Tomorrow';
    if (days == -1) return 'Yesterday';
    if (days > 0) return '$days days from now';
    if (days < 0) return '${-days} days ago';

    return formatted;
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => formatted;
}
