import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:shemanit/features/security/infrastructure/models/security_status_model.dart';

abstract class SecurityDataSource {
  Future<SecurityStatusModel> checkSecurityStatus();
  Future<bool> isJailbroken();
  Future<bool> isRooted();
  Future<bool> isEmulator();
  Future<bool> isDevelopmentModeEnabled();
  Future<bool> isDebuggingEnabled();
}

class SecurityDataSourceImpl implements SecurityDataSource {
  const SecurityDataSourceImpl(this._deviceInfo);

  final DeviceInfoPlugin _deviceInfo;

  @override
  Future<SecurityStatusModel> checkSecurityStatus() async {
    final results = await Future.wait([
      isJailbroken(),
      isRooted(),
      isEmulator(),
      isDevelopmentModeEnabled(),
      isDebuggingEnabled(),
    ]);

    final isJailbrokenResult = results[0];
    final isRootedResult = results[1];
    final isEmulatorResult = results[2];
    final isDevelopmentModeEnabledResult = results[3];
    final isDebuggingEnabledResult = results[4];

    final threats = <String>[];
    var threatLevel = SecurityThreatLevelModel.none;

    if (isJailbrokenResult) {
      threats.add('Device is jailbroken');
      threatLevel = SecurityThreatLevelModel.critical;
    }

    if (isRootedResult) {
      threats.add('Device is rooted');
      threatLevel = SecurityThreatLevelModel.critical;
    }

    if (isEmulatorResult) {
      threats.add('Running on emulator/simulator');
      if (threatLevel.index < SecurityThreatLevelModel.high.index) {
        threatLevel = SecurityThreatLevelModel.high;
      }
    }

    if (isDevelopmentModeEnabledResult) {
      threats.add('Development mode is enabled');
      if (threatLevel.index < SecurityThreatLevelModel.medium.index) {
        threatLevel = SecurityThreatLevelModel.medium;
      }
    }

    if (isDebuggingEnabledResult) {
      threats.add('USB debugging is enabled');
      if (threatLevel.index < SecurityThreatLevelModel.medium.index) {
        threatLevel = SecurityThreatLevelModel.medium;
      }
    }

    return SecurityStatusModel(
      isJailbroken: isJailbrokenResult,
      isRooted: isRootedResult,
      isEmulator: isEmulatorResult,
      isDevelopmentModeEnabled: isDevelopmentModeEnabledResult,
      isDebuggingEnabled: isDebuggingEnabledResult,
      threatLevel: threatLevel,
      detectedThreats: threats,
    );
  }

  @override
  Future<bool> isJailbroken() async {
    if (!Platform.isIOS) return false;

    try {
      final detection = JailbreakRootDetection();
      return await detection.isJailBroken;
    } catch (e) {
      // Fallback detection methods for iOS
      return _fallbackJailbreakDetection();
    }
  }

  @override
  Future<bool> isRooted() async {
    if (!Platform.isAndroid) return false;

    try {
      final detection = JailbreakRootDetection();
      return await detection.isJailBroken;
    } catch (e) {
      // Fallback detection methods for Android
      return _fallbackRootDetection();
    }
  }

  @override
  Future<bool> isEmulator() async {
    try {
      final detection = JailbreakRootDetection();
      final isRealDevice = await detection.isRealDevice;
      return !isRealDevice;
    } catch (e) {
      // Fallback emulator detection
      return _fallbackEmulatorDetection();
    }
  }

  @override
  Future<bool> isDevelopmentModeEnabled() async {
    // The jailbreak_root_detection package doesn't provide this method
    // Use fallback detection or return false
    return false;
  }

  @override
  Future<bool> isDebuggingEnabled() async {
    // The jailbreak_root_detection package doesn't provide this method
    // Use fallback detection or return false
    return false;
  }

  Future<bool> _fallbackJailbreakDetection() async {
    if (!Platform.isIOS) return false;

    // Check for common jailbreak files and directories
    final jailbreakPaths = [
      '/Applications/Cydia.app',
      '/Library/MobileSubstrate/MobileSubstrate.dylib',
      '/bin/bash',
      '/usr/sbin/sshd',
      '/etc/apt',
      '/private/var/lib/apt/',
      '/private/var/lib/cydia',
      '/private/var/mobile/Library/SBSettings/Themes',
      '/Library/MobileSubstrate/DynamicLibraries/Veency.plist',
      '/private/var/stash',
      '/private/var/lib/package',
      '/System/Library/LaunchDaemons/com.ikey.bbot.plist',
      '/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist',
      '/private/var/tmp/cydia.log',
      '/Applications/Icy.app',
      '/Applications/MxTube.app',
      '/Applications/RockApp.app',
      '/Applications/blackra1n.app',
      '/Applications/SBSettings.app',
      '/Applications/FakeCarrier.app',
      '/Applications/WinterBoard.app',
      '/Applications/IntelliScreen.app',
    ];

    for (final path in jailbreakPaths) {
      try {
        if (await File(path).exists() || await Directory(path).exists()) {
          return true;
        }
      } catch (e) {
        // Ignore errors and continue checking
      }
    }

    return false;
  }

  Future<bool> _fallbackRootDetection() async {
    if (!Platform.isAndroid) return false;

    // Check for common root files and directories
    final rootPaths = [
      '/system/app/Superuser.apk',
      '/sbin/su',
      '/system/bin/su',
      '/system/xbin/su',
      '/data/local/xbin/su',
      '/data/local/bin/su',
      '/system/sd/xbin/su',
      '/system/bin/failsafe/su',
      '/data/local/su',
      '/su/bin/su',
      '/system/xbin/busybox',
      '/system/bin/busybox',
      '/data/local/xbin/busybox',
      '/data/local/bin/busybox',
      '/system/xbin/daemonsu',
      '/system/etc/init.d/',
      '/system/bin/.ext/',
      '/system/etc/security/cacerts_google',
      '/data/local/tmp/',
      '/dev/com.koushikdutta.superuser.daemon/',
      '/system/app/SuperSU/',
      '/system/xbin/ku.sud',
      '/system/xbin/supolicy',
      '/sbin/magisk',
      '/system/xbin/magisk',
    ];

    for (final path in rootPaths) {
      try {
        if (await File(path).exists() || await Directory(path).exists()) {
          return true;
        }
      } catch (e) {
        // Ignore errors and continue checking
      }
    }

    return false;
  }

  Future<bool> _fallbackEmulatorDetection() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;

        // Check for common emulator characteristics
        final emulatorIndicators = [
          androidInfo.brand.toLowerCase().contains('generic'),
          androidInfo.device.toLowerCase().contains('generic'),
          androidInfo.model.toLowerCase().contains('sdk'),
          androidInfo.model.toLowerCase().contains('emulator'),
          androidInfo.product.toLowerCase().contains('sdk'),
          androidInfo.product.toLowerCase().contains('google_sdk'),
          androidInfo.product.toLowerCase().contains('emulator'),
          androidInfo.manufacturer.toLowerCase().contains('genymotion'),
          androidInfo.fingerprint.toLowerCase().contains('generic'),
          androidInfo.fingerprint.toLowerCase().contains('test-keys'),
        ];

        return emulatorIndicators.any((indicator) => indicator);
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;

        // Check for iOS simulator
        return iosInfo.isPhysicalDevice == false;
      }
    } catch (e) {
      // If we can't determine, assume it's not an emulator
      return false;
    }

    return false;
  }
}
