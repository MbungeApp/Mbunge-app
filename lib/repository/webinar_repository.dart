import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mbunge/models/add_reponse.dart';
import 'package:mbunge/models/reponses.dart';
import 'package:mbunge/models/webinar_model.dart';
import 'package:mbunge/models/webinar_status.dart';
import 'package:mbunge/util/http/endpoints.dart';
import 'package:mbunge/util/http/http.dart';

class WebinarRepository {
  // singleton
  static final WebinarRepository _webinarRepository =
      WebinarRepository._internal();
  factory WebinarRepository() {
    return _webinarRepository;
  }
  WebinarRepository._internal();

  // Inject services
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoints = Endpoints();

  Future<List<WebinarModel>> getWebinars() async {
    final response = await httpClient.getRequest(
      endpoint: endpoints.allWebinars,
    );
    if (response.statusCode != 200) {
      throw Exception(response.body ?? "Shit happens");
    }
    final webinarModel = webinarModelFromJson(response.body);
    return webinarModel;
  }

  Future<List<Responses>> getResponses(String participationId) async {
    final response = await httpClient.getRequest(
      endpoint: endpoints.allResponsesOfParti(participationId),
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    if (response.body == null) {
      return [];
    }
    final result = responsesFromJson(response.body);
    return result;
  }

  Future<Responses> addResponse(AddResponse response) async {
    try {
      debugPrint("Data to post: ${response.toJson()}");
      final result = await httpClient.postRequest(
        endpoint: endpoints.addResponseEndpoint,
        body: response.toJson(),
      );
      if (result?.statusCode != 201) {
        throw Exception(result.body);
      }
      debugPrint("response: ${result.statusCode}");
      final data = responseOneFromJson(result.body);

      return data;
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<WebinarStatus> checkWebinarStatus(String webinarId) async {
    try {
      final result = await httpClient.getRequest(
        endpoint: endpoints.webinarStatus(webinarId),
      );
      if (result?.statusCode != 200) {
        throw Exception(result.body);
      }
      debugPrint("response: ${result.statusCode}");
      debugPrint("response: ${result.body}");
      final jsonData = json.decode(result.body);
      debugPrint("json: ${jsonData.toString()}");
      WebinarStatus webinarStatus = WebinarStatus.fromJson(jsonData);
      debugPrint("response: ${webinarStatus.toJson()}");
      return webinarStatus;
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
