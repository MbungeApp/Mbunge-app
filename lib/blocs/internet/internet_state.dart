part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();
  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {
  @override
  String toString() => "InternetConnected state";
}

class InternetDisconnected extends InternetState {
  @override
  String toString() => "InternetDisconnected state";
}
