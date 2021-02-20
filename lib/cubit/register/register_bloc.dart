import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/register_request.dart';
import 'package:mbunge/models/register_response.dart';
import 'package:mbunge/repository/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  RegisterBloc(this.userRepository) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterUserEvent) {
      yield* _mapRegisterUsertoState(event.registerRequest);
    }
  }

  Stream<RegisterState> _mapRegisterUsertoState(
    RegisterRequest registerRequest,
  ) async* {
    yield RegisterInitial();
    try {
      print("##################################");
      print("${registerRequest.toJson()}");
      print("##################################");
      RegisterResponse registerResponse = await userRepository.userRegistration(
        registerRequest,
      );
      print("##################################");
      print("${registerResponse.code}");
      print("##################################");
      yield RegisterSuccess();
    } catch (e) {
      print("Exception: $e");
      yield RegisterError();
    }
  }
}
