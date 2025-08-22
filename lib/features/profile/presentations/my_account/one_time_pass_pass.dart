import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/features/onetimepasscode/widgets/countdown_timer.dart';
import 'package:zanadu/features/onetimepasscode/widgets/pin_code_input_field.dart';
import 'package:zanadu/features/onetimepasscode/widgets/resent_button.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';

class ProfileOneTimePassPassword extends StatefulWidget {
  final String email;
  const ProfileOneTimePassPassword({Key? key, required this.email})
      : super(key: key);

  @override
  State<ProfileOneTimePassPassword> createState() =>
      _ProfileOneTimePassPasswordState();
}

class _ProfileOneTimePassPasswordState
    extends State<ProfileOneTimePassPassword> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ForgetPassOtpVerifyLoadState) {
          // Navigate to ChangePasswordScreen when OTP is verified successfully
          Routes.goToReplacement(Screens.changePassPassword);
          showGreenSnackBar(state.message);
        }
        if (state is LoginErrorState) {
          // Navigate to VerifyOtpScreen when email sent successfully
          showSnackBar(state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBarWithBackButtonWOSilver(
              firstText: "One Time", secondText: "Passcode"),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 28.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(60),
                    Center(
                      child: SizedBox(
                        width: 249.w,
                        child: const Text(
                          textAlign: TextAlign.center,
                          "Please enter the 6 digit verification code sent to your mail",
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
                        },
                      ),
                    ),
                    height(30),
                    MyPinCodeInputField(
                      controller: otpController,
                    ),
                    height(64),
                    ResendButton(
                      onTap: () {
                        Routes.goBack();
                        // Add your logic here for resending the code
                        // ignore: avoid_print

                        // You can call your resend code logic here
                      },
                    ),
                    height(28),
                    GestureDetector(
                      onTap: () {
                        // Call the verify OTP function
                        if (otpController.text.trim().isEmpty) {
                          showSnackBar("Please fill otp");
                        } else {
                          context.read<LoginCubit>().verifyForgotPasswordOTP(
                                email: widget.email,
                                otp: int.tryParse(otpController.text) ?? 0,
                              );
                        }
                      },
                      child: ColoredButton(
                        isLoading: state is LoginLoadingState,
                        text: "Submit",
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
