import 'package:bloc/bloc.dart';
import 'package:chattify/Bloc/ContactBloc/ContactEvent.dart';
import 'package:chattify/Bloc/ContactBloc/ContactState.dart';
import 'package:chattify/Repository/ContactRepo/ContactRepo.dart';

class ContactBloc extends Bloc<ContactLoadedEvent, ContactState> {
  ContactBloc() : super(ContactInitialState()) {
    final ContactRepo repo = ContactRepo();
    on<ContactLoadedEvent>((event, emit) async {
      try {
        emit(ContactLoadingState());
        var data = await repo.getAllContact();
        emit(ContactSuccessState(contactModel: data));
      } catch (e) {
        emit(ContactErrorState(errorMessage: e.toString()));
      }
    });
  }
}
