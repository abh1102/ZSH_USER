import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class AuthBarCodeScreen extends StatefulWidget {
  const AuthBarCodeScreen({super.key});

  @override
  State<AuthBarCodeScreen> createState() => _AuthBarCodeScreenState();
}

class _AuthBarCodeScreenState extends State<AuthBarCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
        firstText: "Authenticator",
        secondText: "App",
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 28.h,
            horizontal: 28.w,
          ),
          child: Column(
            children: [
              height(80),
              Center(
                child: Image.asset(
                  "assets/images/unsplash_AmaUFhjnEBE.png",
                  width: 250.w,
                  height: 246.h,
                ),
              ),
              height(44),
              simpleText(
                "Scan barcode or enter this code manually in your app.",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                align: TextAlign.center,
              ),
              height(28),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 15.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.greyLight,
                  ),
                ),
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: simpleText(
                          "534378 488BGNJ 373738BB",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      simpleText("Copy",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGreen)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
       floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10, left: 28.w, right: 28.w),
          child: GestureDetector(
            onTap: () {
          
            },
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
