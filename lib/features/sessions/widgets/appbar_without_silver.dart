import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/back_arrow.dart';

class AppBarWithBackButtonWOSilver extends StatelessWidget
    implements PreferredSizeWidget {
  final String firstText;
  final String secondText;
  const AppBarWithBackButtonWOSilver({
    super.key,
    required this.firstText,
    required this.secondText,
  });
  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackArrow(),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(top: 10.h, bottom: 6.h),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              firstText,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(width: 4), // Use SizedBox instead of width
            Text(
              secondText,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add the toggle_switch package

class AppBarWithBackButtonWithAction extends StatefulWidget
    implements PreferredSizeWidget {
  final String firstText;

  const AppBarWithBackButtonWithAction({
    Key? key,
    required this.firstText,
  });

  @override
  _AppBarWithBackButtonWithActionState createState() =>
      _AppBarWithBackButtonWithActionState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _AppBarWithBackButtonWithActionState
    extends State<AppBarWithBackButtonWithAction> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackArrow(),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(top: 10, bottom: 6),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.firstText,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
          ],
        ),
      ),
     
    );
  }
}

class HealthCoachAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String firstText;
  final String secondText;
  final bool canGoBack;
  const HealthCoachAppBar({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.canGoBack,
  });
  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: canGoBack ? const BackArrow() : null,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(top: 10.h, bottom: 6.h),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              firstText,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(width: 4), // Use SizedBox instead of width
            Text(
              secondText,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWithBackButtonWOSilverCP extends StatelessWidget
    implements PreferredSizeWidget {
  final String firstText;
  final String secondText;

  const AppBarWithBackButtonWOSilverCP({
    Key? key,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackArrow(),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(top: 10.h, bottom: 6.h, left: 72.w),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                firstText,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                secondText,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWithoutBackButtonWithAction extends StatefulWidget
    implements PreferredSizeWidget {
  final String firstText;
  final String secondText;

  const AppBarWithoutBackButtonWithAction({
    Key? key,
    required this.firstText,
    required this.secondText,
  });

  @override
  _AppBarWithoutBackButtonWithActionState createState() =>
      _AppBarWithoutBackButtonWithActionState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _AppBarWithoutBackButtonWithActionState
    extends State<AppBarWithoutBackButtonWithAction> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.firstText,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
            ),
          ),
          width(4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.secondText,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
