import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Keys
  static const String _keyToken = 'token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';

  // Token Management
  Future<void> setToken(String token) async =>
      await _prefs.setString(_keyToken, token);
  String? getToken() => _prefs.getString(_keyToken);

  Future<void> setRefreshToken(String token) async =>
      await _prefs.setString(_keyRefreshToken, token);
  String? getRefreshToken() => _prefs.getString(_keyRefreshToken);

  // User Data
  Future<void> setUserDetails({
    required int id,
    required String name,
    required String email,
  }) async {
    await _prefs.setInt(_keyUserId, id);
    await _prefs.setString(_keyUserName, name);
    await _prefs.setString(_keyUserEmail, email);
  }

  void clearAuth() {
    _prefs.remove(_keyToken);
    _prefs.remove(_keyRefreshToken);
    _prefs.remove(_keyUserId);
    _prefs.remove(_keyUserName);
    _prefs.remove(_keyUserEmail);
  }

  bool get isLoggedIn => getToken() != null;
}
