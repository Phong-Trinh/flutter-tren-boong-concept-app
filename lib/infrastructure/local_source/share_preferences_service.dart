import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<void> setUserId(String id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
  }

  static Future<String?> getUserId() async {
    var prefs = await SharedPreferences.getInstance();
    String? action = prefs.getString('userId');
    return action;
  }
}
