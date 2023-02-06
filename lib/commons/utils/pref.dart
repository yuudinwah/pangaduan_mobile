import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> getPref(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}

Future<bool> savePref(String key, dynamic value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else {
      throw 'tipe data tidak support';
    }
  } catch (e) {
    rethrow;
  }
}
