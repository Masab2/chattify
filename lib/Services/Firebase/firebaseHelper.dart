import 'dart:developer';
import 'dart:io';

import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Model/MessageModel/MessageModel.dart';
import 'package:chattify/Utils/contants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static storage.FirebaseStorage imagestorage =
      storage.FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  // User Authentication
  static Future<void> signUpAccount(
      var email, password, username, phoneno) async {
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      final user = auth.currentUser;
      final userDoc = await firestore
          .collection(userCollection)
          .where('uid', isEqualTo: user!.uid)
          .limit(1)
          .get();
      if (userDoc.docs.isEmpty) {
        firestore.collection(userCollection).doc(user.uid).set(
          {
            'username': username,
            'email': email,
            'uid': user.uid,
            'phoneno': phoneno,
            'profileImageURL': '',
            'status': 'Hey There I am using Chattiffy',
            'joinedDate': DateTime.timestamp()
          },
        );
      }
    });
  }

  // Login To Dashboard
  static Future<void> loginAccount(var email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Update Profile
  static Future<void> updateProfile(File file, userId, status) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = imagestorage.ref().child('/ProfilePic/Images$id');
      storage.UploadTask uploadTask = ref.putFile(file);
      Future.value(uploadTask).then((value) async {
        var imageUrl = await ref.getDownloadURL();
        await firestore.collection(userCollection).doc(userId).update(
          {
            'profileImageURL': imageUrl.toString(),
            'status': status,
          },
        );
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    } catch (e) {
      log(e.toString());
    }
  }

  // Add To Chat Collection
  static Future<void> addToChatCollection(
    ContactModel contactModel,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await firestore.collection(chatsCollection).doc(id).set({
        'username': contactModel.username,
        'email': contactModel.email,
        'uid': contactModel.uid,
        'phoneno': contactModel.phone,
        'profileImageURL': contactModel.image,
        'status': contactModel.status,
        'joinedDate': contactModel.date,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  // get ConservationId
  static String getConversationId(String id) {
    if (user.uid.hashCode <= id.hashCode) {
      return '${user.uid}_$id';
    } else {
      return '${id}_${user.uid}';
    }
  }

  // for fetching all the messages for the specific Conservation Id
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(
      ContactModel model) {
    return firestore
        .collection(
            'chatsMessage/${getConversationId(model.uid.toString())}/messages')
        .snapshots();
  }

  // Send Message To the Another User
  static Future<void> sendMessage(
      ContactModel model, msg, MessageModel msgModel) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await firestore
          .collection(
              'chatsMessage/${getConversationId(model.uid.toString())}/messages')
          .doc(id)
          .set({
        "message": msg,
        "timeStamp": Timestamp.fromDate(DateTime.now()),
        "type": msgModel.msgType,
        "fromUid": user.uid,
        'ToId': model.uid,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
