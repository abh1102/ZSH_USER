import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/onetimepasscode/widgets/countdown_timer.dart';
import 'package:zanadu/features/onetimepasscode/widgets/pin_code_input_field.dart';
import 'package:zanadu/features/onetimepasscode/widgets/resent_button.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class AuthPhoneScreen extends StatefulWidget {
  const AuthPhoneScreen({super.key});

  @override
  State<AuthPhoneScreen> createState() => _AuthPhoneScreenState();
}

class _AuthPhoneScreenState extends State<AuthPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
        firstText: "OTP on",
        secondText: "Phone",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(60),
                Center(
                  child: SizedBox(
                    width: 249.w,
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Please enter the 6 digit verification code sent to your mobile number",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                height(64),
                Center(
                  child: CountdownTimerWidget(
                    onTimerEnd: () {
                      // Function to run when the timer is completed
                      print('Timer Completed');
                    },
                  ),
                ),
                height(30),
                const MyPinCodeInputField(),
                height(64),
                ResendButton(onTap: () {
                  // Add your logic here for resending the code
                  // ignore: avoid_print
                  print("Resend button tapped");
                  // You can call your resend code logic here
                }),
                height(28),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10, left: 28.w, right: 28.w),
          child: GestureDetector(
            onTap: () {},
            child: const ColoredButton(
              myHeight: 50,
              text: "Validate & Enable",
              size: 16,
              weight: FontWeight.w600,
            ),
          ),
        ),
      ),
      // Align the button at the bottom center on smaller screens
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
