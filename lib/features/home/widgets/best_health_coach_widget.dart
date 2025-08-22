import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';

class BestHealthCoachWidget extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const BestHealthCoachWidget({
    super.key, required this.text, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        simpleText(
          text,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.textDark,
        ),
        GestureDetector(onTap:onTap ,
          child: simpleText(
            "See all",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryBlue,
          ),
        )
      ],
    );
  }
}
