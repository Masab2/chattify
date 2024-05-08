import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSucessState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String errmsg;

  const SignUpFailureState({required this.errmsg});
  @override
  List<Object?> get props => [errmsg];
}
