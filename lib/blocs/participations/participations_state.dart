part of 'participations_bloc.dart';

abstract class ParticipationsState extends Equatable {
  const ParticipationsState();

  @override
  List<Object> get props => [];
}

class ParticipationsInitial extends ParticipationsState {}

//loaded
class ParticipationsLoaded extends ParticipationsState {
  final List<Participation> participations;
  
  const ParticipationsLoaded({@required this.participations}): assert(participations !=null);

  @override
  List<Object> get props => [participations];

  @override
  String toString() => 'ParticipationsLoaded { participations: $participations }';
}


//  data has not been loaded
class ParticipationsNotLoaded extends ParticipationsState {
  @override
  String toString() => 'ProceedingsNotLoaded';
}

class ParticipationsError extends ParticipationsState{}

class InternetError  extends ParticipationsState{}