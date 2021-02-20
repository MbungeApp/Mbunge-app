import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/reponses.dart';
import 'package:mbunge/repository/webinar_repository.dart';

part 'getresponses_event.dart';
part 'getresponses_state.dart';

class GetresponsesBloc extends Bloc<GetresponsesEvent, GetresponsesState> {
  final WebinarRepository webinarRepository;
  GetresponsesBloc(this.webinarRepository) : super(GetresponsesInitial());

  @override
  Stream<GetresponsesState> mapEventToState(GetresponsesEvent event) async* {
    if (event is FetchResponses) {
      try {
        final responses = await webinarRepository.getResponses(
          event.participationId,
        );
        yield GetresponsesLoaded(responses);
      } catch (e) {
        yield GetresponsesError();
      }
    }
  }
}
