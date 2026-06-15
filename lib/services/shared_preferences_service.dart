import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String isLoginKey = "is_logged_in";

  static const String usernameKey = "username";

  static const String passwordKey = "password";

  Future<void> saveLogin(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(isLoginKey, true);

    await prefs.setString(usernameKey, username);

    await prefs.setString(passwordKey, password);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(isLoginKey) ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
