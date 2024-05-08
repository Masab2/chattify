// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:chattify/Model/ProfileModel/ProfileModel.dart';
import 'package:chattify/Services/Firebase/firebaseHelper.dart';
import 'package:chattify/Utils/contants/constants.dart';

import 'package:flutter/foundation.dart';

class ProfileRepo {
  Future<List<ProfileModel>> getProfile() async {
    List<ProfileModel> profileList = [];
    try {
      final pro = await Apis.firestore
          .collection(userCollection)
          .where('uid', isEqualTo: Apis.user.uid)
          .get();
      pro.docs.forEach((element) {
        return profileList.add(ProfileModel.fromSnapshot(element));
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return profileList;
  }

  // Update Profile Pic
}
