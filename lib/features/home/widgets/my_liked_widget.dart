import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';

class MyLikedByWidget extends StatelessWidget {
  final String likeCount;
  const MyLikedByWidget({super.key, required this.likeCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.favorite_rounded,
          color: Colors.red,
          size: 10,
        ),
        width(7),
        Expanded(
          child: simpleText(
            likeCount,
            fontSize: 9,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
