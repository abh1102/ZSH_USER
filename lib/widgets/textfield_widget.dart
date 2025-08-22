import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_popup/info_popup.dart';
import 'package:zanadu/core/constants.dart';

class PrefixIconTextFieldWidget extends StatelessWidget {
  final String? initialValue;
  final String prefixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
   final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const PrefixIconTextFieldWidget({
    Key? key,
    required this.prefixIcon,
    this.initialValue,
    this.validator,
    this.controller,
    this.obscureText, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       onChanged: onChanged,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      ),
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      initialValue: initialValue,
      cursorColor: AppColors.primaryBlue,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.greyLight,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.greyLight,
            width: 1.0,
          ),
        ),
        prefixIcon: Transform.scale(
          scale: 0.5,
          child: SvgPicture.asset(prefixIcon),
        ),
      ),
    );
  }
}

class SuffixIconTextFieldWidget extends StatelessWidget {
  final String suffixIcon;

  const SuffixIconTextFieldWidget({super.key, required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.greyLight, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: TextField(
        cursorColor: AppColors.primaryBlue,
        decoration: InputDecoration(
            border: InputBorder.none, // Remove the default border
            suffixIcon: Transform.scale(
              scale: 0.5, // Adjust the scale factor as needed
              child: SvgPicture.asset(
                suffixIcon,
              ),
            ),

            // Add your prefix icon here

            hintStyle: TextStyle(color: AppColors.greyLight)),
      ),
    );
  }
}

class PrefixSuffixIconTextFieldWidget extends StatelessWidget {
  final String prefixIcon;
  final String suffixIcon;
  final bool? isShowPassword;
  final void Function(String)? onchanged;
  final TextEditingController? controller;

  const PrefixSuffixIconTextFieldWidget(
      {super.key,
      required this.prefixIcon,
      required this.suffixIcon,
      this.controller,
      this.isShowPassword,
      this.onchanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.greyLight, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: TextField(
        onChanged: onchanged,
        obscureText: isShowPassword ?? false,
        controller: controller,
        cursorColor: AppColors.primaryBlue,
        decoration: InputDecoration(
            suffixIcon: InfoPopupWidget(
              arrowTheme: const InfoPopupArrowTheme(
                color: Color(0xFF403E3E),
                arrowDirection: ArrowDirection.down,
              ),
              customContent: Padding(
                padding: EdgeInsets.only(right: 9.w),
                child: Container(
                  width: 256.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF403E3E),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: simpleText(
                    "Must contain at least 1 uppercase, 1 lowercase, and 1 numeric character. Minimum 8 characters.",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              child: Transform.scale(
                scale: 0.5, // Adjust the scale factor as needed
                child: SvgPicture.asset(
                  suffixIcon,
                ),
              ),
            ),
            border: InputBorder.none, // Remove the default border
            prefixIcon: Transform.scale(
              scale: 0.5, // Adjust the scale factor as needed
              child: SvgPicture.asset(
                prefixIcon,
              ),
            ),

            // Add your prefix icon here

            hintStyle: TextStyle(color: AppColors.greyLight)),
      ),
    );
  }
}

class NoIconTextFieldWidget extends StatelessWidget {
  final String? initial;
  final Color? color;
  final bool? enabled;
  final TextEditingController? controller;
  const NoIconTextFieldWidget({
    super.key,
    this.color,
    this.enabled,
    this.initial,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use the provided width or take up all available space
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.greyLight, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: TextFormField(
          style: GoogleFonts.poppins(),
          controller: controller,
          initialValue: initial,
          enabled: enabled,
          cursorColor: AppColors.primaryBlue,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppColors.greyLight),
          ),
        ),
      ),
    );
  }
}

class CountryTextFieldWidget extends StatelessWidget {
  final double? width;
  final TextEditingController countrycodeController;

  const CountryTextFieldWidget({
    super.key,
    this.width,
    required this.countrycodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.greyLight, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: TextFormField(
          controller: countrycodeController,
          textAlign: TextAlign.center,
          cursorColor: AppColors.primaryBlue,
          decoration: InputDecoration(
              hintText: "91",
              border: InputBorder.none, // Remove the default border

              // Add your prefix icon here

              hintStyle: TextStyle(color: AppColors.greyLight)),
        ),
      ),
    );
  }
}

class NoIconTextFieldWidgetNumber extends StatelessWidget {
  final String? initial;
  final Color? color;
  final bool? enabled;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const NoIconTextFieldWidgetNumber({
    super.key,
    this.color,
    this.enabled,
    this.initial,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use the provided width or take up all available space
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.greyLight, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          initialValue: initial,
          enabled: enabled,
          cursorColor: AppColors.primaryBlue,
          decoration: InputDecoration(
            border: InputBorder.none, // Remove the default border

            // Add your prefix icon here

            hintStyle: TextStyle(color: AppColors.greyLight),
          ),
        ),
      ),
    );
  }
}
