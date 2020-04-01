import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/event_repository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  EventBloc(this.eventRepository) : super(EventInitial());

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is LoadingEvents) {
      yield EventInitial();
      try {
        print("Loading @@@@@");
        final List<Event> events = await eventRepository.getEvents();
        yield EventsLoaded(events: events);
      } catch (e) {
        print("exce: $e");
        yield EventsError();
      }
    }
    if (event is RefreshEvents) {
      try {
        final List<Event> events = await eventRepository.getEvents();
        yield EventsLoaded(events: events);
      } catch (_) {}
    }
  }
}
