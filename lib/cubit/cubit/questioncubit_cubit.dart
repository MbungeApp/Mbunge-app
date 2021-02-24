import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mbunge/models/add_reponse.dart';
import 'package:mbunge/models/reponses.dart';
import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/repository/webinar_repository.dart';

part 'questioncubit_state.dart';

class QuestioncubitCubit extends Cubit<QuestioncubitState> {
  final WebinarRepository webinarRepository;
  final SharePreferenceRepo sharePreferenceRepo;
  QuestioncubitCubit(this.webinarRepository, this.sharePreferenceRepo)
      : super(QuestioncubitInitial());

  Future<void> fetchQuestions(String id) async {
    try {
      final responses = await webinarRepository.getResponses(
        id,
      );
      if (responses != null) {
        emit(QuestioncubitSuccess(responses: responses, message: ""));
      }
    } catch (e) {
      emit(QuestioncubitError(message: e.toString()));
    }
  }

  Future<void> addQuestion({@required String id, @required String body}) async {
    final currentState = state;
    try {
      AddResponse response = AddResponse(
        userId: await sharePreferenceRepo.getUserId(),
        participationId: id,
        body: body,
      );

      debugPrint("${response.toJson()}");

      final result = await webinarRepository.addResponse(response);
      debugPrint("##################################");
      debugPrint("${result.toJson()}");
      debugPrint("##################################");
      if (currentState is QuestioncubitSuccess) {
        final _questions = currentState.responses;
        if (result != null) {
          _questions.insert(0, result);
          _questions.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          emit(
            QuestioncubitSuccess(
              responses: _questions,
              message: "Added successfully!",
            ),
          );
        } else {
          emit(
            QuestioncubitSuccess(
              responses: _questions,
              message: "Unable to add your question!",
            ),
          );
        }
      }
    } catch (e) {}
  }
}
