import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/routes.dart';

class LockIcon extends StatelessWidget {
  const LockIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.goBack();
      },
      child: Stack(alignment: Alignment.center, children: [
      const  Icon(Icons.play_arrow),
      //  SvgPicture.asset('assets/icons/lock.svg'),
        SvgPicture.asset("assets/icons/Ellipse 40.svg")
      ]),
    );
  }
}
