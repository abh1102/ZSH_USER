import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/back_arrow.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/textfield_widget.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
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
                            child: simpleText(
                              "Change Email",
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          height(8),
                          const Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Choose a new Email for your account",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          height(64),
                          simpleText(
                            "Enter Email",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                          height(8),
                          const PrefixIconTextFieldWidget(
                            prefixIcon: "assets/icons/Group (3).svg",
                          ),
                          height(64),
                          GestureDetector(
                            onTap: () {},
                            child: const ColoredButton(
                              text: "Send",
                              size: 16,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // height(198),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Align(
                alignment: Alignment.bottomLeft,
                widthFactor: 0.9,
                heightFactor: 0.8, // Adjust this value to control the height
                child: Image.asset(
                  "assets/images/Clip path group (1).png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
