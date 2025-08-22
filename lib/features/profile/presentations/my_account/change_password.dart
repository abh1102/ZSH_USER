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
import 'package:zanadu/widgets/validate_password.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isWeakPassword = false;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is PasswordChangedState) {
            // Password changed successfully
            // Handle navigation or show success message
            showGreenSnackBar("${state.message} login again");
            Routes.closeAllAndGoTo(Screens.login);
          } else if (state is LoginErrorState) {
            // Handle error, show an error message, etc.
            // You can access the error message using state.error
            showSnackBar("Error changing password: ${state.error}");
          }
        },
        child: Scaffold(
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
                          "Enter Old Password",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                        height(8),
                        PrefixSuffixIconTextFieldWidget(
                          isShowPassword: true,
                          controller: _oldPasswordController,
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
                          onchanged: (password) {
                            setState(() {
                              isWeakPassword = !checkPasswordStrength(password);
                            });
                          },
                          controller: _newPasswordController,
                          prefixIcon: "assets/icons/Group (1).svg",
                          suffixIcon: "assets/icons/info.svg",
                        ),
                        height(8),
                        if (isWeakPassword)
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
                  String oldPassword = _oldPasswordController.text.trim();
                  String newPassword = _newPasswordController.text.trim();
                  String confirmPassword =
                      _confirmPasswordController.text.trim();

                  if (oldPassword.trim().isEmpty ||
                      newPassword.trim().isEmpty ||
                      confirmPassword.trim().isEmpty) {
                    // Show an error message for empty fields
                    showSnackBar("All fields are required",
                        behavior: SnackBarBehavior.fixed);
                  } else if (newPassword != confirmPassword) {
                    // Show an error message if passwords don't match
                    showSnackBar("New password and confirm password must match",
                        behavior: SnackBarBehavior.fixed);
                  } else {
                    if (isWeakPassword) {
                      showSnackBar(
                        "Weak Password",
                        behavior: SnackBarBehavior.fixed,
                      );
                    } else {
                      context.read<LoginCubit>().changePassword(
                            oldPassword: oldPassword,
                            newPassword: newPassword,
                            confirmPassword: confirmPassword,
                          );
                    }
                    // Dispatch the change password action
                  }
                },
                child: const ColoredButton(
                  myHeight: 60,
                  text: "Change Password",
                  size: 15,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Align the button at the bottom center on smaller screens
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}
