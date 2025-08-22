import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/sessions/logic/cubit/add_group_session_cubit/add_group_session_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/sessions/widgets/group_session_container.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';

class AddPlanGroupSessionScreen extends StatefulWidget {
  final String coachId;
  final String offeringId;
  const AddPlanGroupSessionScreen(
      {super.key, required this.coachId, required this.offeringId});

  @override
  State<AddPlanGroupSessionScreen> createState() =>
      _AddPlanGroupSessionScreenState();
}

class _AddPlanGroupSessionScreenState extends State<AddPlanGroupSessionScreen> {
  late AddGroupSessionCubit getGroupSession;
  @override
  void initState() {
    super.initState();

    getGroupSession = BlocProvider.of<AddGroupSessionCubit>(context);

    getGroupSession.fetchAddGroupSession(widget.coachId, widget.offeringId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Group", secondText: "Sessions"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
          ),
          child: BlocBuilder<AddGroupSessionCubit, AddGroupSessionState>(
            builder: (context, state) {
              if (state is AddGroupSessionLoadingState) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              } else if (state is AddGroupSessionLoadedState) {
                // Access the loaded plan from the state
                var groupSession = state.groupSessions;
                var orientationSessions = state.orientationSessions;
                var yogaSession = state.yogaSessions;
                if (groupSession.isEmpty &&
                    orientationSessions.isEmpty &&
                    yogaSession.isEmpty) {
                  return Center(
                    child: simpleText("There is no session schedule"),
                  );
                }
                return Column(
                  children: [
                    height(20),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groupSession.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var group = groupSession[index];
                          bool isUserInSession = group.userId
                                  ?.contains(myUser?.userInfo?.userId) ??
                              false;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: BookGroupSessionContainer(
                              imgUrl: group.coachProfile?.profile?.image,
                              date: myformattedDate(group.startDate ?? " "),
                              time: myformattedTime(group.startDate ?? " "),
                              coachName:
                                  group.coachProfile?.profile?.fullName ?? "",
                              title: group.title ?? "",
                              isBooked: isUserInSession,
                              bookedOnpressed: () {
                                Routes.goTo(Screens.sessionBookSlot,
                                    arguments: group);
                              },
                              onpressed: () {
                                Routes.goTo(Screens.sessionBookSlot,
                                    arguments: group);
                              },
                            ),
                          );
                        }),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orientationSessions.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var group = orientationSessions[index];
                          bool isUserInSession = group.userId
                                  ?.contains(myUser?.userInfo?.userId) ??
                              false;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: BookGroupSessionContainer(
                              imgUrl: group.coachProfile?.profile?.image,
                              date: myformattedDate(group.startDate ?? " "),
                              time: myformattedTime(group.startDate ?? " "),
                              coachName:
                                  group.coachProfile?.profile?.fullName ?? "",
                              title: group.title ?? "",
                              isBooked: isUserInSession,
                              bookedOnpressed: () {
                                Routes.goTo(Screens.sessionBookSlot,
                                    arguments: group);
                              },
                              onpressed: () {
                                Routes.goTo(Screens.sessionBookSlot,
                                    arguments: group);
                              },
                            ),
                          );
                        }),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: yogaSession.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var group = yogaSession[index];
                          bool isUserInSession = group.userId
                                  ?.contains(myUser?.userInfo?.userId) ??
                              false;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: BookGroupSessionContainer(
                              imgUrl: group.coachProfile?.profile?.image,
                              date: myformattedDate(group.startDate ?? " "),
                              time: myformattedTime(group.startDate ?? " "),
                              coachName:
                                  group.coachProfile?.profile?.fullName ?? "",
                              title: group.title ?? "",
                              isBooked: isUserInSession,
                              bookedOnpressed: () {
                                print(isUserInSession);
                                Routes.goTo(Screens.sessionBookSlot,
                                    arguments: group);
                              },
                              onpressed: () {
                                print(isUserInSession);
                                Routes.goTo(Screens.sessionBookSlot,
                                    arguments: group);
                              },
                            ),
                          );
                        }),
                  ],
                );
              } else if (state is AddGroupSessionErrorState) {
                return Text('Error: ${state.error}');
              } else {
                return const Text('Something is wrong');
              }
            },
          ),
        ),
      )),
    );
  }
}
