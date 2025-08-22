import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';


class SimpleButton extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final double? myheight;
  final double? mywidht;
  const SimpleButton({
    super.key,
    required this.text,
    required this.size,
    required this.weight,
    this.myheight,
    this.mywidht,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: mywidht ?? double.infinity,
      height: myheight ?? 60.h,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(50)),
      child: simpleText(
        text,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
