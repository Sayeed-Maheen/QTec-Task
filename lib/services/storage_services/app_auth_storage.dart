import 'package:get_storage/get_storage.dart';

import '../../constants/storage_key.dart';
import '../../utils/app_all_log/error_log.dart';

class AppAuthStorage {
  final GetStorage box = GetStorage();

  // Set token with proper error handling and debugging
  Future<bool> setToken(String value) async {
    try {
      await box.write(StorageKey.token, value);
      print("Token saved successfully: $value");
      return true;
    } catch (e) {
      errorLog("set token ", e);
      return false;
    }
  }

  // Get token with improved error handling and debugging
  String? getToken() {
    try {
      final token = box.read<String>(StorageKey.token);
      print("Retrieved token: $token");
      return token;
    } catch (e) {
      errorLog("get token", e);
      return null;
    }
  }

  // Clear storage with proper error handling
  Future<bool> storageClear() async {
    try {
      await box.erase();
      print("Storage cleared successfully");
      return true;
    } catch (e) {
      errorLog("logout", e);
      return false;
    }
  }

  // Check if user is logged in
  bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }
}
