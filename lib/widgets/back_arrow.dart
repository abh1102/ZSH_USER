import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/routes.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.goBack();
      },
      child: Stack(alignment: Alignment.center, children: [
        SvgPicture.asset('assets/icons/arrow-left.svg'),
        SvgPicture.asset("assets/icons/Group 1171274931.svg")
      ]),
    );
  }
}

class BackArrowWhite extends StatelessWidget {
  const BackArrowWhite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.goBack();
      },
      child: Container(
        height: 49.h,
        width: 49.w,
        child: Stack(alignment: Alignment.center, children: [
          SvgPicture.asset('assets/icons/arrow-left (1).svg'),
          SvgPicture.asset("assets/icons/Group 1171274931 (1).svg")
        ]),
      ),
    );
  }
}
