import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zanadu/core/constants.dart';

class MyPinCodeInputField extends StatelessWidget {
  final TextEditingController? controller;
  const MyPinCodeInputField({
    super.key,  this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      cursorWidth: 12, cursorHeight: 1, keyboardType: TextInputType.number,
      blinkDuration: Duration.zero,
      cursorColor: AppColors.primaryBlue,
      textStyle: TextStyle(color: AppColors.primaryBlue),
      appContext: context,
      animationDuration: Duration.zero,
      animationType: AnimationType.none,
      length: 6, // The length of the OTP code (usually 6 digits)
      onChanged: (value) {
        // This function will be called when the user enters or changes the OTP
        print(value);
        // You can store the OTP in a variable or use it as needed.
      },
      onCompleted: (value) {
        // This function will be called when the user successfully enters all digits of the OTP
        print("Completed: $value");
        // You can then proceed to verify the OTP or perform any other action.
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderWidth: 0.1,
        activeBorderWidth: 0.6,
        inactiveBorderWidth: 0.6,
        // Use a rectangular shape
        borderRadius:
            BorderRadius.circular(12.0), // Set the border radius to 12
        fieldHeight: 48.h, // Adjust the field height as needed
        fieldWidth: 48.w, // Adjust the field width as needed
        inactiveFillColor: Colors.white,
        inactiveColor: Color(0xff868788),
        activeColor: Color(0xff868788),
      ),
    );
  }
}
