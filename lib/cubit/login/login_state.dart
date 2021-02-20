part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginUser user;

  LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginError extends LoginState {}
