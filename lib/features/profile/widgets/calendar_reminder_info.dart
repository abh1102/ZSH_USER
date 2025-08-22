import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';

// ignore: must_be_immutable
class CalendarReminderInfo extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String lessonName;
  bool isSwitched;
  CalendarReminderInfo({
    super.key,
    required this.isSwitched,
    required this.title,
    required this.date,
    required this.time,
    required this.lessonName,
  });

  @override
  State<CalendarReminderInfo> createState() => _CalendarReminderInfoState();
}

class _CalendarReminderInfoState extends State<CalendarReminderInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
        gradient: Insets.fixedGradient(
          opacity: 0.25,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                simpleText(
                  widget.title,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            height(4),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/calendar.svg",
                  width: 12.w,
                  height: 12.h,
                ),
                width(7),
                Flexible(
                  child: simpleText(
                    widget.date,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textLight,
                  ),
                ),
                width(8),
                SvgPicture.asset(
                  "assets/icons/light_time.svg",
                  width: 12.w,
                  height: 12.h,
                ),
                width(7),
                Flexible(
                  child: simpleText(
                    widget.time,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
            height(8),
            body2Text(widget.lessonName)
          ],
        ),
      ),
    );
  }
}
