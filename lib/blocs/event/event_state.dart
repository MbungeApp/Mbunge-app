part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  const EventsLoaded({@required this.events}) : assert(events != null);

  @override
  List<Object> get props => [events];

  @override
  String toString() => 'EventsLoaded { events: $events }';
}

class EventsNotLoaded extends EventState {
  @override
  String toString() => 'EventsNotLoaded';
}

class EventsError extends EventState {}

class InternetError extends EventState {}
