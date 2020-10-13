part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String username;

  LoginSuccess(this.username);

  @override
  List<Object> get props => [username];
}

class LoginError extends LoginState {}
