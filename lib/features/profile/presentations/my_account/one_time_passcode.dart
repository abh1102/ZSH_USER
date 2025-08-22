import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/features/onetimepasscode/widgets/countdown_timer.dart';
import 'package:zanadu/features/onetimepasscode/widgets/pin_code_input_field.dart';
import 'package:zanadu/features/onetimepasscode/widgets/resent_button.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class ProfileOneTimePassword extends StatefulWidget {
  const ProfileOneTimePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileOneTimePassword> createState() => _ProfileOneTimePasswordState();
}

class _ProfileOneTimePasswordState extends State<ProfileOneTimePassword> {
  final TextEditingController otpController = TextEditingController();

  late LoginCubit loginCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.getChangePhoneOtp();
  }

//ChangePhoneOtpSentLoadState
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ChangePhoneOtpSentLoadState) {
          // Navigate to ChangePasswordScreen when OTP is verified successfully

          showGreenSnackBar(state.message);
        }
        if (state is ChangePhoneOtpVerifyLoadState) {
          // Navigate to ChangePasswordScreen when OTP is verified successfully

          showGreenSnackBar(state.message);
          Routes.goToReplacement(Screens.changePhone);
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
                          print('Timer Completed');
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
                        print("Resend button tapped");
                        // You can call your resend code logic here
                      },
                    ),
                    height(28),
                    GestureDetector(
                      onTap: () {
                        // Call the verify OTP function
                        if (otpController.text.trim().isEmpty) {
                          showSnackBar("Please fill Otp");
                        } else {
                          context.read<LoginCubit>().verifyChangePhoneOtp(
                              otp: int.tryParse(otpController.text) ?? 0);
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
