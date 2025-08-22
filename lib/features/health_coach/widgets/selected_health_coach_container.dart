import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/home/widgets/my_liked_widget.dart';
import 'package:zanadu/features/home/widgets/my_rating_row.dart';
import 'package:zanadu/widgets/image_widget.dart';

class SelectedHealthCoachContainer extends StatefulWidget {
  final VoidCallback? onpressed;
  final String name;
  final String? imgUrl;
  final String rating;
  final String experienceYear;
  final String likes;
  const SelectedHealthCoachContainer({
    super.key,
    this.onpressed,
    required this.name,
    required this.rating,
    required this.experienceYear,
    required this.likes,
    this.imgUrl,
  });

  @override
  State<SelectedHealthCoachContainer> createState() =>
      _SelectedHealthCoachContainerState();
}

class _SelectedHealthCoachContainerState
    extends State<SelectedHealthCoachContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF25D366).withOpacity(0.2), // #25D366
            const Color(0xFF03C0FF).withOpacity(0.2), // #03C0FF
          ],
          stops: const [0.0507, 1.1795],
          transform: const GradientRotation(2.44), // 140 degrees in radians
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(aspectRatio: 16/9,
            child: CustomImageWidget(
              url: widget.imgUrl ?? defaultAvatar,
              myradius: 12,
              mywidth: double.infinity,
              myheight: 140,
            ),
          ),
          height(10),
          NewMyRatingRow(name: widget.name, rating: widget.rating),
          height(5),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    body2Text("${widget.experienceYear} Years of Experience"),
                    height(3),
                    MyLikedByWidget(likeCount: widget.likes),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.onpressed,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 11.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.greyDark,
                    ),
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: simpleText("Change Coach",
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyDark),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
