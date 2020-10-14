import 'dart:convert';

import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/utils/network/http.dart';

abstract class UserInterface {
  Future<LoginResponse> userLogin(LoginRequest loginRequest);
  Future<RegisterResponse> userRegistration(RegisterRequest registerRequest);
  userVerification();
  userForgetPassword();
}

class UserRepository implements UserInterface {
  static final UserRepository _userRepository = UserRepository._internal();
  factory UserRepository() {
    return _userRepository;
  }
  UserRepository._internal();

  final HttpClient httpClient = HttpClient();

  @override
  Future<LoginResponse> userLogin(LoginRequest loginRequest) async {
    final response = await httpClient.postRequest(
      url: "/auth/sign_in",
      body: loginRequest.toJson(),
    );
    print("REEEEE: ${response.statusCode}");
    print("REEEEE: ${response.body}");
    
    if (response.statusCode != 200) {
      throw Exception('error logging in');
    }
    final responseJson = jsonDecode(response.body);
    return LoginResponse.fromJson(responseJson);
  }

  @override
  Future<RegisterResponse> userRegistration(
    RegisterRequest registerRequest,
  ) async {
    final response = await httpClient.postRequest(
      url: "/auth/sign_up",
      body: registerRequest.toJson(),
    );
    if (response.statusCode != 201) {
      throw Exception('error logging in');
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
