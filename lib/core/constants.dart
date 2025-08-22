import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/data/model/user_model.dart';
import 'package:zanadu/features/offerings/data/models/offering_model.dart';

// all the links and constants will be here
String defaultAvatar =
    "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png";

// to locally store user model
UserModel? myUser;

String? userEmail;


double screenWidth = MediaQuery.of(Routes.currentContext).size.width;
double screenHeight = MediaQuery.of(Routes.currentContext).size.height;

int? myuid;

String? coachId;
String? coachOfferingId;

// acess token we need everywhere
String accessToken = "";

// option and headers

class ApiUtils {
  static Options getAuthOptions() {
    return Options(
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }
}

List<OfferingsModel>? myOfferings;

String serverUrl = "https://api.zanaduhealth.com";

String oneServerUrl = "https://api.zanaduhealth.com";

class AppColors {
  static Color primaryGreen = const Color(0xff25D366);
  static Color primaryBlue = const Color(0xff03C0FF);

  static Color megenta = const Color(0xffFF56FF);

  static Color lightBlue = const Color(0xffE7F9FA);
  static Color textDark = const Color(0xff403E3E);
  static Color textLight = const Color(0xFF868788);
  static Color greyDark = const Color(0XFFB7BBBF);
  static Color greyLight = const Color(0XFFD6D9DB);
  static Color white = const Color(0xFFFFFFFF);
  static Gradient secondaryGradient = const LinearGradient(
    colors: [Color(0xff25D366), Color(0xff03C0FF)],
    stops: [0, 1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Color secondaryRedColor = const Color(0xFFE12222);
}

// size of device

double deviceWidth = 430.w;

double deviceHeight = 932.h;

// Insets (Paddings, Border Radii etc.)
class Insets {
  static EdgeInsets pagePadding = const EdgeInsets.symmetric(horizontal: 20);
  static EdgeInsets dialogPadding = const EdgeInsets.symmetric(horizontal: 32);
  static EdgeInsets cardPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 30);

  static Radius radiusSmall = const Radius.circular(10);
  static Radius radiusMedium = const Radius.circular(20);
  static Radius radiusLarge = const Radius.circular(40);

  static List<BoxShadow> defaultShadow = [
    BoxShadow(
        blurRadius: 8, spreadRadius: 2, color: Colors.black.withOpacity(0.05)),
  ];

  // gradient color

  static LinearGradient createGradient(
    Color beginColor,
    Color endColor,
    Alignment beginAlignment,
    Alignment endAlignment,
    List<double> stops,
    double rotationDegrees,
  ) {
    return LinearGradient(
      colors: [beginColor, endColor],
      begin: beginAlignment,
      end: endAlignment,
      stops: stops,
      transform: GradientRotation(rotationDegrees * 3.1415926535 / 180),
    );
  }

  // gradient color

  static LinearGradient fixedGradient({double? opacity}) {
    return LinearGradient(
      colors: [
        const Color(0xFF25D366).withOpacity(opacity ?? 1),
        const Color(0xFF03C0FF).withOpacity(opacity ?? 1),
      ],
      begin: Alignment(-0.2567, 0.9705),
      end: Alignment(0.9708, -0.2623),
      stops: [0.0507, 1.1795],
      transform: GradientRotation(140 * 3.1415926535 / 180),
    );
  }

  static ScrollPhysics bouncePhysics =
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}

// themes section which are going to used in this project

// change the primary color as you need in your project

class Themes {
  static ThemeData defaultTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(
            color: AppColors.textDark,
          ),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          )),
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryGreen,
      ));
}

// default textstyles which can be changed in future according to need

class TextStyles {
  static TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  static TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static TextStyle body1 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static TextStyle body2 = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
}

// default textstyle which will be going to used mostly in appp

Text heading1Text(
  String text, {
  Color? color,
  TextDecoration? decoration,
  TextAlign? textAlign,
}) {
  return Text(text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        decoration: decoration,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: color,
      ));
}

Text heading2Text(
  String text, {
  Color? color,
  TextDecoration? decoration,
  TextAlign? textAlign,
}) {
  return Text(text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        decoration: decoration,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: color,
      ));
}

Text body1Text(
  String text, {
  Color? color,
  TextAlign? align,
  FontWeight? weight,
}) {
  return Text(text,
      textAlign: align,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: weight ?? FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: color,
      ));
}

Text body2Text(
  String text, {
  Color? color,
}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color,
    ),
  );
}

Text simpleText(
  String text, {
  TextAlign? align,
  Color? color,
  TextDecoration? decoration,
  FontWeight? fontWeight,
  double? fontSize,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    overflow: overflow,
    textAlign: align,
    style: GoogleFonts.poppins(
      decoration: decoration,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: FontStyle.normal,
      color: color,
    ),
  );
}

// sizedbox for height and width

SizedBox width(double size) {
  return SizedBox(
    width: size.w,
  );
}

SizedBox height(double size) {
  return SizedBox(
    height: size.h,
  );
}
