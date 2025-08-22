import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';


class IconTimeCalendarRow extends StatelessWidget {
  final String svg;
  final String text;
  const IconTimeCalendarRow({
    super.key,
    required this.svg,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          SvgPicture.asset(svg),
          width(2),
          Flexible(
            child: simpleText(
              text,
              fontSize: 9,
              fontWeight: FontWeight.w400,
              color: AppColors.textLight,
            ),
          )
        ],
      ),
    );
  }
}
