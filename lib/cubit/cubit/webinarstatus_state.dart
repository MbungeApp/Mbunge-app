part of 'webinarstatus_cubit.dart';

abstract class WebinarstatusState extends Equatable {
  const WebinarstatusState();

  @override
  List<Object> get props => [];
}

class WebinarstatusInitial extends WebinarstatusState {}

class WebinarstatusLoaded extends WebinarstatusState {
  final WebinarStatus webinarStatus;

  WebinarstatusLoaded(this.webinarStatus);

  @override
  List<Object> get props => [webinarStatus];
}

class WebinarstatusError extends WebinarstatusState {
  final String message;

  WebinarstatusError(this.message);
  @override
  List<Object> get props => [message];
}
