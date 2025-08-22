import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/signup/presentations/signup_second.dart';
import 'package:zanadu/widgets/back_arrow_appbar.dart';

class SignUpScreenFirst extends StatefulWidget {
  const SignUpScreenFirst({super.key});

  @override
  State<SignUpScreenFirst> createState() => _SignUpScreenFirstState();
}

class _SignUpScreenFirstState extends State<SignUpScreenFirst> {
  bool gifCompleted = false;
  bool _isMounted = false;
  bool skipPressed = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;

    // Simulate the GIF completion after some time (you can replace this with your actual GIF completion logic).
    Future.delayed(Duration(seconds: 16), () {
      if (_isMounted && !skipPressed) {
        setState(() {
          gifCompleted = true;
        });
        // Navigate to the new screen with a fade-in effect.
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return SignUpSecondScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var opacityAnimation = animation.drive(tween);
              return FadeTransition(
                opacity: opacityAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backArrowAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          height(90),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/Group (1).png'),
                Image.asset('assets/gif/meditating_girl.gif'),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () {

                  setState(() {
                    skipPressed=true;
                  });
                  // Navigate to the next screen when the "Skip" button is tapped.
                  Routes.goTo(Screens.signupscreensecond);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
