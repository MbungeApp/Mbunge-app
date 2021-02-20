import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:mbunge/repository/share_preferences.dart';

class HttpClient {
  // Setup a singleton
  static final HttpClient _httpClient = HttpClient._internal();
  factory HttpClient() {
    return _httpClient;
  }
  HttpClient._internal();

  SharePreferenceRepo sharePreferenceRepo = SharePreferenceRepo();
  static String baseUrl = "https://api.mbungeapp.tech/api/v1";

  static headers(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<http.Response> getRequest({@required String endpoint}) async {
    String token = await sharePreferenceRepo.getToken();
    try {
      http.Response response = await http.Client().get(
        '$baseUrl$endpoint',
        headers: headers(token ?? ""),
      );
      debugPrint("getRequest:\nurl:$endpoint\nresponse:\n$response");
      return response;
    } catch (e) {
      debugPrint(e);
      throw e;
    }
  }

  Future<http.Response> postRequest({
    @required String endpoint,
    @required Map<String, dynamic> body,
  }) async {
    String token = await sharePreferenceRepo.getToken();
    try {
      http.Response response = await http.Client().post(
        '$baseUrl$endpoint',
        headers: headers(token ?? ""),
        body: json.encode(body),
      );
      debugPrint("postRequest:\nurl:$endpoint\nresponse:\n$response");
      return response;
    } catch (e) {
      debugPrint(e);
      throw e;
    }
  }

  Future<http.Response> deleteRequest({
    @required String url,
  }) async {
    final reqUrl = '$baseUrl$url';
    String token = await sharePreferenceRepo.getToken();
    return await http.delete(reqUrl, headers: headers(token ?? ""));
  }
}
