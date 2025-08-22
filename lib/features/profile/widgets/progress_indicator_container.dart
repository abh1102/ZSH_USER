import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';

class ProgressIndicatorContainer extends StatelessWidget {
  final String text;
  final dynamic progress;
  final dynamic maxProgress;

  const ProgressIndicatorContainer({
    super.key,
    required this.progress,
    required this.maxProgress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF25D366).withOpacity(
                0.2,
              ),
              Color(0xFF03C0FF).withOpacity(
                0.2,
              ),
            ],
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              body1Text(
                text,
                color: AppColors.textDark,
              ),
              body1Text(
                '${progress.toStringAsFixed(2)}/$maxProgress',
                color: AppColors.textLight,
              ),
            ],
          ),
          height(15),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: LinearProgressIndicator(
              minHeight: 15,
              value: progress / maxProgress,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
            ),
          ),
        ],
      ),
    );
  }
}
