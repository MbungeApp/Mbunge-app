part of 'webinar_cubit.dart';

abstract class WebinarState extends Equatable {
  const WebinarState();

  @override
  List<Object> get props => [];
}

class WebinarInitial extends WebinarState {}

class WebinarSuccess extends WebinarState {
  final List<WebinarModel> webinars;

  WebinarSuccess(this.webinars);
  @override
  List<Object> get props => [webinars];
}

class WebinarError extends WebinarState {
  final String message;

  WebinarError(this.message);
  @override
  List<Object> get props => [message];
}
