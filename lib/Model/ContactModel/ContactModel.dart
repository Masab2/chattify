import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String uid;
  final String username;
  final String email;
  final String phone;
  final String image;
  final String status;
  final Timestamp date;

  ContactModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.status,
    required this.date,
  });

  static ContactModel fromSnapshot(DocumentSnapshot snapshot) {
    ContactModel model = ContactModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      phone: snapshot['phoneno'],
      image: snapshot['profileImageURL'],
      status: snapshot['status'],
      date: snapshot['joinedDate'],
    );
    return model;
  }
}
