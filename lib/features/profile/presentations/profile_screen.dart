import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/features/profile/widgets/edit_profile_row.dart';
import 'package:zanadu/features/profile/widgets/icon_text_row.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/free_trial_dialog.dart';
import 'package:zanadu/widgets/whitebg_blacktext_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedLanguage = 'English'; // Default selected language

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return LanguageDialog(
          selectedLanguage: selectedLanguage,
          onLanguageSelected: (value) {
            setState(() {
              selectedLanguage = value;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "My", secondText: "Profile"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
            vertical: 28.h,
          ),
          child: Column(
            children: [
              const EditProfileRow(),
              height(28),
              const Divider(
                height: 2,
                color: Color(
                  0xffD9D9D9,
                ),
              ),
              height(28),
              IconWithTextRow(
                onpressed: () {
                  Routes.goTo(Screens.myAccount);
                },
                svg: "assets/icons/user_dark.svg",
                text: "My Account",
              ),
              height(16),
              IconWithTextRow(
                onpressed: () {
                  Routes.goTo(Screens.editProfileNotificationScreen);
                },
                svg: "assets/icons/Group (10).svg",
                text: "Notification",
              ),
              height(16),
              IconWithTextRow(
                onpressed: () {
                  Routes.goTo(Screens.calenderReminder);
                },
                svg: "assets/icons/Group (11).svg",
                text: "Calendar Reminder",
              ),
              height(16),
              IconWithTextRow(
                onpressed: () {
                  Routes.goTo(Screens.myPlan);
                },
                svg: "assets/icons/Group (12).svg",
                text: "Enterprise Plan",
              ),
              height(16),
              GestureDetector(
                onTap: () {
                  Routes.goTo(Screens.myZhScoreCard);
                },
                child: const IconWithTextRow(
                  svg: "assets/icons/health_score_icon.svg",
                  text: "ZH Health Score",
                ),
              ),
              //   height(16),
              // GestureDetector(
              //   onTap: () {
         
              //   },
              //   child: const IconWithTextRowPng(
              //     svg: "assets/icons/icons8-history-96.png",
              //     text: "Session History",
              //   ),
              // ),
              height(16),
              IconWithTextRow(
                onpressed: () {
                  showLanguageDialog(context);
                },
                svg: "assets/icons/Group (13).svg",
                text: "Language",
              ),
              height(16),
              IconWithTextRow(
                onpressed: () {
                  Routes.goTo(Screens.helpSupport);
                },
                svg: "assets/icons/Group (14).svg",
                text: "Help And Support",
              ),
              height(16),
              GestureDetector(
                onTap: () {
                  simpleDialog(
                    context,
                    "Confirm",
                    "Are you sure you want to logout from this device?",
                    "Logout",
                    "Go Back",
                    () async{
                      await BlocProvider.of<LoginCubit>(context).logout();
                    },
                  );
                },
                child: const IconWithTextRow(
                  svg: "assets/icons/Group (15).svg",
                  text: "Logout",
                ),
              ),
              height(16),
            ],
          ),
        ),
      )),
    );
  }
}

class LanguageDialog extends StatefulWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const LanguageDialog({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 29.w,
          vertical: 64.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF25D366), Color(0xFF03C0FF)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: heading1Text(
              "Language",
              color: Colors.white,
            )),
            height(28),
            buildLanguageRow('English'),
            // put this language when different language needed
            // buildLanguageRow('French'),
            // buildLanguageRow('Italian'),
            // buildLanguageRow('Spanish'),
            height(55),
            WhiteBgBlackTextButton(
              text: "Done",
              onpressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageRow(String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        simpleText(
          language,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        Radio(
          value: language,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onLanguageSelected(value as String);
          },
          activeColor: Colors.white,
        ),
      ],
    );
  }
}
