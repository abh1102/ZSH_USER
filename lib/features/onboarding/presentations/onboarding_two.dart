import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/onboarding/widgets/simple_button.dart';

class OnBoardingTwoScreen extends StatefulWidget {
  const OnBoardingTwoScreen({super.key});

  @override
  State<OnBoardingTwoScreen> createState() => _OnBoardingTwoScreenState();
}

class _OnBoardingTwoScreenState extends State<OnBoardingTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 25.h,
              horizontal: 28.w,
            ),
            child: Image.asset(
              'assets/images/yogi_final.png',
              width: 375.w,
              height: 375.h,
            ),
          ),
          SizedBox(height: 28.h),
          Expanded(
            child: Container(
              width: deviceWidth,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Color(0xFF25D366), Color(0xFF03C0FF)],
                      stops: [0.0507, 1.1795],
                      tileMode: TileMode.clamp)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/Clip path group.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 104
                        .h, // Adjust the top value to move the text further up
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          heading2Text('Welcome To Zanadu Health',
                              color: Colors.white, textAlign: TextAlign.center),
                          height(11),
                          Center(
                            child: simpleText(
                                'Wellness in your pocket, anytime anywhere!',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                                align: TextAlign.center),
                          ),
                          height(45),
                          // GestureDetector(
                          //   onTap: () {
                          //     Routes.goTo(Screens.signupscreenfirst);
                          //   },
                          //   child: const SimpleButton(
                          //     size: 16,
                          //     weight: FontWeight.w600,
                          //     text: "New Signup",
                          //   ),
                          // ),
                          height(21),
                          GestureDetector(
                            onTap: () {
                              Routes.goTo(Screens.login, arguments: true);
                            },
                            child: const SimpleButton(
                              size: 16,
                              weight: FontWeight.w600,
                              text: "Existing User",
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
