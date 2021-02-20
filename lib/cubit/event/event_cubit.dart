import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/event.dart';
import 'package:mbunge/repository/event_repository.dart';
import 'package:meta/meta.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final EventRepository eventRepository;
  EventCubit(this.eventRepository) : super(EventInitial());

  Future<void> getEvents() async {
    try {
      final List<Event> events = await eventRepository.getEvents();
      events.insert(0, null);
      emit(EventsLoaded(events: events));
    } catch (e) {
      print("exce: $e");
      emit(EventsError());
    }
  }

  Future<void> refreshEvents() async {
    try {
      final List<Event> events = await eventRepository.getEvents();
      emit(EventsLoaded(events: events));
    } catch (e) {
      print("exce: $e");
      emit(EventsError());
    }
  }
}
