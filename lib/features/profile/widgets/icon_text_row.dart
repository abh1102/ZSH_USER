import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';

class IconWithTextRow extends StatelessWidget {
  final VoidCallback? onpressed;
  final String svg;
  final String text;
  const IconWithTextRow({
    super.key,
    required this.svg,
    required this.text,  this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onpressed,
      child: Row(
        children: [SvgPicture.asset(svg), width(18), body1Text(text)],
      ),
    );
  }
}

class IconWithTextRowPng extends StatelessWidget {
  final VoidCallback? onpressed;
  final String svg;
  final String text;
  const IconWithTextRowPng({
    super.key,
    required this.svg,
    required this.text,  this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onpressed,
      child: Row(
        children: [Image.asset(svg,width: 28,height: 28,color: AppColors.textDark,), width(18), body1Text(text)],
      ),
    );
  }
}
