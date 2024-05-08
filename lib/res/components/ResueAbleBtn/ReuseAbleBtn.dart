// ignore_for_file: must_be_immutable

import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Btn extends StatelessWidget {
  String title;
  VoidCallback ontap;
  Color? color;
  final double width;
  final double height;
  Btn(
      {super.key,
      required this.title,
      required this.ontap,
      this.color,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      height: height,
      minWidth: width,
      color: AppColor.primaryColor,
      onPressed: ontap,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: context.mh * 0.018,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
