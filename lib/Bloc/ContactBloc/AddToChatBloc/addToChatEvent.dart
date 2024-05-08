import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:equatable/equatable.dart';

abstract class AddToChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToChatCollectionEvent extends AddToChatEvent {
  final ContactModel model;

  AddToChatCollectionEvent(this.model);
  @override
  List<Object?> get props => [model];
}
