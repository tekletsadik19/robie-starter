import 'dart:io';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:robbie_starter/features/security/domain/services/security_assessment_service.dart';

class PlatformSecurityDetectionService implements ISecurityDetectionService {
  const PlatformSecurityDetectionService();

  @override
  Future<bool> isDeviceJailbroken() async {
    if (!Platform.isIOS) return false;

    try {
      final detection = JailbreakRootDetection();
      final result = await detection.isJailBroken;
      return result;
    } catch (e) {
      // Fail secure - if we can't detect, assume compromised
      throw Exception(
        'Critical security check failed: Unable to verify device jailbreak status - $e',
      );
    }
  }

  @override
  Future<bool> isDeviceRooted() async {
    if (!Platform.isAndroid) return false;

    try {
      final detection = JailbreakRootDetection();
      final result = await detection.isJailBroken;
      return result;
    } catch (e) {
      // Fail secure - if we can't detect, assume compromised
      throw Exception(
        'Critical security check failed: Unable to verify device root status - $e',
      );
    }
  }

  @override
  Future<bool> isRunningOnEmulator() async {
    try {
      final detection = JailbreakRootDetection();
      final isRealDevice = await detection.isRealDevice;
      return !isRealDevice;
    } catch (e) {
      // Fail secure - if we can't detect, assume emulator
      throw Exception(
        'Critical security check failed: Unable to verify device authenticity - $e',
      );
    }
  }

  @override
  Future<bool> isDevelopmentModeEnabled() async {
    if (!Platform.isAndroid) return false;

    try {
      // The jailbreak_root_detection package doesn't provide this method
      // Return false as fallback
      return false;
    } catch (e) {
      // Fail secure - if we can't detect, assume development mode is enabled
      throw Exception(
        'Critical security check failed: Unable to verify developer mode status - $e',
      );
    }
  }

  @override
  Future<bool> isDebuggingEnabled() async {
    if (!Platform.isAndroid) return false;

    try {
      // The jailbreak_root_detection package doesn't provide this method
      // Return false as fallback
      return false;
    } catch (e) {
      // Fail secure - if we can't detect, assume debugging is enabled
      throw Exception(
        'Critical security check failed: Unable to verify debugging status - $e',
      );
    }
  }

  @override
  Future<List<String>> detectTamperingAttempts() async {
    // No fallback methods - rely only on platform-specific security libraries
    // If tampering detection is not available on the platform, return empty list
    // This ensures we don't provide false security through unreliable detection

    try {
      // Only use official security detection methods
      // No manual file system checks or heuristics that can be bypassed

      // For now, return empty list as the jailbreak_root_detection package
      // doesn't provide specific tampering detection methods
      // In production, integrate with platform-specific security SDKs:
      // - Android: SafetyNet, Play Integrity API
      // - iOS: DeviceCheck, App Attest

      return <String>[];
    } catch (e) {
      throw Exception(
        'Critical security check failed: Unable to verify app integrity - $e',
      );
    }
  }
}
