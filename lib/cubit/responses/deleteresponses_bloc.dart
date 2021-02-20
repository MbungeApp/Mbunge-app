import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deleteresponses_event.dart';
part 'deleteresponses_state.dart';

class DeleteresponsesBloc extends Bloc<DeleteresponsesEvent, DeleteresponsesState> {
  DeleteresponsesBloc() : super(DeleteresponsesInitial());

  @override
  Stream<DeleteresponsesState> mapEventToState(
    DeleteresponsesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
