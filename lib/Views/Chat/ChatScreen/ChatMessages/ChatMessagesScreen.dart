import 'package:chattify/Model/MessageModel/MessageModel.dart';
import 'package:chattify/Services/Firebase/firebaseHelper.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  final MessageModel msgModel;
  const ChatMessages({super.key, required this.msgModel});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.all(context.mw * 0.04),
              margin: EdgeInsets.symmetric(
                  horizontal: context.mw * 0.04, vertical: context.mh * 0.01),
              decoration: BoxDecoration(
                  color: AppColor.greyColor.withOpacity(0.34),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: const Text('Hi')),
        ),
      ],
    );
  }

  Widget _yellowMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(context.mw * 0.04),
            margin: EdgeInsets.symmetric(
                horizontal: context.mw * 0.04, vertical: context.mh * 0.01),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: const Text('Hello'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Apis.user.uid == widget.msgModel.fromId
        ? _yellowMessage()
        : _blueMessage();
  }
}
