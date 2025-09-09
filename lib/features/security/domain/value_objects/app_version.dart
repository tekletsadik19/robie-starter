import 'package:equatable/equatable.dart';

class AppVersion extends Equatable {
  factory AppVersion.parse(String version) {
    final parts = version.split('.');
    if (parts.length < 2) {
      throw ArgumentError('Invalid version format: $version');
    }

    final major = int.tryParse(parts[0]);
    final minor = int.tryParse(parts[1]);

    if (major == null || minor == null) {
      throw ArgumentError('Invalid version format: $version');
    }

    final patch = parts.length > 2 ? int.tryParse(parts[2]) ?? 0 : 0;
    final build = parts.length > 3 ? parts.sublist(3).join('.') : null;

    return AppVersion._(major, minor, patch, build);
  }

  factory AppVersion.create(
    int major,
    int minor, [
    int patch = 0,
    String? build,
  ]) {
    return AppVersion._(major, minor, patch, build);
  }
  const AppVersion._(this.major, this.minor, this.patch, this.build);

  final int major;
  final int minor;
  final int patch;
  final String? build;

  bool isNewerThan(AppVersion other) {
    if (major != other.major) return major > other.major;
    if (minor != other.minor) return minor > other.minor;
    if (patch != other.patch) return patch > other.patch;
    return false;
  }

  bool isOlderThan(AppVersion other) => other.isNewerThan(this);

  bool isEqualTo(AppVersion other) =>
      major == other.major && minor == other.minor && patch == other.patch;

  bool isCompatibleWith(AppVersion minimumVersion) =>
      !isOlderThan(minimumVersion);

  @override
  String toString() {
    final base = '$major.$minor.$patch';
    return build != null ? '$base.$build' : base;
  }

  @override
  List<Object?> get props => [major, minor, patch, build];
}
