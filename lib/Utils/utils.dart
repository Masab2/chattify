import 'dart:ui';

import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Utils {
  // Dialog Box
  static showBlurDialog(
      BuildContext context, title, content, darkbtntext, lightBtntext) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: AppColor.greyColor.withOpacity(0.33),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      darkbtntext,
                      style: GoogleFonts.poppins(color: AppColor.whiteColor),
                    ),
                  ),
                  0.02.pw(context),
                  MaterialButton(
                    color: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(lightBtntext,
                        style: GoogleFonts.poppins(color: AppColor.whiteColor)),
                  ),
                ],
              )
            ],
            backgroundColor: AppColor.greyColor.withOpacity(0.23),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Align(
              alignment: Alignment.topCenter,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: AppColor.whiteColor,
                  fontSize: context.mh * 0.020,
                ),
              ),
            ),
            contentTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    content,
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: context.mh * 0.017,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showDialogImage(BuildContext context, title, VoidCallback onCamera,
      VoidCallback onGallery) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: AppColor.greyColor.withOpacity(0.23),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Align(
              alignment: Alignment.topCenter,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: AppColor.whiteColor,
                  fontSize: context.mh * 0.020,
                ),
              ),
            ),
            contentTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onTap: onCamera,
                  leading: const CircleAvatar(
                    child: Icon(Icons.camera_alt),
                  ),
                  title: Text(
                    'Select From Camera',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                    ),
                  ),
                ),
                Divider(
                  endIndent: context.mw * 0.03,
                  indent: context.mw * 0.03,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onTap: onGallery,
                  leading: const CircleAvatar(
                    child: Icon(Icons.image),
                  ),
                  title: Text(
                    'Select From Gallery',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Date Format Function
  static String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
