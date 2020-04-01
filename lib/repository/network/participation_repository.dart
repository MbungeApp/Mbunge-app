import 'dart:convert';

import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/utils/network/http.dart';

abstract class ParticipationInterface {
  Future<List<Participation>> getParticipations();
}

class ParticipationRepository implements ParticipationInterface {
  static final ParticipationRepository _userRepository =
      ParticipationRepository._internal();
  factory ParticipationRepository() {
    return _userRepository;
  }
  ParticipationRepository._internal();

  final HttpClient httpClient = HttpClient();
  @override
  Future<List<Participation>> getParticipations() async {
    final response = await httpClient.getRequest(url: "/participation/");
    print("REEEEE: ${response.statusCode}");
    print("REEEEE: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception('error logging in');
    }
    print("232323");
    final responseJson = jsonDecode(response.body);
    print("1111111");
    return List<Participation>.from(
      responseJson.map((x) => Participation.fromJson(x)),
    ); // participationFromJson(responseJson);
  }
}
