import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServicesHelper {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  static Future<void> saveLocal(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      log('Error saving to secure storage: $e');
      // If write fails, try to delete and rewrite
      await _storage.delete(key: key);
      await _storage.write(key: key, value: value);
    }
  }

  static Future<String?> getLocal(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value;
    } catch (e) {
      log('Error reading from secure storage: $e');
      // If read fails due to decryption error, delete the corrupted data
      try {
        await _storage.delete(key: key);
      } catch (_) {}
      return null;
    }
  }

  static Future<void> removeLocal(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      log('Error deleting from secure storage: $e');
    }
  }

  /// Clear all secure storage data (use when encryption errors occur)
  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      log('Error clearing secure storage: $e');
    }
  }
}
