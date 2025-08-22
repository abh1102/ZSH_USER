import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/textfield_widget.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key});

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  TextEditingController countrycodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is ChangedPhoneChangedState) {
        // Navigate to ChangePasswordScreen when OTP is verified successfully

        showGreenSnackBar(state.message);
        Routes.closeAllAndGoTo(Screens.homeBottomBar);
        Routes.goTo(Screens.profile);
        Routes.goTo(Screens.myAccount);
      }

      if (state is LoginErrorState) {
        // Navigate to VerifyOtpScreen when email sent successfully
        showSnackBar(state.error);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: const AppBarWithBackButtonWOSilverCP(
            firstText: "Change", secondText: "Phone Number"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                simpleText(
                  "Enter Your New Phone Number ",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textLight,
                ),
                height(8),
                Row(
                  children: [
                    CountryTextFieldWidget(
                      countrycodeController: countrycodeController,
                      width: 70.w,
                    ),
                    width(10),
                    Expanded(
                        child: NoIconTextFieldWidgetNumber(
                      controller: phoneController,
                    ))
                  ],
                ),
                height(5),
                simpleText(
                  "Current Phone Number ${myUser?.userInfo?.profile?.phone}",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textLight,
                ),
                height(64),
                const Spacer(),
              ],
            ),
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10, left: 28.w, right: 28.w),
            child: GestureDetector(
               onTap: () {
                if (countrycodeController.text.trim().isNotEmpty &&
                    phoneController.text.trim().isNotEmpty) {
                  if (validatePhoneNumber()) {
                    context.read<LoginCubit>().changePhoneNumber(
                        phone:
                            "+${countrycodeController.text}-${phoneController.text}");
                  } else {
                    showSnackBar("You can only put number here",
                        behavior: SnackBarBehavior.fixed);
                  }
                } else {
                  showSnackBar("Please fill all the fields",
                      behavior: SnackBarBehavior.fixed);
                }
              },
              child: ColoredButton(
                isLoading: state is LoginLoadingState,
                myHeight: 50,
                text: "Send",
                size: 16,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ),
        // Align the button at the bottom center on smaller screens
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

   bool validatePhoneNumber() {
    // Validate if the input is not empty and only contains numbers
    return phoneController.text.trim().isNotEmpty &&
        RegExp(r'^[0-9]+$').hasMatch(phoneController.text.trim());
  }
}
