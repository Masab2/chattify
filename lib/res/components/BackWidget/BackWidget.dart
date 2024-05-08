import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.greyColor.withOpacity(0.33),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            size: context.mh * 0.020,
          ),
        ),
      ),
    );
  }
}
