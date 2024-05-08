import 'package:chattify/Utils/Asset/ImageAsset.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  const AuthHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        0.03.ph(context),
        Center(
          child: Image(
            image: AssetImage(ImageAsset.inappLogo),
            height: context.mh * 0.20,
          ),
        ),
        0.01.ph(context),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.023,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
