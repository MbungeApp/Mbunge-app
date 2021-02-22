import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/edit_user_model.dart';
import 'package:mbunge/models/login_response.dart';
import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/repository/user_repository.dart';

part 'updateprofile_state.dart';

class UpdateprofileCubit extends Cubit<UpdateprofileState> {
  final UserRepository userRepository;
  final SharePreferenceRepo sharePreferenceRepo;
  UpdateprofileCubit(this.userRepository, this.sharePreferenceRepo)
      : super(UpdateprofileInitial());

  Future<void> updateProfile(String userId, EditUserModel editUserModel) async {
    try {
      LoginUser user = await userRepository.updateUserProfile(
        userId,
        editUserModel,
      );
      if (user != null) {
        String userString = jsonEncode(user.toJson());
        await sharePreferenceRepo.saveUser(userString);
        emit(Updateprofilesuccess(user));
      } else {
        emit(UpdateprofileError("An error occured"));
      }
    } catch (e) {
      print(e.toString());
      emit(UpdateprofileError(e.toString()));
    }
  }
}
