import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/logic/cubit/cancel_reschedule_session_cubit/cancel_reschedule_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/today_schedule_session_cubit/today_schedule_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/provider/session_provider.dart';
import 'package:zanadu/features/sessions/presentations/one_one_session_schedule.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/sessions/widgets/format_date_coach_schedule.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';
import 'package:zanadu/widgets/free_trial_dialog.dart';

class OneOneSessionRescheduleScreen extends StatefulWidget {
  final String sessionId;
  final String coachId;
  const OneOneSessionRescheduleScreen(
      {super.key, required this.sessionId, required this.coachId});

  @override
  State<OneOneSessionRescheduleScreen> createState() =>
      _OneOneSessionRescheduleScreenState();
}

class _OneOneSessionRescheduleScreenState
    extends State<OneOneSessionRescheduleScreen> {
  String scheduleTime = '';

  late CancelRescheduleSessionCubit getCancelReschedule;
  late TodayScheduleSessionCubit todayScheduleSessionCubit;

  @override
  void initState() {
    super.initState();
    todayScheduleSessionCubit =
        BlocProvider.of<TodayScheduleSessionCubit>(context);
    getCancelReschedule =
        BlocProvider.of<CancelRescheduleSessionCubit>(context);
  }

  String getUniversalDateTime() {
    final provider = Provider.of<SessionProvider>(context, listen: false);
    if (provider.startDate != null && scheduleTime.isNotEmpty) {
      final parsedTime = TimeOfDay(
        hour: int.parse(scheduleTime.split(':')[0]),
        minute: int.parse(scheduleTime.split(':')[1].split(' ')[0]),
      );

      // Combine the date and time
      final localDateTime = DateTime(
        provider.startDate!.year,
        provider.startDate!.month,
        provider.startDate!.day,
        parsedTime.hourOfPeriod,
        parsedTime.minute,
      );

      // Convert local time to UTC
      final utcDateTime = localDateTime.toUtc();

      // Format the date and time in the desired format
      final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      final formattedDateTime = formatter.format(utcDateTime);
      return formattedDateTime;
    }
    return '';
  }

  String formatSelectedDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$month-$day-$year';
  }

  String? selectedDateText;
  String? selectedTimeText;
  String sessionType = "FOLLOW_UP";

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final cub =
        BlocProvider.of<CancelRescheduleSessionCubit>(context, listen: true);
    return Scaffold(
        appBar: const AppBarWithBackButtonWOSilver(
            firstText: "Reschedule", secondText: "Session"),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 28.h,
              horizontal: 28.w,
            ),
            child: BlocListener<CancelRescheduleSessionCubit,
                CancelRescheduleSessionState>(
              listener: (context, state) {
                if (state is CancelRescheduleSessionSuccess) {
                  // Show success dialog
                  oneSessionScheduledDialog(
                      context,
                      "Congratulations",
                      "Your request for reschedule session has been sent to the coach.",
                      "Done", () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                } else if (state is CancelRescheduleSessionError) {
                  // Handle error state
                  print("Error: ${state.error}");
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  simpleText(
                    "Select Date & Time",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textLight,
                  ),
                  height(8),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  final DateTime? picked = await showDatePicker(
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
                                            date:
                                                formatSelectedDateInYMD(picked),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: simpleText(
                                  selectedTimeText ?? "Time",
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: SvgPicture.asset("assets/icons/time.svg"),
                                onPressed: () async {
                                  final TimeOfDay? picked =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (picked != null) {
                                    // Check if the selected time is in the past
                                    final DateTime selectedDateTime = DateTime(
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
                  height(16),
                  simpleText(
                    "Comment",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textLight,
                  ),
                  height(8),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.greyDark,
                        )),
                    child: const TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  if (selectedDateText != null) height(40),
                  if (selectedDateText != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primaryBlue, width: 2),
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
                              if (state is TodayScheduleSessionLoadingState) {
                                return const Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: GetTodayScheduleCardSmall(
                                            sessionType:
                                                data[index].sessionType ?? "",
                                            startTime: myformattedTime(
                                                data[index].startDate ?? ""),
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
                  ColoredButton(
                    onpressed: () async {
                      if (selectedDateText == null ||
                          selectedTimeText == null) {
                        showSnackBar("Please fill all the values");
                      } else {
                        try {
                          // Call the API to reschedule the session
                          getCancelReschedule.cancelOrRescheduleSession(
                            widget.sessionId,
                            "unavailbe",
                            startDate:
                                formatDateTime(selectedDate, selectedTime),
                          );
                        } catch (e) {
                          // Handle error
                          print("Error: $e");
                        }
                      }
                    },
                    text: "Done",
                    size: 16,
                    weight: FontWeight.w600,
                    isLoading: cub.state is CancelRescheduleSessionLoading,
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
