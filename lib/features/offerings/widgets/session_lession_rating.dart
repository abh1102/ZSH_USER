import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/offerings/widgets/two_column_widget.dart';



class SessionLessionRatingRow extends StatelessWidget {
  const SessionLessionRatingRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TwoColumnWidget(
          first: "Session",
          second: "30",
        ),
        const TwoColumnWidget(
          first: "Lesson",
          second: "20",
        ),
        Column(
          children: [
            body1Text("Rating"),
            RatingBar.builder(
              itemCount: 3,
              initialRating: 3.5, // Initial rating value
              minRating: 1, // Minimum rating value
              maxRating: 5, // Maximum rating value
              itemSize: 15.0, // Size of each star
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.black, // Star color when filled
              ),
              onRatingUpdate: (rating) {
                // Handle when the rating changes
                // ignore: avoid_print
                print("Rating: $rating");
              },
            ),
          ],
        ),
      ],
    );
  }
}