import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> getLoggedInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'isUserLoggedIn';
    return prefs.getBool(key);
  }

  static void setLoggedInStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'isUserLoggedIn';
    prefs.setBool(key, value);
    print("login status cached");
  }
}
