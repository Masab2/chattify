import 'package:equatable/equatable.dart';

abstract class ChatMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatMessageInitialState extends ChatMessageState {}

class ChatMessageLoadedState extends ChatMessageState {}

class ChatMessageFailureState extends ChatMessageState {
  final String errorMsg;

  ChatMessageFailureState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
