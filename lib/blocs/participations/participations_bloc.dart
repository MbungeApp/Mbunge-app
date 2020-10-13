import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'participations_event.dart';
part 'participations_state.dart';

class ParticipationsBloc extends Bloc<ParticipationsEvent, ParticipationsState> {
  ParticipationsBloc() : super(ParticipationsInitial());

  @override
  Stream<ParticipationsState> mapEventToState(
    ParticipationsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
