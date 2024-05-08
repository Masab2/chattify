// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';

abstract class UpdateProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileUpdateEvent extends UpdateProfileEvent {
  final String fileUrl;
  final status;

  ProfileUpdateEvent({required this.fileUrl, required this.status});
  @override
  List<Object?> get props => [fileUrl, status];
}


