import 'package:shared_preferences/shared_preferences.dart';

abstract class SharePreferenceImpl {
  Future<bool> saveNewUser(bool newUser);
  Future<bool> getNewUser();
  Future<bool> saveToken(String token);
  Future<String> getToken();

  Future<bool> saveUser(String user);
  Future<String> getUsert();
}

class SharePreferenceRepo implements SharePreferenceImpl {
  @override
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  @override
  Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  @override
  Future<bool> getNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('new_user') ?? false;
  }

  @override
  Future<bool> saveNewUser(bool newUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('new_user', newUser);
  }

  @override
  Future<String> getUsert() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user") ?? "";
  }

  @override
  Future<bool> saveUser(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user", user);
  }
}
