import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/features/login/logic/services/preference_services.dart';
import 'package:zanadu/features/onboarding/presentations/splash_screen_one.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(_controller);

    _controller.forward();

    // Check if login credentials are available
    _checkLoginCredentials();
  }

  Future<void> _checkLoginCredentials() async {
    final userDetails = await Preferences.fetchUserDetails();

    // Check if email and password are available
    if (userDetails['email'] != null && userDetails['password'] != null) {
      // If credentials are available, attempt to log in
      _login(userDetails['email'], userDetails['password']);
    } else {
      print("hrererererererererer");
      // If no credentials are available, navigate to LoginScreen
      Timer(Duration(milliseconds: 800), () {
        _navigateToNextScreen();
      });
    }
  }

  void _login(String email, String password) async {
    try {
      // Attempt to log in with the saved credentials
      print("working one");
      await BlocProvider.of<LoginCubit>(context)
          .login(email: email, password: password, rememberMe: true);

      print("working");
    } catch (e) {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: SplashScreenOne(),
          );
        },
        transitionDuration: Duration(milliseconds: 800), // Adjust as needed
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginHealthLoadedState) {
            Routes.goToReplacement(
              Screens.questionInformScreen,
            );
          }
          if (state is LoginLoadedState) {
            Routes.closeAllAndGoTo(Screens.homeBottomBar);
          }
          if (state is LoginErrorState) {
            Routes.goToReplacement(Screens.login, arguments: false);
          }
        },
        child: Scaffold(
          extendBody: true,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF25D366), Color(0xFF03C0FF)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                stops: [0.0507, 1.1795],
                transform: GradientRotation(140 * 3.1415926535 / 180),
              ),
            ),
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset('assets/images/Group 1171275105.svg'),
              ),
            ),
          ),
        ));
  }
}
