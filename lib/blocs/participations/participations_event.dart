part of 'participations_bloc.dart';

abstract class ParticipationsEvent extends Equatable {
  const ParticipationsEvent();

  @override
  List<Object> get props => [];
}

class LoadingParticipations extends ParticipationsEvent {
  @override
  String toString() => 'LoadingParticipations';
}

class FetchParticipations extends ParticipationsEvent {
  final List<Participation> participations;
  FetchParticipations({@required this.participations})
      : assert(participations != null);

  @override
  List<Object> get props => [participations];

  @override
  String toString() => 'FetchParticipations {participations : $participations';
}

class RefreshParticipations extends ParticipationsEvent {
  final List<Participation> participations;
  RefreshParticipations({@required this.participations})
      : assert(participations != null);

  @override
  List<Object> get props => [participations];

  @override
  String toString() => 'RefreshParticipations';
}
