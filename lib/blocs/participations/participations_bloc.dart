import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/participation_repository.dart';

part 'participations_event.dart';
part 'participations_state.dart';

class ParticipationsBloc
    extends Bloc<ParticipationsEvent, ParticipationsState> {
  final ParticipationRepository participationRepository;
  ParticipationsBloc(this.participationRepository)
      : super(ParticipationsInitial());

  @override
  Stream<ParticipationsState> mapEventToState(
    ParticipationsEvent event,
  ) async* {
    if (event is LoadingParticipations) {
      yield ParticipationsInitial();
      try {
        print("Loading @@@@@");
        final List<Participation> participationData =
            await participationRepository.getParticipations();
        yield ParticipationsLoaded(participations: participationData);
      } catch (e) {
        print("exce: $e");
        yield ParticipationsError();
      }
    }
    if (event is RefreshParticipations) {
      try {
        final List<Participation> participationData =
            await participationRepository.getParticipations();
        yield ParticipationsLoaded(participations: participationData);
      } catch (_) {}
    }
  }
}
