import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattify/Bloc/ChatBloc/ChatMessagesBloc/ChatMessageBloc.dart';
import 'package:chattify/Bloc/ChatBloc/ChatMessagesBloc/ChatMessageState.dart';
import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class ChatScreenView extends StatefulWidget {
  final ContactModel model;
  const ChatScreenView({Key? key, required this.model}) : super(key: key);

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Center(child: _buildCustomAppBar()),
      ),
      body: Column(
        children: [
          BlocBuilder<ChatMessageBloc, ChatMessageState>(
            builder: (context, state) {
              if (state is ChatMessageInitialState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: const [
                          Center(child: Text('Please Enter The Message')),
                        ],
                      ),
                    ),
                    _buildMessageInput()
                  ],
                );
              } else if (state is ChatMessageLoadedState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        // itemCount: state,
                        itemBuilder: (context, index) {
                          return const Text('Helllo');
                        },
                      ),
                    ),
                    _buildMessageInput(),
                  ],
                );
              } else if (state is ChatMessageFailureState) {
                return Center(
                  child: Text(
                    state.errorMsg.toString(),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      elevation: 2,
      centerTitle: false,
      titleSpacing: 0,
      title: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesNames.contactProfileScreen,
                  arguments: widget.model,
                );
              },
              child: CircleAvatar(
                backgroundColor: AppColor.whiteColor,
                radius: context.mh * 0.025,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: widget.model.image == ''
                      ? Icon(
                          IconlyBold.profile,
                          size: context.mh * 0.030,
                          color: AppColor.primaryColor,
                        )
                      : CachedNetworkImage(
                          height: context.mw * 0.23,
                          width: context.mw * 0.23,
                          fit: BoxFit.cover,
                          imageUrl: widget.model.image,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(
                            IconlyBold.profile,
                            size: context.mh * 0.045,
                            color: AppColor.whiteColor,
                          ),
                        ),
                ),
              ),
            ),
            0.03.pw(context),
            Text(widget.model.username,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: AppColor.whiteColor,
                  fontSize: context.mh * 0.023,
                )),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyBold.image),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyBold.camera),
          ),
          Expanded(
            child: TextField(
              // controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          IconButton(
            splashColor: AppColor.primaryColor,
            icon: const Icon(IconlyBold.send),
            onPressed: () {
              // // Handle sending message
              // String message = _messageController.text;
              // if (message.isNotEmpty) {
              //   // Clear the text field after sending the message
              //   _messageController.clear();
              //   // Implement sending the message to the recipient
              // }
            },
          ),
        ],
      ),
    );
  }
}
