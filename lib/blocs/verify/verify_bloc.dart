import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc() : super(VerifyInitial());

  @override
  Stream<VerifyState> mapEventToState(
    VerifyEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
