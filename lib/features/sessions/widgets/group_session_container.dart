import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/image_widget.dart';

class OneOnOneSessionContainer extends StatefulWidget {
  final String title;
  final String coachName;
  final String date;
  final String? imgUrl;
  final String time;
  final VoidCallback? onpressed;
  final VoidCallback? cancelOnpressed;
  final VoidCallback? rescheduleOnpressed;
  final bool isJoin;
  const OneOnOneSessionContainer({
    Key? key,
    this.onpressed,
    this.cancelOnpressed,
    this.rescheduleOnpressed,
    required this.isJoin,
    required this.title,
    required this.coachName,
    required this.date,
    required this.time,
    this.imgUrl,
  }) : super(key: key);

  @override
  State<OneOnOneSessionContainer> createState() =>
      _OneOnOneSessionContainerState();
}

class _OneOnOneSessionContainerState extends State<OneOnOneSessionContainer> {
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
                            "${widget.time}",
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
                child: CustomImageWidget(
                  url: widget.imgUrl ?? defaultAvatar,
                  myradius: 8,
                  mywidth: 110.w,
                  myheight: 75.h,
                ),
              )
            ],
          ),
          height(
            16,
          ),
          Row(
            children: [
              widget.isJoin
                  ? Expanded(
                      child: GestureDetector(
                        onTap: widget.onpressed,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            vertical: 7.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen,
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
                      ),
                    )
                  : Expanded(
                      child: GestureDetector(
                        onTap: widget.rescheduleOnpressed,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            vertical: 7.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.textLight),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: simpleText(
                            "Reschedule",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                    ),
              width(28),
              Expanded(
                child: GestureDetector(
                  onTap: widget.cancelOnpressed,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textLight),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                    ),
                    child: simpleText(
                      "Cancel",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textLight,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GroupSessionContainer extends StatefulWidget {
  final VoidCallback? onpressed;
  final String title;
  final String? imgUrl;
  final String coachName;
  final String date;
  final String time;
  final bool isJoin;

  const GroupSessionContainer({
    super.key,
    this.onpressed,
    required this.title,
    required this.coachName,
    required this.date,
    required this.time,
    this.imgUrl,
    required this.isJoin,
  });

  @override
  State<GroupSessionContainer> createState() => _GroupSessionContainerState();
}

class _GroupSessionContainerState extends State<GroupSessionContainer> {
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
                            "${widget.time}",
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
                child: CustomImageWidget(
                  url: widget.imgUrl ?? defaultAvatar,
                  myradius: 8,
                  mywidth: 110.w,
                  myheight: 75.h,
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
                      color: AppColors.primaryBlue,
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

class OneOnOneRejectContainer extends StatefulWidget {
  final VoidCallback? onpressed;
  final String date;
  final String time;
  final String title;
  final bool isCanceled;
  final String? imgUrl;
  final String coachName;

  const OneOnOneRejectContainer({
    super.key,
    this.onpressed,
    required this.date,
    required this.time,
    required this.title,
    required this.coachName,
    required this.isCanceled,
    this.imgUrl,
  });

  @override
  State<OneOnOneRejectContainer> createState() =>
      _OneOnOneRejectContainerState();
}

class _OneOnOneRejectContainerState extends State<OneOnOneRejectContainer> {
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
                            "${widget.time}",
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
                child: CustomImageWidget(
                  url: widget.imgUrl ?? defaultAvatar,
                  myradius: 8,
                  mywidth: 110.w,
                  myheight: 75.h,
                ),
              )
            ],
          ),
          height(
            16,
          ),
          GestureDetector(
            onTap: widget.onpressed,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.secondaryRedColor,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  50,
                ),
              ),
              child: simpleText(
                widget.isCanceled == true ? "Canceled" : "Rejected",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryRedColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OneOnOneRequestedContainer extends StatefulWidget {
  final VoidCallback? onpressed;
  final String date;
  final String time;
  final String title;
  final String? imgUrl;
  final String coachName;

  const OneOnOneRequestedContainer({
    super.key,
    this.onpressed,
    required this.date,
    required this.time,
    required this.title,
    required this.coachName,
    this.imgUrl,
  });

  @override
  State<OneOnOneRequestedContainer> createState() =>
      _OneOnOneRequestedContainerState();
}

class _OneOnOneRequestedContainerState
    extends State<OneOnOneRequestedContainer> {
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
                            "${widget.time}",
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
                child: CustomImageWidget(
                  url: widget.imgUrl ?? defaultAvatar,
                  myradius: 8,
                  mywidth: 110.w,
                  myheight: 75.h,
                ),
              )
            ],
          ),
          height(
            16,
          ),
          GestureDetector(
            onTap: widget.onpressed,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.secondaryRedColor,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  50,
                ),
              ),
              child: simpleText(
                "Requested",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryRedColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BookGroupSessionContainer extends StatefulWidget {
  final String title;
  final String coachName;
  final bool isBooked;
  final VoidCallback? bookedOnpressed;
  final VoidCallback? onpressed;
  final String date;
  final String time;
  final String? imgUrl;
  const BookGroupSessionContainer({
    super.key,
    this.onpressed,
    required this.isBooked,
    this.bookedOnpressed,
    required this.title,
    required this.coachName,
    required this.date,
    required this.time,
    this.imgUrl,
  });

  @override
  State<BookGroupSessionContainer> createState() =>
      _BookGroupSessionContainerState();
}

class _BookGroupSessionContainerState extends State<BookGroupSessionContainer> {
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
                            "${widget.time}",
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
                child: CustomImageWidget(
                  url: widget.imgUrl ?? defaultAvatar,
                  myradius: 8,
                  mywidth: 110.w,
                  myheight: 75.h,
                ),
              )
            ],
          ),
          height(
            16,
          ),
          GestureDetector(
              onTap:
                  widget.isBooked ? widget.bookedOnpressed : widget.onpressed,
              child: widget.isBooked
                  ? const GreySubmitButtonWOHW(
                      text: "Booked",
                      size: 14,
                      weight: FontWeight.w500,
                      colored: false,
                      verticalPadding: 7)
                  : Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: simpleText(
                        "Book My Slot",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ))
        ],
      ),
    );
  }
}

