import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/widgets/calendar_reminder_info.dart';
import 'package:zanadu/features/sessions/logic/cubit/session_cubit/session_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';

class CalendarReminderScreen extends StatefulWidget {
  const CalendarReminderScreen({Key? key}) : super(key: key);

  @override
  State<CalendarReminderScreen> createState() => _CalendarReminderScreenState();
}

class _CalendarReminderScreenState extends State<CalendarReminderScreen> {
  bool isSwitched = false;
  String? selectedDateTextCal;
  String? selectedTimeText;
  TextEditingController notesController = TextEditingController();

  String formatSelectedDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$month-$day-$year';
  }

  void showReminderDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => ReminderDialog(
        title: title,
        notesController: notesController,
        onDonePressed: (selectedDate, selectedReminder) {
          Duration reminderDuration;
          switch (selectedReminder) {
            case '10 minutes before':
              reminderDuration = Duration(minutes: 10);
              break;
            case '15 minutes before':
              reminderDuration = Duration(minutes: 15);
              break;
            case '1 hour before':
              reminderDuration = Duration(hours: 1);
              break;
            default:
              reminderDuration = Duration.zero;
          }

          addEventToCalendar(
            title,
            selectedDate,
            reminderDuration,
          );

          setState(() {
            selectedDateTextCal = null;
          });

          Navigator.pop(context);
        },
      ),
    );
  }

  void addEventToCalendar(
      String title, DateTime selectedDate, Duration reminderDuration) {
    final DateTime eventTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final Event event = Event(
      title: title,
      description: notesController.text,
      location: 'Event Location', // Add a location if needed
      startDate: eventTime,
      endDate: eventTime.add(const Duration(hours: 1)),
      iosParams: IOSParams(
        reminder: reminderDuration,
      ),
    );

    Add2Calendar.addEvent2Cal(event);
  }

  late AllSessionCubit getAllSession;
  @override
  void initState() {
    super.initState();

    getAllSession = BlocProvider.of<AllSessionCubit>(context);

    getAllSession.fetchAllSession(myUser?.userInfo?.userId.toString() ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
        firstText: "Calendar",
        secondText: "Reminder",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28.w,
              vertical: 28.h,
            ),
            child: BlocBuilder<AllSessionCubit, AllSessionState>(
              builder: (context, state) {
                if (state is AllSessionLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (state is AllSessionLoadedState) {
                  // Access the loaded plan from the state
                  var sessions = state.allSession;
                  var approvedSessions = sessions
                      .where((session) => session.isApproved == true)
                      .toList();

                  if (sessions.isEmpty ||
                      sessions
                          .every((session) => session.isApproved == false)) {
                    return Center(
                      child: simpleText("No Reminder"),
                    );
                  }
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: approvedSessions.length,
                        itemBuilder: (context, index) {
                          var data = approvedSessions[index];
                          return GestureDetector(
                            onTap: () {
                              showReminderDialog(data.title ?? "");
                            },
                            child: CalendarReminderInfo(
                              isSwitched: isSwitched,
                              title: data.title ?? "",
                              date: myformattedDate(data.startDate ?? ""),
                              time: myformattedTime(data.startDate ?? ""),
                              lessonName: data.sessionType ?? "",
                            ),
                          );
                        },
                      )
                    ],
                  );
                } else if (state is AllSessionErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return const Text('Something is wrong');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}

class ReminderDialog extends StatefulWidget {
  final String title;
  final TextEditingController notesController;
  final void Function(DateTime selectedDate, String selectedReminder)
      onDonePressed;

  ReminderDialog({
    required this.notesController,
    required this.onDonePressed,
    required this.title,
  });

  @override
  State<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  late DateTime selectedDate;
  DateTime? selectedDateMY;
  String selectedReminder = 'Add Notification';

  String? mySelectDate;

  @override
  void initState() {
    super.initState();
    // Set the default selectedDate to the current date
    selectedDate = DateTime.now();
  }

  String formatSelectedDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$month-$day-$year';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF25D366), Color(0xFF03C0FF)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/Vector.svg",
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),
                ],
              ),
              height(16),
              Center(
                child: heading1Text(
                  "Add Reminder",
                  textAlign: TextAlign.center,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 44.h),
              TextFormField(
                initialValue: widget.title,
                enabled: false,
                maxLines: 1,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              height(16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: body1Text(
                        mySelectDate ?? "Select Date",
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/calendar(1).svg",
                      ),
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
                            mySelectDate = formatSelectedDate(selectedDate);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              height(28),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: PopupMenuButton<String>(
                  onSelected: (String value) {
                    setState(() {
                      selectedReminder = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    List<String> reminderOptions = [
                      '10 minutes before',
                      '15 minutes before',
                      '1 hour before',
                    ];
                    return reminderOptions.map((String item) {
                      return PopupMenuItem<String>(
                        value: item,
                        child: simpleText(item,
                            color: AppColors.textLight.withOpacity(0.7)),
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      body1Text(selectedReminder),
                      SvgPicture.asset("assets/icons/time.svg"),
                    ],
                  ),
                ),
              ),
              height(28),
              TextField(
                controller: widget.notesController,
                maxLines: 4,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  hintText: 'Notes',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              height(64),
              GestureDetector(
                onTap: () {
                  widget.onDonePressed(selectedDate, selectedReminder);
                  // Clear the text field after pressing Done
                  widget.notesController.clear();
                  // Reset selectedDate to current date
                  setState(() {
                    selectedDate = DateTime.now();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                  alignment: Alignment.center,
                  child: simpleText(
                    "Done",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              height(20),
            ],
          ),
        ),
      ),
    );
  }
}
