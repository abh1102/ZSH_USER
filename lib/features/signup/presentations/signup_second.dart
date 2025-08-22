import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
// import 'package:zanadu/core/routes.dart';
// import 'package:zanadu/features/signup/logic/provider/signup_provider.dart';
// import 'package:zanadu/features/signup/widgets/dynamic_pop_menu.dart';
// import 'package:zanadu/features/signup/widgets/select_date.dart';
// import 'package:zanadu/widgets/back_arrow.dart';
// import 'package:zanadu/widgets/all_button.dart';
// import 'package:zanadu/widgets/textfield_widget.dart';
// import 'package:zanadu/widgets/url_launcher.dart';

// class SignUpSecondScreen extends StatefulWidget {
//   const SignUpSecondScreen({super.key});

//   @override
//   State<SignUpSecondScreen> createState() => _SignUpSecondScreenState();
// }

// class _SignUpSecondScreenState extends State<SignUpSecondScreen> {
//   String selectedGender = 'Select Gender';
//   String selectHealthChallenges = '';
//   String selectResidentState = '';
//   Key infoPopupCustomExampleKey = const Key('info_popup_custom_example');
//   String infoPopupCustomExampleText = 'This is a custom widget';

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SignUpProvider>(context);
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Positioned(
//                     child: ClipRect(
//                       child: Align(
//                         alignment: Alignment.topCenter,

//                         heightFactor:
//                             0.54, // Adjust this value to control the height
//                         child: Image.asset(
//                           "assets/images/Clip path group.png",
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20.w,
//                     child: const BackArrow(),
//                   ),
//                   Positioned(
//                     top: 140.h,
//                     left: 168.w,
//                     child: simpleText(
//                       "SignUp",
//                       fontSize: 24,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 28.w,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     simpleText(
//                       "Name",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textLight,
//                     ),
//                     height(8),
//                     const PrefixIconTextFieldWidget(
//                       prefixIcon: "assets/icons/user.svg",
//                     ),
//                     // Add additional text fields here
//                     height(16),
//                     simpleText(
//                       "Email",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textLight,
//                     ),
//                     height(8),
//                     const NoIconTextFieldWidget(
//                       initial: "Alena@gmail .com",
//                     ),
//                     height(16),
//                     simpleText(
//                       "Enter Password",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textLight,
//                     ),
//                     height(8),
//                     const PrefixSuffixIconTextFieldWidget(
//                       prefixIcon: "assets/icons/Group (1).svg",
//                       suffixIcon: "assets/icons/info.svg",
//                     ),
//                     height(16),
//                     simpleText(
//                       "Phone No.",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textLight,
//                     ),
//                     height(8),
//                     Row(
//                       children: [
//                         CountryTextFieldWidget(
//                           width: 70.w,
//                         ),
//                         width(10),
//                         const Expanded(child: NoIconTextFieldWidget())
//                       ],
//                     ),
//                     height(16),

//                     Row(
//                       children: [
//                         Expanded(
//                             child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             simpleText(
//                               "Date of Birth",
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.textLight,
//                             ),
//                             height(8),
//                             SelectStartDate(provider: provider),
//                           ],
//                         )),
//                         width(25),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               simpleText(
//                                 "Select Gender",
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.textLight,
//                               ),
//                               height(8),
//                               DynamicPopupMenu(
//                                 selectedValue: selectedGender,
//                                 items: const ['Men', 'Women'],
//                                 onSelected: (String value) {
//                                   setState(() {
//                                     selectedGender = value;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),

//                     height(16),
//                     simpleText(
//                       "Top Three Health Challenges",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textLight,
//                     ),
//                     height(8),
//                     DynamicPopupMenu(
//                       selectedValue: selectHealthChallenges,
//                       items: const [
//                         'Non Communicable Diseases',
//                         'Mental Health',
//                         'Maternal and Child Health',
//                         'Age Related Diseases'
//                       ],
//                       onSelected: (String value) {
//                         setState(() {
//                           selectHealthChallenges = value;
//                         });
//                       },
//                     ),

//                     height(16),
//                     simpleText(
//                       "Resident State in the U.S",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textLight,
//                     ),

//                     height(8),
//                     DynamicPopupMenu(
//                       selectedValue: selectResidentState,
//                       items: const [
//                         'California',
//                         'Texas',
//                         'Florida',
//                         'New York'
//                       ],
//                       onSelected: (String value) {
//                         setState(() {
//                           selectResidentState = value;
//                         });
//                       },
//                     ),
//                     height(28),
//                     simpleText(
//                       "By clicking on submit, I am agreeing to the Terms of Service and Privacy Policy",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     height(64.h),
//                     GestureDetector(
//                       onTap: () {
//                         Routes.closeAllAndGoTo(Screens.homeBottomBar);
//                       },
//                       child: const ColoredButton(
//                         text: "Submit",
//                         size: 16,
//                         weight: FontWeight.w600,
//                       ),
//                     ),
//                     // height(16),
//                     // const DividerWithText(
//                     //   text: "Or Continue With",
//                     // ),
//                     // height(26),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     const LogoWidget(
//                     //       text: "assets/icons/Facebook logo 2019.svg",
//                     //     ),
//                     //     width(24),
//                     //     const LogoWidget(
//                     //       text: "assets/icons/Google.svg",
//                     //     ),
//                     //     width(24),
//                     //     const LogoWidget(
//                     //       text: "assets/icons/Linkedin.svg",
//                     //     ),
//                     //     width(24)
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ),
//               height(40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Flexible(
//                     child: FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child: GestureDetector(
//                             onTap: () {
//                               myLaunchUrl("https://www.youtube.com/");
//                             },
//                             child: simpleText(
//                               "Terms Of Service",
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.primaryBlue,
//                             ))),
//                   ),
//                   Flexible(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: simpleText(
//                         " and ",
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.primaryBlue,
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                       child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: GestureDetector(
//                       onTap: () {
//                         myLaunchUrl("https://www.youtube.com/");
//                       },
//                       child: simpleText(
//                         "Privacy Policy.",
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.primaryBlue,
//                       ),
//                     ),
//                   ))
//                 ],
//               ),
//               height(40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignUpSecondScreen extends StatefulWidget {
  const SignUpSecondScreen({super.key});

  @override
  State<SignUpSecondScreen> createState() => _SignUpSecondScreenState();
}

class _SignUpSecondScreenState extends State<SignUpSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "SignUp", secondText: ""),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: simpleText(
              "Please Ask Your Enterperise To Send You The Signup Link",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
              align: TextAlign.center),
        ),
      ),
    );
  }
}
