import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';


class ResendButton extends StatefulWidget {
  final void Function()? onTap;
  const ResendButton({super.key, this.onTap});

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "I didn't receive the code! ",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
            ),
            TextSpan(
              text: "Resend",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryBlue,
                  decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = widget.onTap, // Attach the onTap function
            ),
          ],
        ),
      ),
    );
  }
}
