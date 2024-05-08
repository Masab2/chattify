import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class ContactDisplayComp extends StatelessWidget {
  final String image;
  final String name;
  final String status;
  final VoidCallback onContacttap;
  final VoidCallback onContactProfiletap;
  const ContactDisplayComp(
      {super.key,
      required this.image,
      required this.name,
      required this.status,
      required this.onContacttap,
      required this.onContactProfiletap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
      child: Column(
        children: [
          ListTile(
            onTap: onContacttap,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.mh * 0.02,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              20,
            )),
            leading: GestureDetector(
              onTap: onContactProfiletap,
              child: Container(
                  height: context.mw * 0.15,
                  width: context.mw * 0.15,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: image == ''
                        ? Icon(
                            IconlyBold.profile,
                            size: context.mh * 0.030,
                            color: AppColor.whiteColor,
                          )
                        : CachedNetworkImage(
                            height: context.mw * 0.23,
                            width: context.mw * 0.23,
                            fit: BoxFit.cover,
                            imageUrl: image,
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
                  )),
            ),
            title: Text(
              name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.016,
              ),
            ),
          ),
          Divider(
            endIndent: context.mw * 0.04,
            indent: context.mw * 0.04,
          )
        ],
      ),
    );
  }
}
