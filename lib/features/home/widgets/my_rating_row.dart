import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zanadu/core/constants.dart';

class MyRatingRow extends StatelessWidget {
  final double? fontSize;
  final FontWeight? weight;
  final double? starSize;

  const MyRatingRow({Key? key, this.fontSize, this.weight, this.starSize});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ignore: unused_local_variable
        final double availableWidth = constraints.maxWidth;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: simpleText('Anna Juliane',
                  fontSize: fontSize ?? 12,
                  fontWeight: weight ?? FontWeight.w700,
                  color: AppColors.textDark,
                  overflow: TextOverflow.ellipsis),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1.9),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryGreen,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: simpleText("4.3",
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryGreen),
                  ),
                  Flexible(
                    child: RatingBar.builder(
                      itemCount: 5,
                      initialRating: 3.5,
                      minRating: 1,
                      maxRating: 5,
                      itemSize: starSize ?? 12.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      onRatingUpdate: (rating) {
                        // Handle when the rating changes
                        // ignore: avoid_print
                        print("Rating: $rating");
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class NewMyRatingRow extends StatelessWidget {
  final String name;
  final String rating;
  final double? fontSize;
  final FontWeight? weight;
  final double? starSize;

  const NewMyRatingRow(
      {super.key,
      this.fontSize,
      this.weight,
      this.starSize,
      required this.name,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ignore: unused_local_variable
        final double availableWidth = constraints.maxWidth;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: simpleText(name,
                  fontSize: fontSize ?? 12,
                  fontWeight: weight ?? FontWeight.w700,
                  color: AppColors.textDark,
                  overflow: TextOverflow.ellipsis),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryGreen,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: simpleText(
                        (double.tryParse(rating) ?? 0).toStringAsFixed(1),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryGreen),
                  ),
                  width(2),
                  Flexible(
                    child: RatingBar.builder(
                      itemCount: 5,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      initialRating: double.tryParse(rating) ?? 0,
                      minRating: 1,
                      maxRating: 5,
                      itemSize: starSize ?? 12.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      onRatingUpdate: (rating) {
                        // Handle when the rating changes
                        // ignore: avoid_print
                        print("Rating: $rating");
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
