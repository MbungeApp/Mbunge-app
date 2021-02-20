import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/mp.dart';
import 'package:mbunge/repository/mp_repository.dart';

part 'mps_state.dart';

class MpsCubit extends Cubit<MpsState> {
  final MpRepository mpRepository;
  MpsCubit(this.mpRepository) : super(MpsInitial());

  Future<void> getMps() async {
    try {
      final mps = await mpRepository.getAllMps();
      mps.insert(0, null);
      emit(MpsLoaded(mps));
    } catch (e) {
      print("Stack error: $e");
      emit(MpsError());
    }
  }
}
