import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbunge/repository/share_preferences.dart';

class HttpClient {
  static final HttpClient _httpClient = HttpClient._internal();

  factory HttpClient() {
    return _httpClient;
  }

  HttpClient._internal();

  static SharePreferenceRepo sharePreferenceRepo = SharePreferenceRepo();
  static String baseUrl = "http://mbungeapp.tech:5000/api/v1";

  static var header1 = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  static var header2 = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  static Map headers(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<http.Response> getRequest({
    String url,
  }) async {
    final reqUrl = '$baseUrl/$url';
    String token = await sharePreferenceRepo.getToken();
    return await http.get(reqUrl, headers: headers(token));
  }

  Future<http.Response> postRequest(
      {String url, Map<String, dynamic> body}) async {
    final reqUrl = '$baseUrl$url';
    String token = await sharePreferenceRepo.getToken();
    return await http.post(reqUrl, headers: header2, body: jsonEncode(body));
  }

  Future<http.Response> deleteRequest({
    String url,
  }) async {
    final reqUrl = '$baseUrl$url';
    String token = await sharePreferenceRepo.getToken();
    return await http.delete(reqUrl, headers: headers(token));
  }
}
