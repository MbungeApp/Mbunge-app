part of 'internet_bloc.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();
  @override
  List<Object> get props => [];
}


class InitiateInternetStream extends InternetEvent {
  @override
  String toString() => "initiateInternetStream event";

}
class InternetStateUpdated extends InternetEvent{
  final bool connected;

  InternetStateUpdated({this.connected});
}