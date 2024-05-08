import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String uid;
  final String username;
  final String email;
  final String phone;
  final String status;
  final String image;

  ProfileModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phone,
    required this.status,
    required this.image,
  });

  static ProfileModel fromSnapshot(DocumentSnapshot snapshot) {
    ProfileModel model = ProfileModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      phone: snapshot['phoneno'],
      status: snapshot['status'],
      image: snapshot['profileImageURL'],
    );
    return model;
  }
}
