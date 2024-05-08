import 'package:chattify/Model/ProfileModel/ProfileModel.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final List<ProfileModel> profileModel;
  ProfileSuccessState({required this.profileModel});
  @override
  List<Object?> get props => [profileModel];
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  ProfileErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
