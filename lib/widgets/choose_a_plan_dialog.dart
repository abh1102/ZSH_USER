import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/constants.dart';

void choosePlanDialog(BuildContext context, VoidCallback healthOnpressed,
    VoidCallback specialityOnpressed) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 350.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF25D366),
                Color(0xFF03C0FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 36.h,
              left: 18.w,
              right: 18.w,
              top: 18.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button (SVG picture)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/Vector.svg", // Replace with your SVG file
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                ),

                height(15),

                Center(
                    child: simpleText("Choose A Plan",
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    "Pick a customized health plan with a Health Coach or select your own Speciality Coaches.",
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                height(64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: healthOnpressed,
                      child: const TwoCoachDialogWidget(
                        svg: "assets/images/Mask group (1).svg",
                        text: "Health Coach",
                      ),
                    ),
                    width(43),
                    GestureDetector(
                      onTap: specialityOnpressed,
                      child: const TwoCoachDialogWidget(
                        svg: "assets/images/Mask group.svg",
                        text: "Speciality Coaches",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

class TwoCoachDialogWidget extends StatelessWidget {
  final String svg;
  final String text;
  const TwoCoachDialogWidget({
    super.key,
    required this.svg,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              17,
            ),
          ),
          child: SvgPicture.asset(svg),
        ),
        height(3),
        body2Text(
          text,
          color: Colors.white,
        )
      ],
    );
  }
}
