import 'dart:convert';

import 'package:mbunge/models/event.dart';
import 'package:mbunge/util/http/endpoints.dart';
import 'package:mbunge/util/http/http.dart';

class EventRepository {
  // singleton
  static final EventRepository _eventRepository = EventRepository._internal();
  factory EventRepository() {
    return _eventRepository;
  }
  EventRepository._internal();

  // Inject services
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoints = Endpoints();

  Future<List<Event>> getEvents() async {
    final response = await httpClient.getRequest(
      endpoint: endpoints.allEventsEndpoint,
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
