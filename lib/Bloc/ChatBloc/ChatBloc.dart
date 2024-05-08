import 'package:chattify/Bloc/ChatBloc/ChatEvent.dart';
import 'package:chattify/Bloc/ChatBloc/ChatState.dart';
import 'package:chattify/Repository/ChatRepo/ChatRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    final ChatRepo repo = ChatRepo();
    on<ChatLoadedEvent>((event, emit) async {
      try {
        emit(ChatLoadingState());
        var data = await repo.getAllChats();
        emit(ChatSuccessState(model: data));
      } catch (e) {
        emit(ChatFailureState(errorMsg: e.toString()));
      }
    });
  }
}
