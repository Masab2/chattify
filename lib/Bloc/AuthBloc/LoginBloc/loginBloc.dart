
import 'package:chattify/Bloc/AuthBloc/LoginBloc/loginEvent.dart';
import 'package:chattify/Bloc/AuthBloc/LoginBloc/loginState.dart';
import 'package:chattify/Repository/AuthRepo/AuthRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _repo = AuthRepo();
  LoginBloc() : super(LoginInitialState()) {
    on<LoginButtonEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());
        await _repo.logtIn(event.email, event.password).then((value) {
          emit(LoginSuccessState());
        }).onError((error, stackTrace) {
          emit(LoginFailureState(errorMsg: error.toString()));
        });
      } catch (e) {
        emit(LoginFailureState(errorMsg: e.toString()));
      }
    });
  }
}
