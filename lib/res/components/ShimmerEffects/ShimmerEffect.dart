import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade100,
            child: ListTile(
              leading: Container(
                height: context.mw * 0.15,
                width: context.mw * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              title: Container(
                height: 10,
                width: 89,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 10,
                width: 89,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
