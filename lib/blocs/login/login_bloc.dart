import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/user_repository.dart';
import 'package:mbunge/repository/share_preferences.dart';

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
      LoginResponse loginResponse = await userRepository.userLogin(
        loginRequest,
      );
      print("##################################");
      print("${loginResponse.token}");
      print("##################################");

      await sharePreferenceRepo.saveToken(loginResponse.token);
      await sharePreferenceRepo.saveUser(
        loginResponse.user.toString(),
      );

      yield LoginSuccess(loginResponse.user);
    } catch (e) {
      print("Exception: $e");
      yield LoginError();
    }
  }
}
