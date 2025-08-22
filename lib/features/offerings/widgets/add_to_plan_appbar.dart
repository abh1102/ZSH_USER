import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/back_arrow.dart';

class AddToPlanAppBar extends StatelessWidget implements PreferredSizeWidget {
  

  const AddToPlanAppBar({super.key, });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const BackArrowWhite(),
      title: Container(
        width: 309.w,
        height: 49.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(
            0.6,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 49.w,
              height: 49.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Image.asset(
                "assets/icons/Rectangle 23.png",
                fit: BoxFit.cover,
              ),
            ),
            width(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Anna",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  "Juliance",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
