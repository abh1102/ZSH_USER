import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/lock_icon.dart';



class LockIconWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  const LockIconWidget({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: Insets.fixedGradient(
          opacity: 0.1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 21.w,
          vertical: 21.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: firstText,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: secondText,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            width(10),
            const LockIcon()
          ],
        ),
      ),
    );
  }
}


