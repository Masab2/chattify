import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactInitialState extends ContactState {}

class ContactLoadingState extends ContactState {}

class ContactSuccessState extends ContactState {
  final List<ContactModel> contactModel;
  ContactSuccessState({required this.contactModel});
  @override
  List<Object?> get props => [contactModel];
}

class ContactErrorState extends ContactState {
  final String errorMessage;

  ContactErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
