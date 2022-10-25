import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class sharedPref {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getPrefs(String key) async {
    final SharedPreferences pref = await _prefs;
    String result = pref.getString(key);
    return result;
  }

  Future<String> setPrefs(String key, String value) async {
    final SharedPreferences pref = await _prefs;
    pref.setString(key, value);
    return "inserted";
  }
}
