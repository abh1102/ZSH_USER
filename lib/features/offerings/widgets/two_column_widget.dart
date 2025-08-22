import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';


class TwoColumnWidget extends StatelessWidget {
  final String first;
  final String second;
  const TwoColumnWidget({
    super.key,
    required this.first,
    required this.second,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        body1Text(first),
        simpleText(
          second,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        )
      ],
    );
  }
}