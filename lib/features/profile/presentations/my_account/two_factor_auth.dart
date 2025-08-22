import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Add", secondText: "Authentication"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 28.h,
            horizontal: 28.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              simpleText(
                "Two-Factor Authentication",
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              height(28),
              Row(
                children: [
                  Flexible(
                    child: simpleText(
                      "Help protect your account from unauthorized access by requiring a second authentication method in addition to your password.",
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      align: TextAlign.start,
                    ),
                  ),
                  width(40),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      activeColor: const Color(0xFF03C0FF),
                      trackColor: AppColors.greyDark,
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              height(28),
              simpleText(
                "Select authentication method.",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              height(28),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Routes.goTo(Screens.authBarCodeScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 18.h,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            gradient: Insets.fixedGradient(
                              opacity: 0.2,
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/auth_svg.svg"),
                            height(10),
                            FittedBox(fit: BoxFit.scaleDown,
                              child: simpleText("Authenticator App",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  align: TextAlign.center),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  width(14),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                           Routes.goTo(Screens.authPhoneScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 18.h, horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/smartphone.png",width: 37.9.w,),
                            height(10),
                            FittedBox(fit: BoxFit.scaleDown,
                              child: simpleText("One Time Passcode",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  align: TextAlign.center),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
