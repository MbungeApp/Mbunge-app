import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceRepo {
  static final SharePreferenceRepo _sharePreferenceRepo =
      SharePreferenceRepo._internal();

  factory SharePreferenceRepo() {
    return _sharePreferenceRepo;
  }

  SharePreferenceRepo._internal();

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  Future<bool> getNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('new_user') ?? false;
  }

  Future<bool> saveNewUser(bool newUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('new_user', newUser);
  }

  Future<String> getUsert() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user") ?? "";
  }

  Future<bool> saveUser(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user", user);
  }

  Future<String> getParticipationCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("parti_cache");
  }

  Future<void> setParticipationCache(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("parti_cache", data);
  }

  Future clearSharePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
