import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mbunge/models/add_reponse.dart';
import 'package:mbunge/models/reponses.dart';
import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/repository/webinar_repository.dart';

part 'addresponse_event.dart';
part 'addresponse_state.dart';

class AddresponseBloc extends Bloc<AddresponseEvent, AddresponseState> {
  final SharePreferenceRepo sharePreferenceRepo = SharePreferenceRepo();
  final WebinarRepository webinarRepository;
  AddresponseBloc(this.webinarRepository) : super(AddresponseInitial());

  @override
  Stream<AddresponseState> mapEventToState(AddresponseEvent event) async* {
    if (event is AddYourOpinion) {
      try {
        yield AddingInProgress();
        AddResponse response = AddResponse(
          userId: await sharePreferenceRepo.getUserId(),
          participationId: event.participationId,
          body: event.body,
        );
        debugPrint("${response.toJson()}");
        final result = await webinarRepository.addResponse(response);
        debugPrint("##################################");
        debugPrint("${result.toJson()}");
        debugPrint("##################################");
        if (result != null) {
          yield AddresponseSuccessfully(result);
        } else {
          yield AddresponseError();
        }
      } catch (e) {
        yield AddresponseError();
      }
    }
  }
}
