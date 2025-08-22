import 'package:flutter/material.dart';
import 'package:zanadu/features/sessions/widgets/rating_session.dart';

void givePrevRatingDialog(BuildContext context, String sessionId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PreviousRatingDialog(
        sessionId: sessionId,
      );
    },
  );
}



void giveRatingDialog(BuildContext context, String sessionId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RatingDialog(
        sessionId: sessionId,
      );
    },
  );
}