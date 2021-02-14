import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static SharedPreferences prefs;

  static void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static int getInt(String key) {
    return ConfigService.prefs.getInt(key);
  }

  static String getString(String key) {
    return ConfigService.prefs.getString(key);
  }

  static void setInt(String key, int value) async {
    await ConfigService.prefs.setInt(key, value);
  }

  static void setString(String key, String str) async {
    await ConfigService.prefs.setString(key, str);
  }
}