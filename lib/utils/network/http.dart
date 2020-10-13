import 'package:http/http.dart' as http;
import 'package:mbunge/repository/share_preferences.dart';

class HttpClient {
  static SharePreferenceRepo sharePreferenceRepo = SharePreferenceRepo();
  static String baseUrl = "http://mbungeapp.tech:5000/api/v1";

  static var header1 = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  static Map headers(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  static Future<http.Response> getRequest({
    String url,
  }) async {
    final reqUrl = '$baseUrl/$url';
    String token = await sharePreferenceRepo.getToken();
    return await http.get(reqUrl, headers: headers(token));
  }

  static Future<http.Response> postRequest({String url, dynamic body}) async {
    final reqUrl = '$baseUrl/$url';
    String token = await sharePreferenceRepo.getToken();
    return await http.post(reqUrl, headers: headers(token), body: body);
  }

  static Future<http.Response> deleteRequest({
    String url,
  }) async {
    final reqUrl = '$baseUrl/$url';
    String token = await sharePreferenceRepo.getToken();
    return await http.delete(reqUrl, headers: headers(token));
  }
}
