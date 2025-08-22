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

class ChangePassPasswordScreen extends StatefulWidget {
  const ChangePassPasswordScreen({super.key});

  @override
  State<ChangePassPasswordScreen> createState() =>
      _ChangePassPasswordScreenState();
}

class _ChangePassPasswordScreenState extends State<ChangePassPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is ForgetPasswordChangedState) {
        // Navigate to VerifyOtpScreen when email sent successfully

        showGreenSnackBar(state.message);
        Routes.goToReplacement(Screens.login, arguments: false);
      }
      if (state is LoginErrorState) {
        // Navigate to VerifyOtpScreen when email sent successfully
        showSnackBar(state.error);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: const AppBarWithBackButtonWOSilver(
            firstText: "Change", secondText: "Password"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 28.h,
                    horizontal: 28.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        textAlign: TextAlign.center,
                        "Choose a new password for your account",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
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
                      PrefixSuffixIconTextFieldWidget(
                        controller: _emailController,
                        prefixIcon: "assets/icons/Group (1).svg",
                        suffixIcon: "assets/icons/info.svg",
                      ),
                      height(16),
                      simpleText(
                        "Enter New Password",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                      height(8),
                      PrefixSuffixIconTextFieldWidget(
                        isShowPassword: true,
                        controller: _newPasswordController,
                        prefixIcon: "assets/icons/Group (1).svg",
                        suffixIcon: "assets/icons/info.svg",
                      ),
                      height(8),
                      simpleText(
                          "Must contain at least 1 uppercase, 1 lowercase, and 1 numeric character. Minimum 8 characters.",
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryRedColor),
                      height(16),
                      simpleText(
                        "Confirm New Password",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                      height(8),
                      PrefixIconTextFieldWidget(
                        obscureText: true,
                        controller: _confirmPasswordController,
                        prefixIcon: "assets/icons/Group (1).svg",
                      ),
                    ],
                  ),
                ),
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
                String email = _emailController.text.trim();
                String newPassword = _newPasswordController.text.trim();
                String confirmPassword = _confirmPasswordController.text.trim();

                if (email.trim().isEmpty ||
                    newPassword.trim().isEmpty ||
                    confirmPassword.trim().isEmpty) {
                  // Show an error message for empty fields
                  showSnackBar("All fields are required");
                } else if (newPassword != confirmPassword) {
                  // Show an error message if passwords don't match
                  showSnackBar("New password and confirm password must match");
                } else {
                  // Dispatch the change password action
                  context.read<LoginCubit>().changeForgottenPassword(
                        email: email,
                        newPassword: newPassword,
                        confirmPassword: confirmPassword,
                      );
                }
              },
              child: ColoredButton(
                isLoading: state is LoginLoadingState,
                myHeight: 60,
                text: "Change Password",
                size: 15,
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
}
