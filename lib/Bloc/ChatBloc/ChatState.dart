import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<ContactModel> model;

  ChatSuccessState({required this.model});
  @override
  List<Object?> get props => [model];
}

class ChatFailureState extends ChatState {
  final String errorMsg;

  ChatFailureState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
