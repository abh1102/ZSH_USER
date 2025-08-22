import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/constants.dart';

void welcomeDialog(BuildContext context) {
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
                SvgPicture.asset(
                  "assets/images/Group 1171275170.svg", // Replace with your SVG file
                  width: 194.w,
                  height: 192.h,
                ),
                height(15),
                Center(
                    child: simpleText("Congratulations",
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    "Welcome to Zanadu Health. Gateway to your Wellness, Health & Happiness.",
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void planInformationDialog(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                heading1Text("BASIC", color: Colors.white),
                height(10),
                simpleText(
                  "Perfect For Beginners",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                height(10),
                simpleText(
                  "120/year",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                height(3),
                body1Text(
                  "14-day free trial.",
                  color: Colors.white,
                ),
                height(26),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 7.h,
                    horizontal: 53.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: simpleText(
                    "Start Trial",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                height(20),
                const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                height(20),
                Center(
                  child: const CheckIconTextRow(
                    text: "Full Length lessons",
                  ),
                ),
                height(6),
                const CheckIconTextRow(
                  text: "FGroup Sessions",
                ),
                height(6),
                const CheckIconTextRow(
                  text: "Health Coach",
                ),
                height(6),
                const CheckIconTextRow(
                  text: "Speciality Coaches",
                ),
                height(6)
              ],
            ),
          ),
        ),
      );
    },
  );
}

class CheckIconTextRow extends StatelessWidget {
  final String text;

  const CheckIconTextRow({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.2), // Adjust as needed
        1: FlexColumnWidth(0.8), // Adjust as needed
      },
      children: [
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/check_.svg",
                  width: 15.0, // Adjust the size as needed
                  height: 15.0,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 16.0), // Adjust the spacing as needed
                child: body1Text(
                  text,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


void discoveryFormDialog(BuildContext context, String svg, String title,
    String description, double mywidth, double myheight) {
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
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    svg,
                    width: mywidth,
                    height: myheight,
                  ),
                ),
                height(15),
                Center(
                    child: simpleText(title,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                height(16),
                Center(
                  child: body1Text(
                    description,
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
