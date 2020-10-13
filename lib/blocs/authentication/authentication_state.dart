part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final LoginUser user;

  Authenticated({this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => "Authenicated state: $user";
}

class UnAuthenticated extends AuthenticationState {}
