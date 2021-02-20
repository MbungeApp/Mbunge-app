part of 'getresponses_bloc.dart';

abstract class GetresponsesEvent extends Equatable {
  const GetresponsesEvent();

  @override
  List<Object> get props => [];
}

class FetchResponses extends GetresponsesEvent {
  final String participationId;

  FetchResponses(this.participationId);

  @override
  List<Object> get props => [participationId];
}
