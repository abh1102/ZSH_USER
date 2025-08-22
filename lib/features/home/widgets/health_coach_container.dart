import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/home/widgets/my_liked_widget.dart';
import 'package:zanadu/features/home/widgets/my_rating_row.dart';
import 'package:zanadu/widgets/image_widget.dart';

class HealthCoachContainer extends StatefulWidget {
  final String name;
  final String rating;
  final String likeCount;
  final String session;
  final String? imgUrl;
  const HealthCoachContainer({
    super.key,
    required this.name,
    required this.rating,
    required this.likeCount,
    required this.session,
    this.imgUrl,
  });

  @override
  State<HealthCoachContainer> createState() => _HealthCoachContainerState();
}

class _HealthCoachContainerState extends State<HealthCoachContainer> {
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
      width: 260.w,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CustomImageWidget(
              url: widget.imgUrl ?? defaultAvatar,
              myradius: 8,
              mywidth: double.infinity,
              myheight: 170.h,
            ),
          ),
          height(10),
          NewMyRatingRow(name: widget.name, rating: widget.rating),
          height(5),
          body2Text("Live Session ${widget.session} | Health Coach"),
          height(3),
          MyLikedByWidget(
            likeCount: widget.likeCount,
          )
        ],
      ),
    );
  }
}

class BigHealthCoachContainer extends StatefulWidget {
  final String name;
  final String rating;
  final String likeCount;
  final String? imgUrl;
  final int liveSession;
  final bool isSpeciality;

  const BigHealthCoachContainer({
    super.key,
    required this.name,
    required this.rating,
    required this.likeCount,
    required this.liveSession,
    this.imgUrl,
    required this.isSpeciality,
  });

  @override
  State<BigHealthCoachContainer> createState() =>
      _BigHealthCoachContainerState();
}

class _BigHealthCoachContainerState extends State<BigHealthCoachContainer> {
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
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.primaryBlue,
                )),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CustomImageWidget(
                url: widget.imgUrl ?? defaultAvatar,
                myradius: 15,
                mywidth: double.infinity,
                myheight: 190.h,
              ),
            ),
          ),
          height(10),
          NewMyRatingRow(
            name: widget.name,
            rating: widget.rating,
          ),
          height(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.isSpeciality
                  ? Flexible(child: body2Text("${widget.likeCount}"))
                  : Expanded(
                      child: MyLikedByWidget(
                      likeCount: widget.likeCount,
                    )),
              Flexible(child: body2Text("Live Session ${widget.liveSession}")),
            ],
          )
        ],
      ),
    );
  }
}
