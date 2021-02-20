part of 'addresponse_bloc.dart';

abstract class AddresponseEvent extends Equatable {
  const AddresponseEvent();

  @override
  List<Object> get props => [];
}

class AddYourOpinion extends AddresponseEvent {
  final String body;
  final String participationId;

  AddYourOpinion(this.body, this.participationId);

  @override
  List<Object> get props => [body, participationId];
  // final AddResponse response;

  // AddYourOpinion(this.response);

  // @override
  // List<Object> get props => [response];
}
