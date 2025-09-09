import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shemanit/core/errors/exceptions.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:shemanit/shared/infrastructure/security/encryption_service.dart';

/// Secure storage interface
abstract class SecureStorage {
  /// Store sensitive data
  Future<void> store(String key, String value);

  /// Retrieve sensitive data
  Future<String?> retrieve(String key);

  /// Delete sensitive data
  Future<void> delete(String key);

  /// Check if key exists
  Future<bool> containsKey(String key);

  /// Clear all stored data
  Future<void> clear();
}

@Singleton(as: SecureStorage)
class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl(this._encryptionManager);

  final HiveEncryptionManager _encryptionManager;
  static const String _secureBoxName = 'secure_box';

  Box<String>? _secureBox;

  /// Get or open the secure box with enhanced encryption
  Future<Box<String>> get secureBox async {
    if (_secureBox?.isOpen == true) return _secureBox!;

    final config = _encryptionManager.createSecureBoxConfig(
      _secureBoxName,
      isSecure: true,
    );
    _secureBox = await Hive.openBox<String>(
      config.name,
      encryptionCipher: config.cipher,
      compactionStrategy: config.compactionStrategy ??
          (entries, deletedEntries) => deletedEntries > 50,
    );
    return _secureBox!;
  }

  @override
  Future<void> store(String key, String value) async {
    try {
      final box = await secureBox;

      // Additional SHA-256 hashing for integrity verification
      final valueWithHash = {
        'data': value,
        'hash': EncryptionService.hashData(value),
        'timestamp': DateTime.now().toIso8601String(),
      };

      final jsonString = json.encode(valueWithHash);
      await box.put(key, jsonString);
      Logger.debug('Secure data stored for key: $key');
    } catch (e) {
      Logger.error('Error storing secure data', e);
      throw const CacheException(message: 'Failed to store secure data');
    }
  }

  @override
  Future<String?> retrieve(String key) async {
    try {
      final box = await secureBox;
      final jsonString = box.get(key);
      if (jsonString == null) return null;

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final data = jsonMap['data'] as String;
      final expectedHash = jsonMap['hash'] as String;

      // Verify data integrity using SHA-256
      if (!EncryptionService.verifyDataIntegrity(data, expectedHash)) {
        Logger.error('Data integrity check failed for key: $key');
        await delete(key); // Remove corrupted data
        throw const CacheException(
          message: 'Data integrity verification failed',
        );
      }

      Logger.debug('Secure data retrieved for key: $key');
      return data;
    } catch (e) {
      Logger.error('Error retrieving secure data', e);
      throw const CacheException(message: 'Failed to retrieve secure data');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      final box = await secureBox;
      await box.delete(key);
      Logger.debug('Secure data deleted for key: $key');
    } catch (e) {
      Logger.error('Error deleting secure data', e);
      throw const CacheException(message: 'Failed to delete secure data');
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      final box = await secureBox;
      return box.containsKey(key);
    } catch (e) {
      Logger.error('Error checking secure key existence', e);
      return false;
    }
  }

  @override
  Future<void> clear() async {
    try {
      final box = await secureBox;
      await box.clear();
      Logger.debug('All secure data cleared');
    } catch (e) {
      Logger.error('Error clearing secure data', e);
      throw const CacheException(message: 'Failed to clear secure data');
    }
  }
}
