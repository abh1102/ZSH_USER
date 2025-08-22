import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';

class DividerWithText extends StatefulWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  State<DividerWithText> createState() => _DividerWithTextState();
}

class _DividerWithTextState extends State<DividerWithText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Divider(color: AppColors.textLight),
        ),
        width(10),
        simpleText(
          widget.text,
          color: AppColors.textLight,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        width(10),
        Flexible(
          child: Divider(color: AppColors.textLight),
        ),
      ],
    );
  }
}
