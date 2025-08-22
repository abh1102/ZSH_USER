import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart';
import 'package:zanadu/features/sessions/logic/cubit/book_slot_group_cubit/book_slot_group_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/sessions/widgets/book_slot_container.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';
import 'package:zanadu/widgets/free_trial_dialog.dart';

class SessionBookSlotScreen extends StatefulWidget {
  final Sessions session;

  const SessionBookSlotScreen({Key? key, required this.session})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SessionBookSlotScreenState createState() => _SessionBookSlotScreenState();
}

class _SessionBookSlotScreenState extends State<SessionBookSlotScreen> {
  late SessionBookingCubit _sessionBookingCubit;

  @override
  void initState() {
    super.initState();

    _sessionBookingCubit = SessionBookingCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _sessionBookingCubit,
      child: BlocConsumer<SessionBookingCubit, SessionBookingState>(
        listener: (context, state) {
          if (state is SessionBookingSuccess) {
            // Show the success dialog
            simpleDialogWithOneButton(
              context,
              "Confirmation",
              "Your slot has been booked. You can check it in your sessions tab",
              "Done",
              () {
                Navigator.pop(context);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          } else if (state is SessionBookingError) {
            // Handle the error, e.g., show an error message
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(state.error),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: const AppBarWithBackButtonWOSilver(
              firstText: "Session",
              secondText: "Details",
            ),
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
                      DescBookSlotContainer(
                        date: myformattedDate(widget.session.startDate ?? ""),
                        time: myformattedTime(widget.session.startDate ?? ""),
                        imgUrl: widget.session.coachProfile?.profile?.image,
                        coachName:
                            widget.session.coachProfile?.profile?.fullName ??
                                "",
                        rating: widget.session.coachInfo?.rating ?? "0",
                        slotAvailable: widget.session.noOfSlots! -
                            widget.session.userId!.length,
                      ),
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
                      widget.session.userId
                                  ?.contains(myUser?.userInfo?.userId) ==
                              true
                          ? const GreySubmitButtonWOHW(
                              text: "Booked",
                              size: 14,
                              weight: FontWeight.w500,
                              colored: false,
                              verticalPadding: 7)
                          : ColoredButton(
                              isLoading: _sessionBookingCubit.state
                                  is SessionBookingLoading,
                              text: "Book My Slot",
                              size: 16,
                              weight: FontWeight.bold,
                              onpressed: () {
                                _sessionBookingCubit.bookSlot(
                                  widget.session.sId ?? "",
                                  myUser?.userInfo?.userId ??
                                      "", // Replace with the actual user ID
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
