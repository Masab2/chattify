import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const UserInfoListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      semanticContainer: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        20,
      )),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.greyColor.withOpacity(0.45),
          child: Icon(
            icon,
            color: AppColor.primaryColor,
          ),
        ),
        selectedColor: AppColor.primaryColor.withOpacity(0.23),
      splashColor: AppColor.primaryColor.withOpacity(0.23),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.018,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.016,
          ),
        ),
      ),
    );
  }
}

class LogOutListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback ontap;
  const LogOutListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: CircleAvatar(
        backgroundColor: AppColor.greyColor.withOpacity(0.34),
        child: Icon(
          icon,
          color: AppColor.primaryColor,
        ),
      ),
      selectedColor: AppColor.primaryColor.withOpacity(0.23),
      splashColor: AppColor.primaryColor.withOpacity(0.23),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: context.mh * 0.018,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
