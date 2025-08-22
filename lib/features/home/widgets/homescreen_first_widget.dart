import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';


class HomeScreenFirstWidget extends StatelessWidget {
  const HomeScreenFirstWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              simpleText(
                "Have an Awesome",
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
              height(3),
              simpleText(
                "Wellness Experience",
                fontSize: 19,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 11.w,
            vertical: 11.h,
          ),
          height: 39.h,
          width: 39.w,
          decoration: BoxDecoration(
         
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          child: SvgPicture.asset(
            "assets/icons/Group (6).svg",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
