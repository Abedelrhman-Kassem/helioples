import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  CacheHelper._();

  static final CacheHelper instance = CacheHelper._();

  static Future<void> init() async {
    await instance._storage.containsKey(key: '__cache_helper_init__');
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  Future<void> saveLocal(String key, dynamic value) async {
    // final encodedValue = _encodeValue(value);

    try {
      await _storage.write(key: key, value: value.toString());
    } catch (e) {
      log('Error saving to secure storage: $e');
      await _storage.delete(key: key);
      await _storage.write(key: key, value: value.toString());
    }
  }

  Future<T?> getLocal<T>(String key) async {
    try {
      final rawValue = await _storage.read(key: key);
      return rawValue != null ? rawValue as T : null;
    } catch (e) {
      log('Error reading from secure storage: $e');
      try {
        await _storage.delete(key: key);
      } catch (_) {}
      return null;
    }
  }

  Future<void> removeLocal(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      log('Error deleting from secure storage: $e');
    }
  }

  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      log('Error clearing secure storage: $e');
    }
  }

  // String _encodeValue(dynamic value) {
  //   if (value is String) return 'string:$value';
  //   if (value is int) return 'int:$value';
  //   if (value is bool) return 'bool:$value';
  //   if (value is double) return 'double:$value';

  //   throw ArgumentError(
  //     'Unsupported value type for secure storage: ${value.runtimeType}',
  //   );
  // }

  // T? _decodeValue<T>(String? rawValue) {
  //   if (rawValue == null) return null;

  //   dynamic parsedValue;
  //   if (rawValue.startsWith('string:')) {
  //     parsedValue = rawValue.substring(7);
  //   } else if (rawValue.startsWith('int:')) {
  //     parsedValue = int.tryParse(rawValue.substring(4));
  //   } else if (rawValue.startsWith('bool:')) {
  //     parsedValue = rawValue.substring(5) == 'true';
  //   } else if (rawValue.startsWith('double:')) {
  //     parsedValue = double.tryParse(rawValue.substring(7));
  //   } else {
  //     parsedValue = rawValue;
  //   }

  //   if (parsedValue == null) return null;
  //   if (T == dynamic || parsedValue is T) return parsedValue as T;
  //   return null;
  // }
}
