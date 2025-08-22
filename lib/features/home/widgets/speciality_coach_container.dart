import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/image_widget.dart';

class SpecialityCoachContainer extends StatefulWidget {
  final String svg;
  final String text1;
  final String text2;
  final String? imgUrl;
  const SpecialityCoachContainer({
    Key? key,
    required this.svg,
    required this.text1,
    required this.text2,
    this.imgUrl,
  }) : super(key: key);

  @override
  State<SpecialityCoachContainer> createState() =>
      _SpecialityCoachContainerState();
}

class _SpecialityCoachContainerState extends State<SpecialityCoachContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF25D366).withOpacity(0.2), // #25D366
            const Color(0xFF03C0FF).withOpacity(0.2), // #03C0FF
          ],
          stops: const [0.0507, 1.1795],
          transform: const GradientRotation(
            2.44,
          ), // 140 degrees in radians
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 25.h,
        horizontal: 14.w,
      ),
      child: Row(
        children: [
          CustomImageWidget(
            url: widget.imgUrl ?? defaultAvatar,
            myradius: 0,
            mywidth: 68,
            myheight: 68,
          ),
          width(10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [heading2Text(widget.text1), body1Text(widget.text2)],
            ),
          )
        ],
      ),
    );
  }
}
