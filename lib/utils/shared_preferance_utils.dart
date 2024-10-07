import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String dataKey = 'users';

  static Future<void> saveData(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(data);
    await prefs.setString(dataKey, jsonData);
  }

  static Future<dynamic?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(dataKey);
    if (jsonData != null) {
      return json.decode(jsonData);
    }
    return null;
  }

  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(dataKey);
  }
}
