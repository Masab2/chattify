// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Services/Firebase/firebaseHelper.dart';
import 'package:chattify/Utils/contants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ContactRepo {
  Future<List<ContactModel>> getAllContact() async {
    List<ContactModel> ContactList = [];
    try {
      final pro = await Apis.firestore
          .collection(userCollection)
          // .where('uid', isNotEqualTo: Apis.user.uid)
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

  // Add To Chat Collection
  Future<String?> addToChatCollection(ContactModel model) async {
    QuerySnapshot snapshot =
        await Apis.firestore.collection(chatsCollection).get();
    for (var doc in snapshot.docs) {          
      final data = doc.data() as Map<String, dynamic>;
      if (data['uid'] == model.uid) {
        return 'Contact is Already Added';
      } else {
        try {
          await Apis.addToChatCollection(model);
        } catch (e) {
          log(e.toString());
        }
        return null;
      }
    }
    return null;
  }
}
