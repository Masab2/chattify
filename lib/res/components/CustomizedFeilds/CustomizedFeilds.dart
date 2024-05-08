// ignore_for_file: must_be_immutable

import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomizedFeild extends StatelessWidget {
  String? title;
  String? hint;
  Widget? sufixIcon;
  Widget? prefixIcon;
  bool? obscuretext = false;
  VoidCallback? onchanged;
  TextEditingController controller;
  int maxlines;
  String? Function(String?)? validator;
  CustomizedFeild(
      {super.key,
      this.title,
      this.onchanged,
      required this.controller,
      this.hint,
      this.sufixIcon,
      this.prefixIcon,
      this.maxlines = 1,
      this.obscuretext,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title ?? "",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        0.01.ph(context),
        Container(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscuretext ?? false,
            maxLines: maxlines,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              prefixIcon: prefixIcon,
              prefixIconColor: AppColor.backgroundColor,
              suffixIconColor: AppColor.blackColor,
              suffixIcon: sufixIcon,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
