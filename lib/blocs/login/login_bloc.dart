import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginBloc(this.userRepository) : super(LoginInitial());

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
    try {
      LoginResponse loginResponse =
          await userRepository.userLogin(loginRequest);
      print("##################################");
      print("${loginResponse.token}");
      print("##################################");
      yield LoginSuccess(loginResponse.user.firstName);
    } catch (e) {
      yield LoginError();
    }
  }
}