//session for accept

class OneOnOneAcceptContainer extends StatefulWidget {
  final String date;
  final String time;
  final bool? isLoading;
  final bool? isAcceptLoading;
  final String title;
  final VoidCallback? onpressed;
  final VoidCallback? accept;
  final VoidCallback? decline;
  final String? imgUrl;
  final String coachName;

  const OneOnOneAcceptContainer({
    super.key,
    required this.date,
    required this.time,
    required this.title,
    required this.coachName,
    this.imgUrl,
    this.onpressed,
    this.accept,
    this.decline, this.isLoading, this.isAcceptLoading,
  });

  @override
  State<OneOnOneAcceptContainer> createState() =>
      _OneOnOneAcceptContainerState();
}

class _OneOnOneAcceptContainerState extends State<OneOnOneAcceptContainer> {
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
                            "${widget.time}",
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
                child: CustomImageWidget(
                  url: widget.imgUrl ?? defaultAvatar,
                  myradius: 8,
                  mywidth: 110.w,
                  myheight: 75.h,
                ),
              )
            ],
          ),
          height(
            16,
          ),
          Row(
            children: [
              Expanded(
                child: ColoredButtonWithoutHW(
                  isLoading: widget.isLoading??false,
                  onpressed: widget.accept,
                  text: "Accept",
                  size: 13,
                  weight: FontWeight.w400,
                  verticalPadding: 6,
                ),
              ),
              width(9),
              Expanded(
                child: WhiteBgBlackTextButtonWOHW(
                  isLoading: widget.isAcceptLoading??false,
                  onpressed: widget.decline,
                  text: "Decline",
                  size: 13,
                  weight: FontWeight.w400,
                  vertialPadding: 6,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
