import 'dart:io';
import 'dart:developer';
import 'package:chattify/Services/Firebase/firebaseHelper.dart';
import 'package:flutter/material.dart';

class UpdateProfileRepo {
  Future<void> updateProfile(
    String fileUrl,
    TextEditingController status,
  ) async {
    try {
      await Apis.updateProfile(File(fileUrl), Apis.user.uid, status.text);
    } catch (e) {
      log(e.toString());
    }
  }
}
