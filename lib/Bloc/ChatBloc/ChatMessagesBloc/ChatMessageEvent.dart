import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Model/MessageModel/MessageModel.dart';
import 'package:equatable/equatable.dart';

abstract class ChatMessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatSendEvent extends ChatMessageEvent {
  final String message;
  final ContactModel model;
  final MessageModel msgModel;

  ChatSendEvent(this.message, this.model, this.msgModel);
  @override
  List<Object?> get props => [message];
}

class ChatFetchEvent extends ChatMessageEvent {
  @override
  List<Object?> get props => [];
}
