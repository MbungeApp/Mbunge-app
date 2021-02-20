part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => "Appstarted event";
}

class LoggedIn extends AuthenticationEvent {
  final LoginUser user;

  LoggedIn({this.user});

  @override
  String toString() => 'LoggedIn';

  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
