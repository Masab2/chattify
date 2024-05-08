import 'package:chattify/Bloc/AuthBloc/SignUpBloc/signupEvent.dart';
import 'package:chattify/Bloc/AuthBloc/SignUpBloc/signupState.dart';
import 'package:chattify/Repository/AuthRepo/AuthRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepo _authRepo = AuthRepo();
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpButtonEvent>((event, emit) async {
      try {
        emit(SignUpLoadingState());
        await _authRepo
            .signUp(
          event.username,
          event.email,
          event.password,
          event.phone,
        )
            .then((value) {
          emit(SignUpSucessState());
        }).onError((error, stackTrace) {
          emit(SignUpFailureState(errmsg: error.toString()));
        });
      } catch (e) {
        emit(SignUpFailureState(errmsg: e.toString()));
      }
    });
  }
}
