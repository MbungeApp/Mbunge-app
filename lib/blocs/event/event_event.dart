part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvents extends EventEvent {
  @override
  String toString() => 'LoadingParticipations';
}

class FetchEvents extends EventEvent {
  final List<Event> events;
  FetchEvents({@required this.events}) : assert(events != null);

  @override
  List<Object> get props => [events];

  @override
  String toString() => 'FetchParticipations {participations : $events';
}

class RefreshEvents extends EventEvent {
  final List<Participation> events;
  RefreshEvents({@required this.events}) : assert(events != null);

  @override
  List<Object> get props => [events];

  @override
  String toString() => 'RefreshParticipations';
}
