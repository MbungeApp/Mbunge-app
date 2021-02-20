part of 'mps_cubit.dart';

abstract class MpsState extends Equatable {
  const MpsState();

  @override
  List<Object> get props => [];
}

class MpsInitial extends MpsState {}

class MpsLoaded extends MpsState {
  final List<MPs> mps;

  MpsLoaded(this.mps);

  @override
  String toString() => "got $mps";

  @override
  List<Object> get props => [mps];
}

class MpsError extends MpsState {}
