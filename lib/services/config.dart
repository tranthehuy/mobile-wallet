import 'package:shared_preferences/shared_preferences.dart';
import '../utils/const.dart';

class ConfigService {
  static SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
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

  String translate(String key) {
    if (prefs == null) return key;
    String lang = getString('language');
    if (lang == 'vn') return key;
    if (translatedText[key] == null) {
      print('Missing key $key');
    }
    return translatedText[key] ?? key;
  }

  String translateAndReplace(String key, String value) {
    return translate(key).replaceAll('#1', value);
  }
}