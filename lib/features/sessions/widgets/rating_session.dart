import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/sessions/logic/cubit/feedback_cubit/feedback_cubit.dart';
import 'package:zanadu/widgets/whitebg_blacktext_button.dart';

class RatingDialog extends StatefulWidget {
  final String sessionId;
  const RatingDialog({super.key, required this.sessionId});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  bool isVisible = false;
  double rateOfExperience = 0;
  double coachRate = 0;
  double callQualityRate = 0;
  double easyToUseRate = 0;
  double privacySecurityRate = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 350.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF25D366),
              Color(0xFF03C0FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 36.h,
            left: 18.w,
            right: 18.w,
            top: 18.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button (SVG picture)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/Vector.svg", // Replace with your SVG file
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                ),

                height(15),
                Center(
                  child: simpleText("How are we doing? ",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      align: TextAlign.center),
                ),
                height(28),
                _buildRatingBar("Rate your experience", rateOfExperience),
                isVisible
                    ? Column(
                        children: [
                          height(12),
                          _buildRatingBar("Coach Rating", coachRate),
                          height(12),
                          _buildRatingBar("Call Quality", callQualityRate),
                          height(12),
                          _buildRatingBar("Easy to Use", easyToUseRate),
                          height(12),
                          _buildRatingBar(
                              "Privacy and Security", privacySecurityRate),
                        ],
                      )
                    : const SizedBox(),
                height(35),

                height(64),
                WhiteBgBlackTextButton(
                  onpressed: () {
                    if (coachRate == 0 ||
                        callQualityRate == 0 ||
                        easyToUseRate == 0 ||
                        privacySecurityRate == 0 ||
                        rateOfExperience == 0) {
                      // Show an error message or handle it as per your app logic
                      showSnackBar("Please fill all the value");
                    } else {
                      context.read<FeedBackCubit>().createFeedback(
                          sessionId: widget.sessionId,
                          rateOfExperience: rateOfExperience.toString(),
                          coachRate: coachRate.toString(),
                          callQualityRate: callQualityRate.toString(),
                          easyToUseRate: easyToUseRate.toString(),
                          privacySecurityRate: privacySecurityRate.toString());

                      Routes.goBack();
                    }
                  },
                  text: "Submit",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(String text, double rating) {
    return Column(
      children: [
        body1Text(
          text,
          color: Colors.white,
        ),
        height(7),
        RatingBar.builder(
          itemCount: 5,
          itemPadding: EdgeInsets.only(right: 4),
          initialRating: rating,
          minRating: 1,
          maxRating: 5,
          itemSize: 28.0,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.white,
          ),
          onRatingUpdate: (newRating) {
            // Update the corresponding variable based on the text
            switch (text) {
              case "Rate your experience":
                setState(() {
                  isVisible = true;
                  rateOfExperience = newRating;
                });
                break;
              case "Coach Rating":
                setState(() {
                  coachRate = newRating;
                });
                break;
              case "Call Quality":
                setState(() {
                  callQualityRate = newRating;
                });
                break;
              case "Easy to Use":
                setState(() {
                  easyToUseRate = newRating;
                });
                break;
              case "Privacy and Security":
                setState(() {
                  privacySecurityRate = newRating;
                });
                break;
            }
          },
        ),
      ],
    );
  }
}

class PreviousRatingDialog extends StatefulWidget {
  final String sessionId;
  const PreviousRatingDialog({super.key, required this.sessionId});

  @override
  _PreviousRatingDialogState createState() => _PreviousRatingDialogState();
}

class _PreviousRatingDialogState extends State<PreviousRatingDialog> {
  bool isVisible = false;
  double rateOfExperience = 0;
  double coachRate = 0;
  double callQualityRate = 0;
  double easyToUseRate = 0;
  double privacySecurityRate = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 350.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF25D366),
              Color(0xFF03C0FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 36.h,
            left: 18.w,
            right: 18.w,
            top: 18.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button (SVG picture)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/Vector.svg", // Replace with your SVG file
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                ),

                height(15),
                Center(
                  child: simpleText("How are we doing? ",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      align: TextAlign.center),
                ),
                height(16),
                Center(
                  child: body1Text(
                    "Please rate feedback of your last session",
                    align: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                height(28),
                _buildRatingBar("Rate your experience", rateOfExperience),
                isVisible
                    ? Column(
                        children: [
                          height(12),
                          _buildRatingBar("Coach Rating", coachRate),
                          height(12),
                          _buildRatingBar("Call Quality", callQualityRate),
                          height(12),
                          _buildRatingBar("Easy to Use", easyToUseRate),
                          height(12),
                          _buildRatingBar(
                              "Privacy and Security", privacySecurityRate),
                        ],
                      )
                    : const SizedBox(),
                height(35),

                height(64),
                WhiteBgBlackTextButton(
                  onpressed: () {
                    if (coachRate == 0 ||
                        callQualityRate == 0 ||
                        easyToUseRate == 0 ||
                        privacySecurityRate == 0 ||
                        rateOfExperience == 0) {
                      // Show an error message or handle it as per your app logic
                      showSnackBar("Please fill all the value");
                    } else {
                      context.read<FeedBackCubit>().createFeedback(
                          sessionId: widget.sessionId,
                          rateOfExperience: rateOfExperience.toString(),
                          coachRate: coachRate.toString(),
                          callQualityRate: callQualityRate.toString(),
                          easyToUseRate: easyToUseRate.toString(),
                          privacySecurityRate: privacySecurityRate.toString());

                      Routes.goBack();
                    }
                  },
                  text: "Submit",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(String text, double rating) {
    return Column(
      children: [
        body1Text(
          text,
          color: Colors.white,
        ),
        height(7),
        RatingBar.builder(
          itemCount: 5,
          itemPadding: EdgeInsets.only(right: 4),
          initialRating: rating,
          minRating: 1,
          maxRating: 5,
          itemSize: 28.0,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.white,
          ),
          onRatingUpdate: (newRating) {
            // Update the corresponding variable based on the text
            switch (text) {
              case "Rate your experience":
                setState(() {
                  isVisible = true;
                  rateOfExperience = newRating;
                });
                break;
              case "Coach Rating":
                setState(() {
                  coachRate = newRating;
                });
                break;
              case "Call Quality":
                setState(() {
                  callQualityRate = newRating;
                });
                break;
              case "Easy to Use":
                setState(() {
                  easyToUseRate = newRating;
                });
                break;
              case "Privacy and Security":
                setState(() {
                  privacySecurityRate = newRating;
                });
                break;
            }
          },
        ),
      ],
    );
  }
}
