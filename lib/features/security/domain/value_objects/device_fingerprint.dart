import 'package:equatable/equatable.dart';

class DeviceFingerprint extends Equatable {
  const DeviceFingerprint({
    required this.deviceId,
    required this.platform,
    required this.osVersion,
    required this.appVersion,
    required this.isPhysicalDevice,
    this.manufacturer,
    this.model,
    this.buildFingerprint,
  });

  final String deviceId;
  final String platform; // iOS, Android
  final String osVersion;
  final String appVersion;
  final bool isPhysicalDevice;
  final String? manufacturer;
  final String? model;
  final String? buildFingerprint;

  bool get isEmulator => !isPhysicalDevice;

  bool get isAndroid => platform.toLowerCase() == 'android';
  bool get isIOS => platform.toLowerCase() == 'ios';

  bool hasKnownEmulatorSignatures() {
    // Remove heuristic-based emulator detection as it can be bypassed
    // Only rely on official platform APIs for emulator detection
    // This method is kept for compatibility but always returns false
    // Real emulator detection should use JailbreakRootDetection.isOnEmulator
    return false;
  }

  @override
  List<Object?> get props => [
        deviceId,
        platform,
        osVersion,
        appVersion,
        isPhysicalDevice,
        manufacturer,
        model,
        buildFingerprint,
      ];
}
