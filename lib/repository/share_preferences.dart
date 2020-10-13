import 'package:shared_preferences/shared_preferences.dart';

abstract class SharePreferenceImpl {
  Future<bool> saveToken(String token);
  Future<String> getToken();
}

class SharePreferenceRepo implements SharePreferenceImpl {
  @override
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }
}
