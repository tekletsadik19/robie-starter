import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shemanit/shared/infrastructure/caching/cache_manager.dart';
import 'package:shemanit/shared/infrastructure/security/encryption_service.dart';
import 'package:shemanit/shared/infrastructure/security/secure_storage.dart';

void main() {
  group('Hive Migration with SHA-256 Security', () {
    late Directory tempDir;
    late HiveEncryptionManager encryptionManager;

    setUpAll(() async {
      // Create temporary directory for test
      tempDir = await Directory.systemTemp.createTemp('hive_test');

      // Initialize Hive with test directory
      Hive.init(tempDir.path);

      // Initialize encryption manager
      encryptionManager = HiveEncryptionManager()..initialize();
    });

    tearDownAll(() async {
      // Close all boxes and clean up
      await Hive.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    group('EncryptionService', () {
      test('should generate consistent SHA-256 keys from password', () {
        const password = 'test_password';
        final key1 = EncryptionService.generateKeyFromPassword(password);
        final key2 = EncryptionService.generateKeyFromPassword(password);

        expect(key1, equals(key2));
        expect(key1.length, equals(32)); // 256-bit key
      });

      test('should generate different keys for different passwords', () {
        const password1 = 'test_password_1';
        const password2 = 'test_password_2';

        final key1 = EncryptionService.generateKeyFromPassword(password1);
        final key2 = EncryptionService.generateKeyFromPassword(password2);

        expect(key1, isNot(equals(key2)));
      });

      test('should generate secure random keys', () {
        final key1 = EncryptionService.generateSecureKey();
        final key2 = EncryptionService.generateSecureKey();

        expect(key1, isNot(equals(key2)));
        expect(key1.length, equals(32));
        expect(key2.length, equals(32));
      });

      test('should hash and verify data integrity', () {
        const testData = 'test_data_for_hashing';
        final hash = EncryptionService.hashData(testData);

        expect(hash, isNotEmpty);
        expect(EncryptionService.verifyDataIntegrity(testData, hash), isTrue);
        expect(
          EncryptionService.verifyDataIntegrity('modified_data', hash),
          isFalse,
        );
      });
    });

    group('CacheManager with Hive', () {
      late CacheManager cacheManager;

      setUp(() {
        cacheManager = CacheManagerImpl(encryptionManager);
      });

      tearDown(() async {
        await cacheManager.clear();
      });

      test('should store and retrieve data', () async {
        const key = 'test_key';
        const data = 'test_data';

        await cacheManager.store(key, data);
        final retrieved = await cacheManager.retrieve<String>(key);

        expect(retrieved, equals(data));
      });

      test('should handle complex data types', () async {
        const key = 'complex_data';
        final data = {
          'name': 'Test User',
          'age': 25,
          'active': true,
          'scores': [95, 87, 92],
        };

        await cacheManager.store(key, data);
        final retrieved =
            await cacheManager.retrieve<Map<String, dynamic>>(key);

        expect(retrieved, equals(data));
      });

      test('should check if key exists', () async {
        const key = 'existence_test';
        const data = 'test_data';

        expect(await cacheManager.contains(key), isFalse);

        await cacheManager.store(key, data);
        expect(await cacheManager.contains(key), isTrue);

        await cacheManager.remove(key);
        expect(await cacheManager.contains(key), isFalse);
      });

      test('should clear all cache', () async {
        await cacheManager.store('key1', 'data1');
        await cacheManager.store('key2', 'data2');
        await cacheManager.store('key3', 'data3');

        expect(await cacheManager.contains('key1'), isTrue);
        expect(await cacheManager.contains('key2'), isTrue);
        expect(await cacheManager.contains('key3'), isTrue);

        await cacheManager.clear();

        expect(await cacheManager.contains('key1'), isFalse);
        expect(await cacheManager.contains('key2'), isFalse);
        expect(await cacheManager.contains('key3'), isFalse);
      });
    });

    group('SecureStorage with Hive', () {
      late SecureStorage secureStorage;

      setUp(() {
        secureStorage = SecureStorageImpl(encryptionManager);
      });

      tearDown(() async {
        await secureStorage.clear();
      });

      test('should store and retrieve secure data with integrity check',
          () async {
        const key = 'secure_key';
        const value = 'sensitive_data';

        await secureStorage.store(key, value);
        final retrieved = await secureStorage.retrieve(key);

        expect(retrieved, equals(value));
      });

      test('should handle secure data operations', () async {
        const key = 'auth_token';
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test';

        // Store
        await secureStorage.store(key, token);
        expect(await secureStorage.containsKey(key), isTrue);

        // Retrieve
        final retrieved = await secureStorage.retrieve(key);
        expect(retrieved, equals(token));

        // Delete
        await secureStorage.delete(key);
        expect(await secureStorage.containsKey(key), isFalse);
        expect(await secureStorage.retrieve(key), isNull);
      });

      test('should clear all secure data', () async {
        await secureStorage.store('token1', 'value1');
        await secureStorage.store('token2', 'value2');

        expect(await secureStorage.containsKey('token1'), isTrue);
        expect(await secureStorage.containsKey('token2'), isTrue);

        await secureStorage.clear();

        expect(await secureStorage.containsKey('token1'), isFalse);
        expect(await secureStorage.containsKey('token2'), isFalse);
      });
    });

    group('HiveEncryptionManager', () {
      test('should create different ciphers for different purposes', () {
        final cacheCipher = encryptionManager.cacheCipher;
        final secureCipher = encryptionManager.secureCipher;
        final defaultCipher = encryptionManager.defaultCipher;

        expect(cacheCipher, isNotNull);
        expect(secureCipher, isNotNull);
        expect(defaultCipher, isNotNull);

        // Ciphers should be different instances
        expect(cacheCipher, isNot(same(secureCipher)));
        expect(cacheCipher, isNot(same(defaultCipher)));
        expect(secureCipher, isNot(same(defaultCipher)));
      });

      test('should create secure box configurations', () {
        final cacheConfig =
            encryptionManager.createSecureBoxConfig('test_cache');
        final secureConfig = encryptionManager
            .createSecureBoxConfig('test_secure', isSecure: true);

        expect(cacheConfig.name, equals('test_cache'));
        expect(secureConfig.name, equals('test_secure'));
        expect(cacheConfig.cipher, isNotNull);
        expect(secureConfig.cipher, isNotNull);
        expect(cacheConfig.compactionStrategy, isNotNull);
        expect(secureConfig.compactionStrategy, isNotNull);
      });
    });
  });
}
