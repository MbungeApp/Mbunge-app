import 'dart:convert';

import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/utils/network/endpoints.dart';
import 'package:mbunge/utils/network/http.dart';

abstract class UserInterface {
  Future<LoginResponse> userLogin(LoginRequest loginRequest);
  Future<RegisterResponse> userRegistration(RegisterRequest registerRequest);
  userVerification();
  userForgetPassword();
}

class UserRepository implements UserInterface {
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoints = Endpoints();

  static final UserRepository _userRepository = UserRepository._internal();
  factory UserRepository() {
    return _userRepository;
  }
  UserRepository._internal();

  @override
  Future<LoginResponse> userLogin(LoginRequest loginRequest) async {
    final response = await httpClient.postRequest(
      url: endpoints.signInEndpoint,
      body: loginRequest.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    final responseJson = jsonDecode(response.body);
    return LoginResponse.fromJson(responseJson);
  }

  @override
  Future<RegisterResponse> userRegistration(
    RegisterRequest registerRequest,
  ) async {
    final response = await httpClient.postRequest(
      url: endpoints.signUpEndpoint,
      body: registerRequest.toJson(),
    );
    if (response.statusCode != 201) {
      throw Exception(response.body);
    }
    return RegisterResponse.fromJson(jsonDecode(response.body));
  }

  @override
  userVerification() {
    // TODO: implement userVerification
    throw UnimplementedError();
  }

  @override
  userForgetPassword() {
    // TODO: implement userForgetPassword
    throw UnimplementedError();
  }
}