part of 'updateprofile_cubit.dart';

abstract class UpdateprofileState extends Equatable {
  const UpdateprofileState();

  @override
  List<Object> get props => [];
}

class UpdateprofileInitial extends UpdateprofileState {}
class Updateprofilesuccess extends UpdateprofileState {
  final LoginUser user;

  Updateprofilesuccess(this.user);
  @override
  List<Object> get props => [user];
}
class UpdateprofileError extends UpdateprofileState {
  final String message;

  UpdateprofileError(this.message);
  @override
  List<Object> get props => [message];
}
