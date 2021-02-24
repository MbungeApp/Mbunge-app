part of 'questioncubit_cubit.dart';

// abstract class QuestioncubitState extends Equatable {
//   const QuestioncubitState();

//   @override
//   List<Object> get props => [];
// }

abstract class QuestioncubitState {
  const QuestioncubitState();
}

class QuestioncubitInitial extends QuestioncubitState {}

class QuestioncubitSuccess extends QuestioncubitState {
  final List<Responses> responses;
  final String message;

  QuestioncubitSuccess({@required this.responses, @required this.message});
  // @override
  // List<Object> get props => [responses, message];
}

class QuestioncubitError extends QuestioncubitState {
  final String message;

  QuestioncubitError({@required this.message});
}
