import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/white_border_white_text_button.dart';
import 'package:zanadu/widgets/whitebg_blacktext_button.dart';

void freeTrialDialog(BuildContext context) {
  showDialog(
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

                height(15),
                Center(
                    child: simpleText("14-day’s free trial",
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    "Your 14-Day free trial ends tomorrow you will be charged \$120/year. Do you wish continue or cancel your plan?",
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                height(64),
                WhiteBgBlackTextButton(
                  text: "Continue",
                ),
                height(24),
                WhiteBorderWhiteTextButton(text: "Cancel")
              ],
            ),
          ),
        ),
      );
    },
  );
}

void upgradeDialog(BuildContext context) {
  showDialog(
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

                height(15),
                Center(
                    child: simpleText("Upgrade Plan",
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    "You are currently on the Basic plan please upgrade to Basic Plus or Premium plan to enable one on one sessions",
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                height(64),
                WhiteBgBlackTextButton(
                  text: "Upgrade",
                ),
                height(24),
                WhiteBorderWhiteTextButton(text: "Go back")
              ],
            ),
          ),
        ),
      );
    },
  );
}

void simpleDialog(
  BuildContext context,
  String heading,
  String text,
  String firstButton,
  String secondButton,
  VoidCallback? onpressed,
) {
  showDialog(
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

                height(15),
                Center(
                    child: simpleText(heading,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    text,
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                height(64),
                GestureDetector(
                  onTap: onpressed,
                  child: WhiteBgBlackTextButton(
                    text: firstButton,
                  ),
                ),
                height(24),
                WhiteBorderWhiteTextButton(
                  text: secondButton,
                  onpressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void simpleDialogWithOneButton(
  BuildContext context,
  String heading,
  String text,
  String firstButton,
  VoidCallback? onpressed,
) {
  showDialog(
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

                height(15),
                Center(
                    child: simpleText(heading,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    text,
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                height(64),
                GestureDetector(
                  onTap: onpressed,
                  child: WhiteBgBlackTextButton(
                    text: firstButton,
                  ),
                ),
                height(24),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void oneSessionScheduledDialog(
  BuildContext context,
  String heading,
  String text,
  String firstButton,
  VoidCallback? onpressed,
) {
  showDialog(
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
//
                SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: SvgPicture.asset("assets/icons/check_icon.svg")),
                height(15),
                Center(
                    child: simpleText(heading,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    text,
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                height(64),
                GestureDetector(
                  onTap: onpressed,
                  child: WhiteBgBlackTextButton(
                    text: firstButton,
                  ),
                ),
                height(24),
              ],
            ),
          ),
        ),
      );
    },
  );
}
