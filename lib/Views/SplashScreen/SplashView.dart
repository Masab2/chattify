import 'package:chattify/Utils/Asset/ImageAsset.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SplashServices services = SplashServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              height: context.mh * 0.40,
              image: AssetImage(ImageAsset.splashImage),
            ),
          ),
          0.02.ph(context),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(
                    context,
                    RoutesNames.loginScreen,
                  );
                },
                child: Text(
                  'Chattify',
                  style: GoogleFonts.roboto(
                      fontSize: context.mh * 0.036,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Text(
            'easy communication',
            style: GoogleFonts.roboto(
                fontSize: context.mh * 0.020,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
