import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/sessions/logic/cubit/add_one_session_cubit/add_one_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/cancel_reschedule_session_cubit/cancel_reschedule_session_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/sessions/widgets/cancel_one_on_one_session.dart';
import 'package:zanadu/features/sessions/widgets/floating_colored_button.dart';
import 'package:zanadu/features/sessions/widgets/group_session_container.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';

import 'package:zanadu/widgets/free_trial_dialog.dart';

class AddPlanOneOneSessionScreen extends StatefulWidget {
  final String myCoachId;
  final String offeringId;
  const AddPlanOneOneSessionScreen(
      {super.key, required this.myCoachId, required this.offeringId});

  @override
  State<AddPlanOneOneSessionScreen> createState() =>
      _AddPlanOneOneSessionScreenState();
}

class _AddPlanOneOneSessionScreenState
    extends State<AddPlanOneOneSessionScreen> {
  String selectedLanguage = 'Feeling Unwell'; // Default selected language

  void showCancelOneSessionDialog(
      BuildContext context, VoidCallback onpressed) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelOneonOneSessionReason(
          onpressed: onpressed,
          selectReason: selectedLanguage,
          onLanguageSelected: (value) {
            setState(() {
              selectedLanguage = value;
            });
          },
        );
      },
    );
  }

  String rescheduleReason = 'Feeling Unwell'; // Default selected language

  void showRescheduleOneSessionDialog(
      BuildContext context, VoidCallback onpressed) {
    showDialog(
      context: context,
      builder: (context) {
        return RescheduleOneonOneSessionReason(
          onpressed: onpressed,
          selectReason: rescheduleReason,
          onLanguageSelected: (value) {
            setState(() {
              rescheduleReason = value;
            });
          },
        );
      },
    );
  }

  late AddOneSessionCubit getOneSession;
  @override
  void initState() {
    super.initState();

    getOneSession = BlocProvider.of<AddOneSessionCubit>(context);

    getOneSession.fetchAddOneSession(widget.myCoachId, widget.offeringId);
  }

  void cancelOneSession(String sessionId) {
    context.read<CancelRescheduleSessionCubit>().cancelOrRescheduleSession(
        sessionId, selectedLanguage,
        isApproved: false);
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your session has been successfully canceled.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void acceptdeclineSession(
      String sessionId, bool isApproved, String reasonMessage) {
    context.read<CancelRescheduleSessionCubit>().cancelOrRescheduleSession(
        sessionId, reasonMessage,
        isApproved: isApproved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingColoredButton(
        text: "Request a Session",
        size: 16,
        weight: FontWeight.w600,
        verticalPadding: 14,
        onpressed: () {
          print(widget.myCoachId);
          print(widget.offeringId);
          Routes.goTo(
            Screens.oneOnOneSession,
            arguments: {
              'coachId': widget.myCoachId,
              'offeringId': widget.offeringId,
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "One On One", secondText: "Sessions"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 28.w,
          ),
          child: Column(
            children: [
              BlocListener<CancelRescheduleSessionCubit,
                  CancelRescheduleSessionState>(
                listener: (context, state) {
                  if (state is CancelRescheduleSessionSuccess) {
                    showGreenSnackBar(
                      state.result,
                      behavior: SnackBarBehavior.fixed,
                    );
                    getOneSession.fetchAddOneSession(
                        widget.myCoachId, widget.offeringId);
                    // showSuccessDialog();
                  } else if (state is CancelRescheduleSessionError) {
                    showSnackBar(
                      state.error,
                      behavior: SnackBarBehavior.fixed,
                    );
                    // showErrorDialog(state.error);
                  }
                },
                child: Container(), // An empty container or placeholder
              ),
              BlocBuilder<AddOneSessionCubit, AddOneSessionState>(
                builder: (context, state) {
                  if (state is AddOneSessionLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is AddOneSessionLoadedState) {
                    // Access the loaded plan from the state
                    var oneSessions = state.oneSessions;
                    var followUp = state.followUp;

                    if (oneSessions.isEmpty && followUp.isEmpty) {
                      return Center(
                        child: simpleText(
                            "There is no One on One Session Scheduled",
                            align: TextAlign.center),
                      );
                    }

                    return Column(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: oneSessions.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var oneSes = oneSessions[index];
                              if (oneSes.status == "REJECTED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneRejectContainer(
                                        imgUrl:
                                            oneSes.coachProfile?.profile?.image,
                                        isCanceled: false,
                                        title: oneSes.title ?? "",
                                        coachName: oneSes.coachProfile?.profile
                                                ?.fullName ??
                                            "",
                                        date: myformattedDate(
                                            oneSes.startDate ?? " "),
                                        time: myformattedTime(
                                            oneSes.startDate ?? " ")),
                                  ),
                                );
                              } else if (oneSes.status == "CANCELED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneRejectContainer(
                                        imgUrl:
                                            oneSes.coachProfile?.profile?.image,
                                        isCanceled: true,
                                        title: oneSes.title ?? "",
                                        coachName: oneSes.coachProfile?.profile
                                                ?.fullName ??
                                            "",
                                        date: myformattedDate(
                                            oneSes.startDate ?? " "),
                                        time: myformattedTime(
                                            oneSes.startDate ?? " ")),
                                  ),
                                );
                              } else if (oneSes.status == "REQUESTED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneRequestedContainer(
                                        imgUrl:
                                            oneSes.coachProfile?.profile?.image,
                                        title: oneSes.title ?? "",
                                        coachName: oneSes.coachProfile?.profile
                                                ?.fullName ??
                                            "",
                                        date: myformattedDate(
                                            oneSes.startDate ?? " "),
                                        time: myformattedTime(
                                            oneSes.startDate ?? " ")),
                                  ),
                                );
                              } else if (oneSes.status == "COACH_REQUESTED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: OneOnOneAcceptContainer(
                                    accept: () {
                                      acceptdeclineSession(oneSes.sId ?? "",
                                          true, "Accepted by user");
                                    },
                                    decline: () {
                                      acceptdeclineSession(oneSes.sId ?? "",
                                          false, "Declined by user");
                                    },
                                    imgUrl: oneSes.coachProfile?.profile?.image,
                                    title: oneSes.title ?? "",
                                    coachName: oneSes
                                            .coachProfile?.profile?.fullName ??
                                        "",
                                    date: myformattedDate(
                                        oneSes.startDate ?? " "),
                                    time: myformattedTime(
                                        oneSes.startDate ?? " "),
                                  ),
                                );
                              }
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Routes.goTo(Screens.oneOneOneSessDesc,
                                        arguments: oneSes);
                                  },
                                  child: OneOnOneSessionContainer(
                                    onpressed: () {
                                      Routes.goTo(Screens.groupVideoCallingNew,
                                          arguments: {
                                            'channelId': oneSes.channelName,
                                            'sessionId': oneSes.sId,
                                            'uid': oneSes.uid
                                          });
                                    },
                                    imgUrl: oneSes.coachProfile?.profile?.image,
                                    date: myformattedDate(
                                        oneSes.startDate ?? " "),
                                    time: myformattedTime(
                                        oneSes.startDate ?? " "),
                                    rescheduleOnpressed: () {
                                      showRescheduleOneSessionDialog(context,
                                          () {
                                        Routes.goTo(
                                            Screens.oneSessionRescheduled,
                                            arguments: {
                                              "coachId": oneSes.coachId,
                                              "sessionId": oneSes.sId
                                            });
                                      });
                                    },
                                    coachName: oneSes
                                            .coachProfile?.profile?.fullName ??
                                        "",
                                    title: oneSes.title ?? "",
                                    cancelOnpressed: () {
                                      simpleDialog(
                                        context,
                                        "Confirm",
                                        "Are you sure you want to Cancel this Session?",
                                        "Cancel",
                                        "Go Back",
                                        () {
                                          Navigator.pop(context);
                                          showCancelOneSessionDialog(context,
                                              () {
                                            Navigator.of(context).pop();
                                            cancelOneSession(oneSes.sId ?? "");
                                          });
                                        },
                                      );
                                    },
                                    isJoin: isSessionJoinable(
                                        oneSes.startDate ?? ""),
                                  ),
                                ),
                              );
                            }),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: followUp.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var oneSes = followUp[index];
                              if (oneSes.status == "REJECTED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneRejectContainer(
                                        imgUrl:
                                            oneSes.coachProfile?.profile?.image,
                                        isCanceled: false,
                                        title: oneSes.title ?? "",
                                        coachName: oneSes.coachProfile?.profile
                                                ?.fullName ??
                                            "",
                                        date: myformattedDate(
                                            oneSes.startDate ?? " "),
                                        time: myformattedTime(
                                            oneSes.startDate ?? " ")),
                                  ),
                                );
                              } else if (oneSes.status == "CANCELED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneRejectContainer(
                                        imgUrl:
                                            oneSes.coachProfile?.profile?.image,
                                        isCanceled: true,
                                        title: oneSes.title ?? "",
                                        coachName: oneSes.coachProfile?.profile
                                                ?.fullName ??
                                            "",
                                        date: myformattedDate(
                                            oneSes.startDate ?? " "),
                                        time: myformattedTime(
                                            oneSes.startDate ?? " ")),
                                  ),
                                );
                              } else if (oneSes.status == "REQUESTED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneRequestedContainer(
                                        imgUrl:
                                            oneSes.coachProfile?.profile?.image,
                                        title: oneSes.title ?? "",
                                        coachName: oneSes.coachProfile?.profile
                                                ?.fullName ??
                                            "",
                                        date: myformattedDate(
                                            oneSes.startDate ?? " "),
                                        time: myformattedTime(
                                            oneSes.startDate ?? " ")),
                                  ),
                                );
                              } else if (oneSes.status == "COACH_REQUESTED") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: OneOnOneAcceptContainer(
                                    accept: () {
                                      acceptdeclineSession(oneSes.sId ?? "",
                                          true, "Accepted by user");
                                    },
                                    decline: () {
                                      acceptdeclineSession(oneSes.sId ?? "",
                                          false, "Declined by user");
                                    },
                                    imgUrl: oneSes.coachProfile?.profile?.image,
                                    title: oneSes.title ?? "",
                                    coachName: oneSes
                                            .coachProfile?.profile?.fullName ??
                                        "",
                                    date: myformattedDate(
                                        oneSes.startDate ?? " "),
                                    time: myformattedTime(
                                        oneSes.startDate ?? " "),
                                  ),
                                );
                              }
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Routes.goTo(Screens.oneOneOneSessDesc,
                                        arguments: oneSes);
                                  },
                                  child: OneOnOneSessionContainer(
                                    onpressed: () {
                                      Routes.goTo(Screens.groupVideoCallingNew,
                                          arguments: {
                                            'channelId': oneSes.channelName,
                                            'sessionId': oneSes.sId,
                                            'uid': oneSes.uid
                                          });
                                    },
                                    imgUrl: oneSes.coachProfile?.profile?.image,
                                    date: myformattedDate(
                                        oneSes.startDate ?? " "),
                                    time: myformattedTime(
                                        oneSes.startDate ?? " "),
                                    rescheduleOnpressed: () {
                                      showRescheduleOneSessionDialog(context,
                                          () {
                                        Routes.goTo(
                                            Screens.oneSessionRescheduled,
                                            arguments: {
                                              "coachId": oneSes.coachId,
                                              "sessionId": oneSes.sId
                                            });
                                      });
                                    },
                                    coachName: oneSes
                                            .coachProfile?.profile?.fullName ??
                                        "",
                                    title: oneSes.title ?? "",
                                    cancelOnpressed: () {
                                      simpleDialog(
                                        context,
                                        "Confirm",
                                        "Are you sure you want to Cancel this Session?",
                                        "Cancel",
                                        "Go Back",
                                        () {
                                          Navigator.pop(context);
                                          showCancelOneSessionDialog(context,
                                              () {
                                            Navigator.of(context).pop();
                                            cancelOneSession(oneSes.sId ?? "");
                                          });
                                        },
                                      );
                                    },
                                    isJoin: isSessionJoinable(
                                        oneSes.startDate ?? ""),
                                  ),
                                ),
                              );
                            }),
                        height(50)
                      ],
                    );
                  } else if (state is AddOneSessionErrorState) {
                    return Text('Error: ${state.error}');
                  } else {
                    return const Text('Something is wrong');
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
