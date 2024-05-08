import 'package:chattify/Bloc/ContactBloc/AddToChatBloc/addToChatEvent.dart';
import 'package:chattify/Bloc/ContactBloc/AddToChatBloc/addToChatState.dart';
import 'package:chattify/Repository/ContactRepo/ContactRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToChatBloc extends Bloc<AddToChatEvent, AddToChatState> {
  AddToChatBloc() : super(AddToChatInitialState()) {
    final ContactRepo contactRepo = ContactRepo();
    on<AddToChatCollectionEvent>((event, emit) async {
      try {
        await contactRepo.addToChatCollection(event.model);
        emit(AddToChatSuccessState());
      } catch (e) {
        emit(AddToChatFailureState(errorMsg: e.toString(),));
      }
    });
  }
}
