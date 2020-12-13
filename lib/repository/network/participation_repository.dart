import 'dart:convert';

import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/utils/network/endpoints.dart';
import 'package:mbunge/utils/network/http.dart';

import '../share_preferences.dart';

abstract class ParticipationInterface {
  Future<List<Participation>> getParticipations({bool isOffline = false});
}

class ParticipationRepository implements ParticipationInterface {
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoints = Endpoints();

  SharePreferenceRepo sharePreferenceRepo = SharePreferenceRepo();

  static final ParticipationRepository _userRepository =
      ParticipationRepository._internal();
  factory ParticipationRepository() {
    return _userRepository;
  }
  ParticipationRepository._internal();

  @override
  Future<List<Participation>> getParticipations(
      {bool isOffline = false}) async {
    if (isOffline) {
      final response = await sharePreferenceRepo.getParticipationCache();
      final responseJson = jsonDecode(response);
      return List<Participation>.from(
        responseJson.map(
          (x) => Participation.fromJson(x),
        ),
      );
    } else {
      final response = await httpClient.getRequest(
        url: endpoints.allParticipationsEndpoint,
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      await sharePreferenceRepo.setParticipationCache(response.body);
      final responseJson = jsonDecode(response.body);
      return List<Participation>.from(
        responseJson.map(
          (x) => Participation.fromJson(x),
        ),
      );
    }
  }
}
