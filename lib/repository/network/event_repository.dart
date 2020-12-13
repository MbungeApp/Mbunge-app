import 'dart:convert';

import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/utils/network/endpoints.dart';
import 'package:mbunge/utils/network/http.dart';

abstract class EventInterface {
  Future<List<Event>> getEvents();
}

class EventRepository implements EventInterface {
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoints = Endpoints();
  static final EventRepository _userRepository = EventRepository._internal();
  factory EventRepository() {
    return _userRepository;
  }
  EventRepository._internal();

  @override
  Future<List<Event>> getEvents() async {
    final response = await httpClient.getRequest(
      url: endpoints.allEventsEndpoint,
    );
    if (response.statusCode != 200) {
      throw Exception(response.body ?? "Shit happens");
    }
    final responseJson = jsonDecode(response.body);
    return List<Event>.from(
      responseJson.map(
        (x) => Event.fromJson(x),
      ),
    );
  }
}
