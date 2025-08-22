import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/home/widgets/my_rating_row.dart';
import 'package:zanadu/widgets/image_widget.dart';

class BookSlotContainer extends StatelessWidget {
  final VoidCallback? onpressed;
  const BookSlotContainer({
    super.key,
    this.onpressed,
  });

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
          Image.asset(
            "assets/icons/Rectangle 40.png",
            width: double.infinity,
            height: 145.h,
            fit: BoxFit.cover,
          ),
          height(10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyRatingRow(),
                    height(
                      5,
                    ),
                    body2Text(
                      "02-21-2023 10:00AM (EST)",
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  body2Text(
                    "Group Session",
                    color: AppColors.textLight,
                  ),
                  height(8),
                  body2Text(
                    "Slots Available 20 ",
                    color: AppColors.textLight,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class DescBookSlotContainer extends StatefulWidget {
  final String coachName;
  final int slotAvailable;
  final String rating;
  final String? imgUrl;
  final String date;
  final String time;
  final VoidCallback? onpressed;
  const DescBookSlotContainer({
    super.key,
    this.onpressed,
    required this.coachName,
    required this.slotAvailable,
    required this.rating,
    this.imgUrl,
    required this.date,
    required this.time,
  });

  @override
  State<DescBookSlotContainer> createState() => _DescBookSlotContainerState();
}

class _DescBookSlotContainerState extends State<DescBookSlotContainer> {
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
          CustomImageWidget(
            url: widget.imgUrl ?? defaultAvatar,
            myradius: 15,
            mywidth: double.infinity,
            myheight: 145.h,
          ),
          height(10),
          NewMyRatingRow(name: widget.coachName, rating: widget.rating),
          height(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      width: 12.w,
                      height: 12.h,
                    ),
                    width(1),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: simpleText(
                          widget.date,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                    width(8),
                    SvgPicture.asset(
                      "assets/icons/light_time.svg",
                      width: 12.w,
                      height: 12.h,
                    ),
                    width(1),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: simpleText(
                          widget.time,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: body2Text(
                  "Slots Available ${widget.slotAvailable} ",
                  color: AppColors.textLight,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class OneOnOneDescContainer extends StatefulWidget {
  final String name;
  final String rating;
  final String? imgUrl;
  final String date;
  final String time;

  final VoidCallback? onpressed;
  const OneOnOneDescContainer({
    super.key,
    this.onpressed,
    required this.name,
    required this.rating,
    this.imgUrl,
    required this.date,
    required this.time,
  });

  @override
  State<OneOnOneDescContainer> createState() => _OneOnOneDescContainerState();
}

class _OneOnOneDescContainerState extends State<OneOnOneDescContainer> {
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
          CustomImageWidget(
            url: widget.imgUrl ?? defaultAvatar,
            myradius: 15,
            mywidth: double.infinity,
            myheight: 145.h,
          ),
          height(10),
          NewMyRatingRow(name: widget.name, rating: widget.rating),
          height(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      width: 12.w,
                      height: 12.h,
                    ),
                    width(1),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: simpleText(
                          widget.date,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                    width(5),
                    SvgPicture.asset(
                      "assets/icons/light_time.svg",
                      width: 12.w,
                      height: 12.h,
                    ),
                    width(1),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: simpleText(
                          widget.time,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: body2Text(
                  "One on One Session",
                  color: AppColors.textLight,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
