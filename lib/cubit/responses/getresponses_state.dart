part of 'getresponses_bloc.dart';

abstract class GetresponsesState extends Equatable {
  const GetresponsesState();

  @override
  List<Object> get props => [];
}

class GetresponsesInitial extends GetresponsesState {}

class GetresponsesLoaded extends GetresponsesState {
  final List<Responses> responses;

  GetresponsesLoaded(this.responses);

  @override
  List<Object> get props => [responses];
}

class GetresponsesError extends GetresponsesState {}
