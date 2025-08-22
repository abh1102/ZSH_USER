import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/sessions/widgets/book_slot_container.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';

class OneOnOneSessionDescription extends StatefulWidget {
  final Sessions session;
  const OneOnOneSessionDescription({super.key, required this.session});

  @override
  State<OneOnOneSessionDescription> createState() =>
      _OneOnOneSessionDescriptionState();
}

class _OneOnOneSessionDescriptionState
    extends State<OneOnOneSessionDescription> {
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
              OneOnOneDescContainer(
                  date: myformattedDate(widget.session.startDate ?? ""),
                  time: myformattedTime(widget.session.startDate ?? ""),
                  imgUrl: widget.session.coachProfile?.profile?.image,
                  name: widget.session.coachProfile?.profile?.fullName ?? "",
                  rating: widget.session.coachInfo?.rating ?? "0"),
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
            ],
          ),
        ),
      )),
    );
  }
}
