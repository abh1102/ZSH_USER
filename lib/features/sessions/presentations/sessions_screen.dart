import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/home/widgets/orientation_container.dart';
import 'package:zanadu/features/sessions/logic/cubit/cancel_reschedule_session_cubit/cancel_reschedule_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/session_cubit/session_cubit.dart';
import 'package:zanadu/features/sessions/widgets/cancel_one_on_one_session.dart';
import 'package:zanadu/features/sessions/widgets/group_session_container.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';
import 'package:zanadu/widgets/free_trial_dialog.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  String selectedLanguage = 'Feeling Unwell'; // Default selected language

  void cancelOneSession(String sessionId) {
    context
        .read<CancelRescheduleSessionCubit>()
        .cancelSession(sessionId: sessionId, reasonMessage: selectedLanguage);
  }

  void acceptdeclineSession(
      String sessionId, bool isApproved, String reasonMessage) {
    context.read<CancelRescheduleSessionCubit>().cancelOrRescheduleSession(
        sessionId, reasonMessage,
        isApproved: isApproved);
  }

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

  late AllSessionCubit getAllSession;
  @override
  void initState() {
    super.initState();

    getAllSession = BlocProvider.of<AllSessionCubit>(context);

    getAllSession.fetchAllSession(myUser?.userInfo?.userId.toString() ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: AppColors.primaryGreen,
            overlayColor: MaterialStateProperty.all(
              Colors.transparent,
            ),
            automaticIndicatorColorAdjustment: false,
            splashFactory: NoSplash.splashFactory,
            labelColor: AppColors.textDark,
            labelStyle: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.textDark,
            ),

            unselectedLabelColor: AppColors.greyLight,
            indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 8), // Adjust padding here
            tabs: const [
              Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Group Sessions"),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("One on One Sessions"),
                ),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Live",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                "Sessions",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 28.w,
                vertical: 20.h,
              ),
              child: BlocBuilder<AllSessionCubit, AllSessionState>(
                builder: (context, state) {
                  if (state is AllSessionLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is AllSessionLoadedState) {
                    // Access the loaded plan from the state

                    var orientationSessions = state.orientationSessions;

                    var groupSession = state.groupSessions;
                    var yogaSession = state.yoga;

                    if (orientationSessions.isEmpty &&
                        groupSession.isEmpty &&
                        yogaSession.isEmpty) {
                      return Center(
                        child: simpleText("There is no group session scheduled",
                            align: TextAlign.center),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orientationSessions.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var orientation = orientationSessions[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.sessionDescripPage,
                                          arguments: orientation);
                                    },
                                    child: OrientationsContainer(
                                        onpressed: () {
                                          Routes.goTo(
                                              Screens.groupVideoCallingNew,
                                              arguments: {
                                                'channelId':
                                                    orientation.channelName,
                                                'sessionId': orientation.sId,
                                                'uid': orientation.uid,
                                                'chatroomId':
                                                    orientation.chatroomId
                                              });
                                        },
                                        isJoin: isSessionJoinable(
                                            orientation.startDate ?? ""),
                                        imgUrl: orientation
                                            .coachProfile?.profile?.image,
                                        coachName: orientation.coachProfile
                                                ?.profile?.fullName ??
                                            "",
                                        date: myformattedDate(
                                            orientation.startDate ?? " "),
                                        time: myformattedTime(
                                            orientation.startDate ?? ""),
                                        title: orientation.title ?? ""),
                                  ),
                                );
                              }),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: yogaSession.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var yoga = yogaSession[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.sessionDescripPage,
                                          arguments: yoga);
                                    },
                                    child: GroupSessionContainer(
                                      isJoin: isSessionJoinable(
                                          yoga.startDate ?? ""),
                                      imgUrl: yoga.coachProfile?.profile?.image,
                                      date: myformattedDate(
                                          yoga.startDate ?? " "),
                                      time: myformattedTime(
                                          yoga.startDate ?? " "),
                                      coachName: yoga.coachProfile?.profile
                                              ?.fullName ??
                                          "",
                                      title: yoga.title ?? "",
                                      onpressed: () {
                                        Routes.goTo(
                                            Screens.groupVideoCallingNew,
                                            arguments: {
                                              'channelId': yoga.channelName,
                                              'sessionId': yoga.sId,
                                              'uid': yoga.uid,
                                              'chatroomId': yoga.chatroomId
                                            });
                                      },
                                    ),
                                  ),
                                );
                              }),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: groupSession.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var group = groupSession[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.sessionDescripPage,
                                          arguments: group);
                                    },
                                    child: GroupSessionContainer(
                                      isJoin: isSessionJoinable(
                                          group.startDate ?? ""),
                                      imgUrl:
                                          group.coachProfile?.profile?.image,
                                      date: myformattedDate(
                                          group.startDate ?? " "),
                                      time: myformattedTime(
                                          group.startDate ?? " "),
                                      coachName: group.coachProfile?.profile
                                              ?.fullName ??
                                          "",
                                      title: group.title ?? "",
                                      onpressed: () {
                                        Routes.goTo(
                                            Screens.groupVideoCallingNew,
                                            arguments: {
                                              'channelId': group.channelName,
                                              'sessionId': group.sId,
                                              'uid': group.uid,
                                              'chatroomId': group.chatroomId
                                            });
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  } else if (state is AllSessionErrorState) {
                    return Text('Error: ${state.error}');
                  } else {
                    return const Text('Something is wrong');
                  }
                },
              ),
            ),
            BlocListener<CancelRescheduleSessionCubit,
                CancelRescheduleSessionState>(
              listener: (context, state) {
                // if (state is CancelSessionLoading) {
                //   showLoadingIndicator(context);
                // }
                if (state is CancelSessionLoaded) {
                  // Routes.goBack();
                  showGreenSnackBar(state.message);
                  getAllSession.fetchAllSession(
                      myUser?.userInfo?.userId.toString() ?? "");
                }
                if (state is CancelSessionError) {
                  Routes.goBack();
                  showSnackBar(state.error);
                }
                if (state is CancelRescheduleSessionSuccess) {
                  showGreenSnackBar(state.result);
                  getAllSession.fetchAllSession(
                      myUser?.userInfo?.userId.toString() ?? "");
                } else if (state is CancelRescheduleSessionError) {
                  showSnackBar(state.error);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 20.h,
                ),
                child: BlocBuilder<AllSessionCubit, AllSessionState>(
                  builder: (context, state) {
                    if (state is AllSessionLoadingState) {
                      return const Center(
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator.adaptive()));
                    } else if (state is AllSessionLoadedState) {
                      // Access the loaded plan from the state
                      var oneSession = state.followUp;
                      var discovery = state.discovery;

                      if (oneSession.isEmpty && discovery.isEmpty) {
                        return Center(
                          child: simpleText(
                            "There is no One on One Session scheduled",
                            align: TextAlign.center,
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: oneSession.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var oneSes = oneSession[index];
                                if (oneSes.status == "REJECTED") {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(Screens.oneOneOneSessDesc,
                                              arguments: oneSes);
                                        },
                                        child: OneOnOneRejectContainer(
                                            imgUrl: oneSes
                                                .coachProfile?.profile?.image,
                                            isCanceled: false,
                                            title: oneSes.title ?? "",
                                            coachName: oneSes.coachProfile
                                                    ?.profile?.fullName ??
                                                "",
                                            date: myformattedDate(
                                                oneSes.startDate ?? " "),
                                            time: myformattedTime(
                                                oneSes.startDate ?? " "))),
                                  );
                                } else if (oneSes.status == "REQUESTED") {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(Screens.oneOneOneSessDesc,
                                              arguments: oneSes);
                                        },
                                        child: OneOnOneRequestedContainer(
                                            imgUrl: oneSes
                                                .coachProfile?.profile?.image,
                                            title: oneSes.title ?? "",
                                            coachName: oneSes.coachProfile
                                                    ?.profile?.fullName ??
                                                "",
                                            date: myformattedDate(
                                                oneSes.startDate ?? " "),
                                            time: myformattedTime(
                                                oneSes.startDate ?? " "))),
                                  );
                                } else if (oneSes.status == "CANCELED") {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(Screens.oneOneOneSessDesc,
                                              arguments: oneSes);
                                        },
                                        child: OneOnOneRejectContainer(
                                            imgUrl: oneSes
                                                .coachProfile?.profile?.image,
                                            isCanceled: true,
                                            title: oneSes.title ?? "",
                                            coachName: oneSes.coachProfile
                                                    ?.profile?.fullName ??
                                                "",
                                            date: myformattedDate(
                                                oneSes.startDate ?? " "),
                                            time: myformattedTime(
                                                oneSes.startDate ?? " "))),
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
                                      imgUrl:
                                          oneSes.coachProfile?.profile?.image,
                                      title: oneSes.title ?? "",
                                      coachName: oneSes.coachProfile?.profile
                                              ?.fullName ??
                                          "",
                                      date: myformattedDate(
                                          oneSes.startDate ?? " "),
                                      time: myformattedTime(
                                          oneSes.startDate ?? " "),
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneSessionContainer(
                                      imgUrl:
                                          oneSes.coachProfile?.profile?.image,
                                      date: myformattedDate(
                                          oneSes.startDate ?? " "),
                                      time: myformattedTime(
                                          oneSes.startDate ?? " "),
                                      onpressed: () {
                                        Routes.goTo(
                                            Screens.groupVideoCallingNew,
                                            arguments: {
                                              'channelId': oneSes.channelName,
                                              'sessionId': oneSes.sId,
                                              'uid': oneSes.uid,
                                              'chatroomId': oneSes.chatroomId
                                            });
                                      },
                                      coachName: oneSes.coachProfile?.profile
                                              ?.fullName ??
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
                                              cancelOneSession(
                                                  oneSes.sId ?? "");
                                            });
                                          },
                                        );
                                      },
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
                                      isJoin: isSessionJoinable(
                                          oneSes.startDate ?? ""),
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: discovery.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var oneSes = discovery[index];
                                if (oneSes.status == "REJECTED") {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(Screens.oneOneOneSessDesc,
                                              arguments: oneSes);
                                        },
                                        child: OneOnOneRejectContainer(
                                            imgUrl: oneSes
                                                .coachProfile?.profile?.image,
                                            isCanceled: false,
                                            title: oneSes.title ?? "",
                                            coachName: oneSes.coachProfile
                                                    ?.profile?.fullName ??
                                                "",
                                            date: myformattedDate(
                                                oneSes.startDate ?? " "),
                                            time: myformattedTime(
                                                oneSes.startDate ?? " "))),
                                  );
                                } else if (oneSes.status == "REQUESTED") {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(Screens.oneOneOneSessDesc,
                                              arguments: oneSes);
                                        },
                                        child: OneOnOneRequestedContainer(
                                            imgUrl: oneSes
                                                .coachProfile?.profile?.image,
                                            title: oneSes.title ?? "",
                                            coachName: oneSes.coachProfile
                                                    ?.profile?.fullName ??
                                                "",
                                            date: myformattedDate(
                                                oneSes.startDate ?? " "),
                                            time: myformattedTime(
                                                oneSes.startDate ?? " "))),
                                  );
                                } else if (oneSes.status == "CANCELED") {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
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
                                            oneSes.startDate ?? " "),
                                      ),
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
                                      imgUrl:
                                          oneSes.coachProfile?.profile?.image,
                                      title: oneSes.title ?? "",
                                      coachName: oneSes.coachProfile?.profile
                                              ?.fullName ??
                                          "",
                                      date: myformattedDate(
                                          oneSes.startDate ?? " "),
                                      time: myformattedTime(
                                          oneSes.startDate ?? " "),
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.oneOneOneSessDesc,
                                          arguments: oneSes);
                                    },
                                    child: OneOnOneSessionContainer(
                                      imgUrl:
                                          oneSes.coachProfile?.profile?.image,
                                      date: myformattedDate(
                                          oneSes.startDate ?? " "),
                                      time: myformattedTime(
                                          oneSes.startDate ?? " "),
                                      onpressed: () {
                                        Routes.goTo(
                                            Screens.groupVideoCallingNew,
                                            arguments: {
                                              'channelId': oneSes.channelName,
                                              'sessionId': oneSes.sId,
                                              'uid': oneSes.uid,
                                              'chatroomId': oneSes.chatroomId
                                            });
                                      },
                                      coachName: oneSes.coachProfile?.profile
                                              ?.fullName ??
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
                                              cancelOneSession(
                                                  oneSes.sId ?? "");
                                            });
                                          },
                                        );
                                      },
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
                                      isJoin: isSessionJoinable(
                                          oneSes.startDate ?? ""),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (state is AllSessionErrorState) {
                      return Text('Error: ${state.error}');
                    } else {
                      return const Text('Something is wrong');
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
