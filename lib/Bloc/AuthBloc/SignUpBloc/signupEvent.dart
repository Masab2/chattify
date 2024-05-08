import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpButtonEvent extends SignUpEvent {
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController phone;

  SignUpButtonEvent(
      {required this.username,
      required this.email,
      required this.password,
      required this.phone});
  @override
  List<Object?> get props => [username, email, password, phone];
}
