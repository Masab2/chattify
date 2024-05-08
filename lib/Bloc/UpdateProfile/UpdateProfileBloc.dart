import 'package:chattify/Bloc/UpdateProfile/updateProfileEvent.dart';
import 'package:chattify/Bloc/UpdateProfile/updateProfileState.dart';
import 'package:chattify/Repository/UpdateProfileRepo/UpdateProfileRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileRepo _repo = UpdateProfileRepo();
  UpdateProfileBloc() : super(UpdateProfileInitialState()) {
    on<ProfileUpdateEvent>((event, emit) async {
      try {
        await _repo.updateProfile(event.fileUrl, event.status).then((value) {
          emit(UpdateProfileSuccessState());
        }).onError((error, stackTrace) {
          emit(UpdateProfileFailureState(errormsg: error.toString()));
        });
      } catch (e) {
        emit(UpdateProfileFailureState(errormsg: e.toString()));
      }
    });
  }
}
