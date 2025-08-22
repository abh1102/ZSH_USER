import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/widgets/back_arrow.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/textfield_widget.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart'; // Import the LoginCubit

class ChangePassEmailScreen extends StatefulWidget {
  const ChangePassEmailScreen({Key? key}) : super(key: key);

  @override
  _ChangePassEmailScreenState createState() => _ChangePassEmailScreenState();
}

class _ChangePassEmailScreenState extends State<ChangePassEmailScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ForgetPassEmailSentLoadState) {
          // Navigate to VerifyOtpScreen when email sent successfully
          Routes.goToReplacement(Screens.profileOneTimePassPasscode,
              arguments: emailController.text);
          showGreenSnackBar(state.message);
        }
      },
      builder: (context, state) {
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
                            const Positioned(
                              left: 20,
                              child: BackArrow(),
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
                              height(8),
                              Center(
                                child: simpleText(
                                  "Enter Your Email To Get Verification Code",
                                  align: TextAlign.center,
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
                              PrefixIconTextFieldWidget(
                                prefixIcon: "assets/icons/Group (3).svg",
                                controller: emailController,
                              ),
                              height(64),
                              GestureDetector(
                                onTap: () {
                                  // Call the forget password function
                                  if (emailController.text.trim().isEmpty) {
                                    showSnackBar("Please fill email");
                                  } else {
                                    context.read<LoginCubit>().forgotPassword(
                                          email: emailController.text,
                                        );
                                  }
                                },
                                child: ColoredButton(
                                  isLoading: state is LoginLoadingState,
                                  text: "Send",
                                  size: 16,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    widthFactor: 0.9,
                    heightFactor:
                        0.8, // Adjust this value to control the height
                    child: Image.asset(
                      "assets/images/Clip path group (1).png",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
