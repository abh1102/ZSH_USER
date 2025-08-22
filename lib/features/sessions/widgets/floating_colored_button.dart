import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';


class FloatingColoredButton extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final double verticalPadding;
  final VoidCallback? onpressed;

  const FloatingColoredButton({
    super.key,
    required this.text,
    required this.size,
    required this.weight,
    required this.verticalPadding,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: GestureDetector(
        onTap: onpressed,
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF03C0FF),
                Color(0xFF25D366),
              ],
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding.h,
            ),
            child: simpleText(
              text,
              fontSize: size,
              fontWeight: weight,
              color: Colors.white, // Text color
            ),
          ),
        ),
      ),
    );
  }
}
