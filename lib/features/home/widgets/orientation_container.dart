import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/image_widget.dart';

class OrientationsContainer extends StatefulWidget {
  final String date;
  final String time;
  final bool isJoin;
  final String coachName;
  final String? imgUrl;
  final String title;
  final VoidCallback? onpressed;
  const OrientationsContainer({
    super.key,
    required this.date,
    required this.time,
    required this.coachName,
    required this.title,
    this.onpressed,
    this.imgUrl,
    required this.isJoin,
  });

  @override
  State<OrientationsContainer> createState() => _OrientationsContainerState();
}

class _OrientationsContainerState extends State<OrientationsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    simpleText(
                      widget.title,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    height(6),
                    simpleText(
                      widget.coachName,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    height(6),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/calendar.svg",
                          width: 12.w,
                          height: 12.h,
                        ),
                        width(7),
                        Flexible(
                          child: simpleText(
                            widget.date,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                        ),
                        width(8),
                        SvgPicture.asset(
                          "assets/icons/light_time.svg",
                          width: 12.w,
                          height: 12.h,
                        ),
                        width(7),
                        Flexible(
                          child: simpleText(
                            widget.time,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 110.w,
                height: 75.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1.6,
                      color: AppColors.primaryBlue,
                    )),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomImageWidget(
                    url: widget.imgUrl ?? defaultAvatar,
                    myradius: 8,
                    mywidth: 110.w,
                    myheight: 75.h,
                  ),
                ),
              )
            ],
          ),
          height(
            16,
          ),
          widget.isJoin
              ? GestureDetector(
                  onTap: widget.onpressed,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.megenta,
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                    ),
                    child: simpleText(
                      "Join Now",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.greyDark),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: simpleText(
                    "Join Now",
                    color: AppColors.greyDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ],
      ),
    );
  }
}
