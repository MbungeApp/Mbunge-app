import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/webinar_status.dart';
import 'package:mbunge/repository/webinar_repository.dart';

part 'webinarstatus_state.dart';

class WebinarstatusCubit extends Cubit<WebinarstatusState> {
  final WebinarRepository webinarRepository;
  WebinarstatusCubit(this.webinarRepository) : super(WebinarstatusInitial());

  Future<void> checkStatus(String id) async {
    try {
      final status = await webinarRepository.checkWebinarStatus(id);
      if (status != null) {
        emit(WebinarstatusLoaded(status));
      }
    } catch (e) {
      emit(WebinarstatusError(e.toString()));
    }
  }
}
