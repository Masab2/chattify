import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String fromId;
  final String toId;
  final String message;
  final Timestamp date;
  final Type msgType;

  MessageModel({
    required this.fromId,
    required this.toId,
    required this.message,
    required this.date,
    required this.msgType,
  });
}
