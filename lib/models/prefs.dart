import 'package:shared_preferences/shared_preferences.dart';

void userPrefs(String token) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('accessToken', token);
}