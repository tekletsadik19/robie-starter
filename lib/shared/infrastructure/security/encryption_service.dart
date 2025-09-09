import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/utils/logger.dart';

/// Encryption service for Hive using SHA-256
@singleton
class EncryptionService {
  /// Generate a secure key from password using SHA-256
  static Uint8List generateKeyFromPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return Uint8List.fromList(digest.bytes);
  }

  /// Generate a random secure key
  static Uint8List generateSecureKey() {
    final random = Random.secure();
    final key = Uint8List(32); // 256-bit key
    for (var i = 0; i < 32; i++) {
      key[i] = random.nextInt(256);
    }
    return key;
  }

  /// Create Hive cipher with SHA-256 derived key
  static HiveCipher createCipher(String password) {
    final key = generateKeyFromPassword(password);
    Logger.debug('Created Hive cipher with SHA-256 derived key');
    return HiveAesCipher(key);
  }

  /// Create Hive cipher with secure random key
  static HiveCipher createSecureCipher() {
    final key = generateSecureKey();
    Logger.debug('Created Hive cipher with secure random key');
    return HiveAesCipher(key);
  }

  /// Hash data with SHA-256 for integrity verification
  static String hashData(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verify data integrity using SHA-256 hash
  static bool verifyDataIntegrity(String data, String expectedHash) {
    final actualHash = hashData(data);
    return actualHash == expectedHash;
  }
}

/// Secure Hive box configuration
class SecureBoxConfig {
  const SecureBoxConfig({
    required this.name,
    required this.cipher,
    this.compactionStrategy,
  });

  final String name;
  final HiveCipher cipher;
  final CompactionStrategy? compactionStrategy;
}

/// Hive encryption manager
@singleton
class HiveEncryptionManager {
  static const String _defaultPassword = 'shemanit_secure_key_2024';

  late final HiveCipher _defaultCipher;
  late final HiveCipher _cacheCipher;
  late final HiveCipher _secureCipher;

  /// Initialize encryption ciphers
  void initialize() {
    _defaultCipher = EncryptionService.createCipher(_defaultPassword);
    _cacheCipher = EncryptionService.createCipher('${_defaultPassword}_cache');
    _secureCipher =
        EncryptionService.createCipher('${_defaultPassword}_secure');
    Logger.debug('Hive encryption manager initialized');
  }

  /// Get cipher for cache operations
  HiveCipher get cacheCipher => _cacheCipher;

  /// Get cipher for secure storage operations
  HiveCipher get secureCipher => _secureCipher;

  /// Get default cipher
  HiveCipher get defaultCipher => _defaultCipher;

  /// Create secure box configuration
  SecureBoxConfig createSecureBoxConfig(
    String boxName, {
    bool isSecure = false,
  }) =>
      SecureBoxConfig(
        name: boxName,
        cipher: isSecure ? secureCipher : cacheCipher,
        compactionStrategy: (entries, deletedEntries) => deletedEntries > 50,
      );
}
