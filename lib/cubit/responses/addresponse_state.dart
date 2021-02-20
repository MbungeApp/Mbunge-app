part of 'addresponse_bloc.dart';

abstract class AddresponseState extends Equatable {
  const AddresponseState();

  @override
  List<Object> get props => [];
}

class AddresponseInitial extends AddresponseState {}

class AddingInProgress extends AddresponseState {}

class AddresponseSuccessfully extends AddresponseState {
  final Responses responses;

  AddresponseSuccessfully(this.responses);
  @override
  List<Object> get props => [responses];
}

class AddresponseError extends AddresponseState {}
