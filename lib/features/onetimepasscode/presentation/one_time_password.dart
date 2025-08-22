import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/onetimepasscode/widgets/countdown_timer.dart';
import 'package:zanadu/features/onetimepasscode/widgets/pin_code_input_field.dart';
import 'package:zanadu/features/onetimepasscode/widgets/resent_button.dart';
import 'package:zanadu/widgets/back_arrow.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/all_dialog.dart';

class OneTimePassword extends StatefulWidget {
  const OneTimePassword({super.key});

  @override
  State<OneTimePassword> createState() => _OneTimePasswordState();
}

class _OneTimePasswordState extends State<OneTimePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor:
                                  0.54, // Adjust this value to control the height
                              child: Image.asset(
                                "assets/images/Clip path group.png",
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.w,
                          child: const BackArrow(),
                        ),
                        Positioned(
                          top: 170.h,
                          left: 96.w,
                          child: Column(
                            children: [
                              simpleText(
                                "One Time Passcode",
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                              height(16),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          GestureDetector(
                            onTap: () {
                              welcomeDialog(context);
                            },
                            child: const GreySubmitButton(
                              colored: false,
                              text: "Submit",
                              size: 16,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                "assets/images/Clip path group (1).png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
