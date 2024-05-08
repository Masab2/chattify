import 'package:chattify/Bloc/ProfileBloc/ProfileEvent.dart';
import 'package:chattify/Bloc/ProfileBloc/ProfileState.dart';
import 'package:chattify/Repository/ProfileRepo/ProfileRepo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileLoadedEvent, ProfileState> {
  final ProfileRepo _repo = ProfileRepo();
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileLoadedEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());
        var data = await _repo.getProfile();
        emit(ProfileSuccessState(profileModel: data));
      } catch (e) {
        emit(ProfileErrorState(errorMessage: e.toString()));
      }
    });
  }
}
