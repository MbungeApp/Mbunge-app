import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbunge/models/login_request.dart';
import 'package:mbunge/models/login_response.dart';
import 'package:mbunge/models/register_request.dart';
import 'package:mbunge/models/register_response.dart';
import 'package:mbunge/util/http/endpoints.dart';
import 'package:mbunge/util/http/http.dart';

class UserRepository {
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoints = Endpoints();

  static final UserRepository _userRepository = UserRepository._internal();
  factory UserRepository() {
    return _userRepository;
  }
  UserRepository._internal();

  Future<LoginResponse> userLogin(LoginRequest loginRequest) async {
    final response = await httpClient.postRequest(
      endpoint: endpoints.signInEndpoint,
      body: loginRequest.toJson(),
    );
    if (response?.statusCode != 200) {
      throw Exception(response.body);
    }
    debugPrint("response: ${response.statusCode}");
    final loginResponse = loginResponseFromJson(response.body);
    return loginResponse; // LoginResponse.fromJson(responseJson);
  }

  Future<RegisterResponse> userRegistration(
    RegisterRequest registerRequest,
  ) async {
    final response = await httpClient.postRequest(
      endpoint: endpoints.signUpEndpoint,
      body: registerRequest.toJson(),
    );
    if (response?.statusCode != 201) {
      throw Exception(response.body);
    }
    return RegisterResponse.fromJson(jsonDecode(response.body));
  }

  userVerification() {
    // TODO: implement userVerification
    throw UnimplementedError();
  }

  userForgetPassword() {
    // TODO: implement userForgetPassword
    throw UnimplementedError();
  }
}
