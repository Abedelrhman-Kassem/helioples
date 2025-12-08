import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServicesHelper {
  static void saveLocal(String key, String value) {
    const storage = FlutterSecureStorage();
    storage.write(key: key, value: value);
  }

  static Future<String?> getLocal(String key) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: key);
    return token;
  }

  static void removeLocalToken(String key) {
    const storage = FlutterSecureStorage();
    storage.delete(key: key);
  }
}
