import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {

  SharedPreferences prefs = GetIt.I<SharedPreferences>();
  static const String _userToken = 'user_token';

  void saveUserToken(String token) {
    prefs.setString(_userToken, token);
  }

  String getUserToken() {
    return prefs.getString(_userToken) ?? '';
  }

  void clearUserToken() {
    prefs.remove(_userToken);
  }
}