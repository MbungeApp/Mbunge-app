import 'dart:convert';

import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/utils/network/http.dart';

abstract class EventInterface {
  Future<List<Event>> getEvents();
}

class EventRepository implements EventInterface {
  static final EventRepository _userRepository = EventRepository._internal();
  factory EventRepository() {
    return _userRepository;
  }
  EventRepository._internal();

  final HttpClient httpClient = HttpClient();
  @override
  Future<List<Event>> getEvents() async {
    final response = await httpClient.getRequest(url: "/events/");
    print("REEEEE: ${response.statusCode}");
    print("REEEEE: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception('error logging in');
    }
    print("232323");
    final responseJson = jsonDecode(response.body);
    print("1111111");
    return List<Event>.from(
      responseJson.map(
        (x) => Event.fromJson(x),
      ),
    );
  }
}
