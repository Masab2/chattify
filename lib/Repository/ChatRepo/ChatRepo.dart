import 'dart:developer';

import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Model/MessageModel/MessageModel.dart';
import 'package:chattify/Services/Firebase/firebaseHelper.dart';
import 'package:chattify/Utils/contants/constants.dart';
import 'package:flutter/foundation.dart';

class ChatRepo {
  Future<List<ContactModel>> getAllChats() async {
    List<ContactModel> ContactList = [];
    try {
      final pro = await Apis.firestore
          .collection(chatsCollection)
          .where('uid', isNotEqualTo: Apis.user.uid)
          .get();
      pro.docs.forEach((element) {
        return ContactList.add(ContactModel.fromSnapshot(element));
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return ContactList;
  }

  // Send Message Function to another User
  Future<void> sendMessage(
    ContactModel model,
    MessageModel msgModel,
    msg,
  ) async {
    try {
      Apis.sendMessage(model, msg, msgModel);
    } catch (e) {
      log(e.toString());
    }
  }
}
