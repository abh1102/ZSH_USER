 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';

String formatSelectedDateInYMD(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$year-$month-$day';
  }


  class GetTodayScheduleCardSmall extends StatelessWidget {
  const GetTodayScheduleCardSmall({
    super.key,
    required this.sessionType,
    required this.startTime,
    required this.sessionTime,
  });

  final String sessionType;
  final String startTime;
  final String sessionTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: Insets.fixedGradient(opacity: 0.8),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(
        vertical: 9.h,
        horizontal: 22.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          simpleText(
            "Coach Session Detail",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          height(16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    simpleText(
                      "Start Time",
                      fontWeight: FontWeight.w500,
                    ),
                    height(8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 9),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: simpleText(startTime),
                    ),
                  ],
                ),
              ),
              width(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    simpleText("Session Time", fontWeight: FontWeight.w500),
                    height(8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 9),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: simpleText(sessionTime),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height(16),
        ],
      ),
    );
  }
}