part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class SignInWithPhone extends LoginEvent {
  final LoginRequest loginRequest;

  SignInWithPhone(this.loginRequest);

  @override
  List<Object> get props => [loginRequest];

  @override
  String toString() =>
      "SignInWithPhone event phone:${loginRequest.phone} password:${loginRequest.password}";
}
