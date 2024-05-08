import 'package:chattify/Bloc/ChatBloc/ChatMessagesBloc/ChatMessageEvent.dart';
import 'package:chattify/Bloc/ChatBloc/ChatMessagesBloc/ChatMessageState.dart';
import 'package:chattify/Repository/ChatRepo/ChatRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  ChatMessageBloc() : super(ChatMessageInitialState()) {
    final ChatRepo repo = ChatRepo();
    on<ChatSendEvent>((event, emit) {
      try {
        repo.sendMessage(event.model, event.msgModel, event.message);
        emit(ChatMessageLoadedState());
      } catch (e) {
        emit(ChatMessageFailureState(errorMsg: e.toString()));
      }
    });
    on<ChatFetchEvent>((event, emit) {});
  }
}
