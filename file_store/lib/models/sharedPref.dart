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

  Future<String> setList(String key, List<String> value) async {
    final SharedPreferences pref = await _prefs;
    pref.setStringList(key, value);
    return "inserted";
  }

  Future<List<String>> getList(String key) async {
    final SharedPreferences pref = await _prefs;
    List<String> result = pref.getStringList(key);

    return result;
  }

  Future<bool> del(String key) async {
    final SharedPreferences pref = await _prefs;
    Future<bool> result = pref.remove(key);
    return true;
  }
}
