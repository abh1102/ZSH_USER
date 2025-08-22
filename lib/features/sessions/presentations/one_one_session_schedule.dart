import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/logic/cubit/add_one_session_cubit/add_one_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/today_schedule_session_cubit/today_schedule_session_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/sessions/widgets/format_date_coach_schedule.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';
import 'package:zanadu/widgets/textfield_widget.dart';

class OneOneSessionScheduleScreen extends StatefulWidget {
  final String coachId;
  final String offeringId;
  const OneOneSessionScheduleScreen(
      {super.key, required this.coachId, required this.offeringId});

  @override
  State<OneOneSessionScheduleScreen> createState() =>
      _OneOneSessionScheduleScreenState();
}

class _OneOneSessionScheduleScreenState
    extends State<OneOneSessionScheduleScreen> {
  String? selectedDateText;
  String? selectedTimeText;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String formatSelectedDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$month-$day-$year';
  }

  TextEditingController title = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController sl = TextEditingController();
  int slots = 0;

  late AddOneSessionCubit getOneSession;
  late TodayScheduleSessionCubit todayScheduleSessionCubit;

  @override
  void initState() {
    super.initState();

    todayScheduleSessionCubit =
        BlocProvider.of<TodayScheduleSessionCubit>(context);

    getOneSession = BlocProvider.of<AddOneSessionCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOneSessionCubit, AddOneSessionState>(
        listener: (context, state) {
          if (state is OneOnOneSessionRequestedState) {
            // Show loading indicator

            Navigator.of(context).pop();

            Navigator.of(context).pop();
            Navigator.of(context).pop();
            //  getOneSession.fetchAddOneSession(widget.coachId);
            showGreenSnackBar(
              "Session Requested Successfully",
            );
          } else if (state is AddOneSessionLoadingState) {
            // Handle the new session created state
            // For example, close the loading dialog or navigate to another screen

            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            );
          } else if (state is AddOneSessionErrorState) {
            Navigator.of(context).pop();
            showSnackBar(state.error);
          }
        },
        child: Scaffold(
          appBar: const AppBarWithBackButtonWOSilver(
              firstText: "One On One", secondText: "Session"),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 28.h,
                  horizontal: 28.w,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      simpleText(
                        "Title",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                      height(8),
                      NoIconTextFieldWidget(
                        controller: title,
                      ),
                      height(16),
                      simpleText(
                        "Description",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                      height(8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.greyLight,
                            )),
                        child: TextFormField(
                          controller: description,
                          maxLines: 6,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      height(16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.greyLight,
                                  )),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 5.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: simpleText(
                                      selectedDateText ?? "Date",
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/icons/calendar(1).svg"),
                                    onPressed: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2101),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          selectedDate = picked;
                                          selectedDateText =
                                              formatSelectedDate(picked);
                                        });

                                        todayScheduleSessionCubit
                                            .createTodayScheduleSession(
                                                date: formatSelectedDateInYMD(
                                                    picked),
                                                coachId: widget.coachId);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          width(13),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.greyLight,
                                  )),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 5.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: simpleText(
                                      selectedTimeText ?? "Time",
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/icons/time.svg"),
                                    onPressed: () async {
                                      final TimeOfDay? picked =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (picked != null) {
                                        // Check if the selected time is in the past
                                        final DateTime selectedDateTime =
                                            DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          picked.hour,
                                          picked.minute,
                                        );
                                        if (selectedDateTime
                                            .isBefore(DateTime.now())) {
                                          // Show an error or handle the case where the time is in the past
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Please select a future time."),
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            selectedTime = picked;
                                            selectedTimeText =
                                                picked.format(context);
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (selectedDateText != null) height(40),
                      if (selectedDateText != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryBlue, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              simpleText(
                                "Coach Schedule of $selectedDateText",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              height(20),
                              BlocBuilder<TodayScheduleSessionCubit,
                                  TodayScheduleSessionState>(
                                builder: (context, state) {
                                  if (state
                                      is TodayScheduleSessionLoadingState) {
                                    return const Center(
                                        child: CircularProgressIndicator
                                            .adaptive());
                                  } else if (state
                                      is TodayScheduleSessionLoadedState) {
                                    // Access the loaded plan from the state
                                    var data = state.todaySchedule.sessions;
                                    if (data!.isEmpty) {
                                      return simpleText(
                                        "No Schedule for this date",
                                        align: TextAlign.center,
                                      );
                                    }
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: GetTodayScheduleCardSmall(
                                                sessionType:
                                                    data[index].sessionType ??
                                                        "",
                                                startTime: myformattedTime(
                                                    data[index].startDate ??
                                                        ""),
                                                sessionTime:
                                                    "${data[index].endDate} min"),
                                          );
                                        });
                                  } else if (state
                                      is TodayScheduleSessionErrorState) {
                                    return Text('Error: ${state.error}');
                                  } else {
                                    return const Text('Something is wrong');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      height(64),
                      ColoredButtonWithoutHW(
                        isLoading: false,
                        onpressed: () {
                          if ((int.tryParse(sl.text) ?? 0) <= 50) {
                            final formattedDateTime =
                                formatDateTime(selectedDate, selectedTime);
                            // Trigger the create session function here
                            if (title.text.trim().isNotEmpty &&
                                description.text.trim().isNotEmpty &&
                                selectedDateText != null &&
                                selectedTimeText != null) {
                              BlocProvider.of<AddOneSessionCubit>(context)
                                  .createOneOnOneSession(
                                      offeringId: widget.offeringId,
                                      sessionType: "FOLLOW_UP",
                                      title: title.text.trim(),
                                      description: description.text.trim(),
                                      coachId: widget.coachId,
                                      startDate: formattedDateTime,
                                      noOfSlots: 1,
                                      userId: myUser?.userInfo?.userId ?? " ");
                            } else {
                              showSnackBar("Please fill all the values");
                            }
                          } else {
                            showSnackBar("You can not fill more than 50 seats");
                          }
                        },
                        text: "Request a Session",
                        size: 16,
                        weight: FontWeight.w600,
                        verticalPadding: 14,
                      ),
                    ])),
          )),
        ));
  }
}

String formatDateTime(DateTime date, TimeOfDay time) {
  final dateTime =
      DateTime(date.year, date.month, date.day, time.hour, time.minute);
  final formattedDateTime =
      DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(dateTime.toUtc());
  return formattedDateTime;
}
