import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/features/login/logic/provider/login_provider.dart';
import 'package:zanadu/widgets/back_arrow.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/textfield_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:zanadu/widgets/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  final bool isBackButton;
  const LoginScreen({super.key, required this.isBackButton});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginHealthLoadedState) {
          Routes.goTo(
            Screens.questionInformScreen,
          );
        }
        if (state is LoginLoadedState) {
          Routes.closeAllAndGoTo(Screens.homeBottomBar);
        }
        if (state is LoginErrorState) {
          showSnackBar(state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: provider.formKey,
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
                      if (widget.isBackButton)
                        Positioned(
                          left: 20.w,
                          child: const BackArrow(),
                        ),
                      Positioned(
                        top: 170.h,
                        left: 168.w,
                        child: simpleText(
                          "Login",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        height(35),
                        simpleText(
                          "Email",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                        height(8),
                        PrefixIconTextFieldWidget(
                          controller: provider.emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email address is required!";
                            }

                            if (!EmailValidator.validate(value.trim())) {
                              return "Invalid email address";
                            }

                            return null;
                          },
                          prefixIcon: "assets/icons/user.svg",
                        ),
                        // Add additional text fields here
                        height(16),
                        simpleText(
                          "Password",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                        height(8),
                        PrefixIconTextFieldWidget(
                          controller: provider.passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Password is required!";
                            }
                            return null;
                          },
                          prefixIcon: "assets/icons/Group (1).svg",
                        ),
                        // Add additional text fields here
                        height(13),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    side:
                                        BorderSide(color: AppColors.textLight),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5.0), // Adjust the radius as needed
                                      side: const BorderSide(
                                          color: Colors
                                              .black), // Optional: Add a border
                                    ),
                                    value: provider.rememberMe,
                                    onChanged: (value) {
                                      provider.toggleRememberMe(value ?? false);
                                    }),
                                simpleText(
                                  'Remember Me',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Routes.goTo(Screens.changePassEmail);
                              },
                              child: simpleText(
                                'Forget Password?',
                                color: const Color(0xFF03C0FF),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),

                        height(64.h),
                        GestureDetector(
                          onTap: provider.logIn,
                          child: ColoredButton(
                            isLoading: provider.isLoading,
                            text: "Log In",
                            size: 16,
                            weight: FontWeight.w600,
                          ),
                        ),
                        height(16),
                      ],
                    ),
                  ),
                  height(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: GestureDetector(
                            onTap: () {
                              myLaunchUrl(
                                  "https://app.zanaduhealth.com/terms-of-service");
                            },
                            child: simpleText(
                              "Terms Of Service",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: simpleText(
                            " and ",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                      Flexible(
                          child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: GestureDetector(
                          onTap: () {
                            myLaunchUrl(
                                "https://app.zanaduhealth.com/privacy-policy");
                          },
                          child: simpleText(
                            "Privacy Policy.",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
