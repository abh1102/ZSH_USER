import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/constants.dart';

class HelpSupportContainer extends StatelessWidget {
  final String svg;
  final String text;
  final VoidCallback? onpressed;
  const HelpSupportContainer({
    super.key,
    required this.svg,
    required this.text,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          gradient: Insets.fixedGradient(opacity: 0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(
                    svg,
                    width: 24,
                    height: 24,
                  ),
                  width(17),
                  Flexible(
                    child: body1Text(text, color: AppColors.textDark),
                  )
                ],
              ),
            ),
            SvgPicture.asset("assets/icons/chevron-right.svg")
          ],
        ),
      ),
    );
  }
}
