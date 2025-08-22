import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/sessions/widgets/book_slot_container.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';

class SessionDescriptiontScreen extends StatefulWidget {
  final Sessions session;
  const SessionDescriptiontScreen({super.key, required this.session});

  @override
  State<SessionDescriptiontScreen> createState() =>
      _SessionDescriptiontScreenState();
}

class _SessionDescriptiontScreenState extends State<SessionDescriptiontScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Session", secondText: "Details"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
            vertical: 28.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height(20),
              DescBookSlotContainer(
                  date: myformattedDate(widget.session.startDate ?? ""),
                  time: myformattedTime(widget.session.startDate ?? ""),
                  imgUrl: widget.session.coachProfile?.profile?.image,
                  coachName:
                      widget.session.coachProfile?.profile?.fullName ?? "",
                  rating: widget.session.coachInfo?.rating ?? "0",
                  slotAvailable: widget.session.noOfSlots! -
                      widget.session.userId!.length),
              height(16),
              body1Text(
                widget.session.title ?? "",
              ),
              height(16),
              body2Text("Description "),
              height(5),
              body2Text(
                widget.session.description ?? "",
                color: AppColors.textLight,
              ),
              height(64),
              isSessionJoinable(widget.session.startDate ?? "") == true
                  ? ColoredButtonWithoutHW(
                      isLoading: false,
                      verticalPadding: 13,
                      text: "Join Now",
                      size: 16,
                      weight: FontWeight.bold,
                      onpressed: () {
                        Routes.goTo(Screens.groupVideoCallingNew, arguments: {
                          'channelId': widget.session.channelName,
                          'sessionId': widget.session.sId,
                          'uid': widget.session.uid,
                          'chatroomId': widget.session.chatroomId
                        });
                      },
                    )
                  : Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 13.h),
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
        ),
      )),
    );
  }
}
