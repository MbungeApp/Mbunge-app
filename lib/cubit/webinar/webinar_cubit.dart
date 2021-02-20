import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/webinar_model.dart';
import 'package:mbunge/repository/webinar_repository.dart';

part 'webinar_state.dart';

class WebinarCubit extends Cubit<WebinarState> {
  final WebinarRepository webinarRepository;
  WebinarCubit(this.webinarRepository) : super(WebinarInitial());

  Future<void> fetchWebinars() async {
    try {
      final webinars = await webinarRepository.getWebinars();

      if (webinars != null) {
        webinars.insert(0, null);
        emit(WebinarSuccess(webinars));
      }
    } catch (e) {
      emit(WebinarError(e.toString()));
    }
  }
}
