import 'package:chattify/Services/Firebase/firebaseHelper.dart';
import 'package:flutter/cupertino.dart';

class AuthRepo {
  Future<String?> signUp(
    TextEditingController username,
    TextEditingController email,
    TextEditingController password,
    TextEditingController phoneno,
  ) async {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (emailRegExp.hasMatch(email.text) && password.text.length >= 6) {
      await Apis.signUpAccount(
        email.text,
        password.text,
        username.text,
        phoneno.text,
      );
      return null;
    } else {
      return 'Please Enter The data in Correct Way';
    }
  }

  Future<String?> logtIn(
      TextEditingController email, TextEditingController password) async {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (emailRegExp.hasMatch(email.text) && password.text.length >= 6) {
      await Apis.loginAccount(
        email.text.toString(),
        password.text.toString(),
      );
      return null;
    } else {
      return 'Please Enter The data in Correct Way';
    }
  }
}
