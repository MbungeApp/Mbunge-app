part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final RegisterRequest registerRequest;

  RegisterUser(this.registerRequest);
  @override
  List<Object> get props => [registerRequest];

  @override
  String toString() => "RegisterUser event: $registerRequest";
}
