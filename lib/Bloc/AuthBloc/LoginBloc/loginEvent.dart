import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  @override
  //implement props
  List<Object?> get props => [];
}

class LoginButtonEvent extends LoginEvent {
  final TextEditingController email;
  final TextEditingController password;

  LoginButtonEvent({required this.email, required this.password});
  @override
  //implement props
  List<Object?> get props => [email, password];
}
