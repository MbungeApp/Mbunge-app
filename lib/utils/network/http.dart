import 'package:http/http.dart' as http;

class HttpClient {
  static String baseUrl = "http://mbungeapp.tech/v1";

  static Future<http.Response> getRequest({
    String url,
  }) async {
    final reqUrl = '$baseUrl/$url';
    return await http.get(reqUrl);
  }

}
