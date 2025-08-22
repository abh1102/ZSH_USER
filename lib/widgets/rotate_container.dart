import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/home/widgets/homescreen_first_widget.dart';

class RotateContainerTwo extends StatelessWidget {
  const RotateContainerTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 100.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 14.w,
      ),
      decoration: BoxDecoration(
          gradient: Insets.fixedGradient(opacity: 0.25),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/health_score_icon.svg"),
                width(10),
                simpleText(
                  "My Health Score",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              simpleText(
                myUser?.finalScore?.toStringAsFixed(1)??"",
            
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              simpleText(
                "out of 10",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.textLight,
              )
            ],
          )
        ],
      ),
    );
  }
}

class RotateContainerOne extends StatelessWidget {
  const RotateContainerOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 100.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 14.w,
        ),
        decoration: BoxDecoration(
            gradient: Insets.fixedGradient(opacity: 0.25),
            borderRadius: BorderRadius.circular(10)),
        child: const HomeScreenFirstWidget());
  }
}
