import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';


class IconWithTextRowStack extends StatelessWidget {
  final String svg1;
  final String svg2;
  final String text;
  const IconWithTextRowStack({
    super.key,
    required this.text,
    required this.svg1,
    required this.svg2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              svg1,
              width: 18.w,
              height: 18.w,
            ),
            SvgPicture.asset(
              svg2,
              width: 24.w,
              height: 24.w,
            )
          ],
        ),
        width(18),
        body1Text(text)
      ],
    );
  }
}
