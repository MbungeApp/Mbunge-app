part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class SignInWithPhone extends LoginEvent {
  final String phone;
  final String password;

  SignInWithPhone(this.phone, this.password);

  @override
  List<Object> get props => [phone, password];

  @override
  String toString() => "SignInWithPhone event phone:$phone password:$password";
}
