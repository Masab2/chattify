import 'package:equatable/equatable.dart';

abstract class AddToChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToChatInitialState extends AddToChatState {}

class AddToChatSuccessState extends AddToChatState {}

class AddToChatFailureState extends AddToChatState {
  final String errorMsg;

  AddToChatFailureState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
