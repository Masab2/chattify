import 'package:equatable/equatable.dart';

class UpdateProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}



class UpdateProfileInitialState extends UpdateProfileState {}

class UpdateProfileSuccessState extends UpdateProfileState {}

class UpdateProfileFailureState extends UpdateProfileState {
  final String errormsg;

  UpdateProfileFailureState({required this.errormsg});
  @override
  List<Object?> get props => [errormsg];
}
