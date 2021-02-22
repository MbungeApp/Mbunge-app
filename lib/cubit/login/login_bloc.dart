import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/login_request.dart';
import 'package:mbunge/models/login_response.dart';
import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final SharePreferenceRepo sharePreferenceRepo;
  LoginBloc(this.userRepository, this.sharePreferenceRepo)
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInWithPhone) {
      yield* _mapSignInWithPhoneToState(event.loginRequest);
    }
  }

  Stream<LoginState> _mapSignInWithPhoneToState(
      LoginRequest loginRequest) async* {
    yield LoginInitial();
    try {
      print("reached bloc");
      final loginResponse = await userRepository.userLogin(
        loginRequest,
      );
      if (loginResponse != null) {
        print("##################################");
        print("${loginResponse.token}");
        print("##################################");

        await sharePreferenceRepo.saveUserId(loginResponse.user.id);
        await sharePreferenceRepo.saveToken(loginResponse.token);
        String userString = jsonEncode(loginResponse.user.toJson());
        await sharePreferenceRepo.saveUser(userString);

        yield LoginSuccess(loginResponse.user);
      } else {
        yield LoginError();
      }
    } catch (e) {
      print("Exception: $e");
      yield LoginError();
    }
  }
}
