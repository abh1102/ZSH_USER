import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/logic/cubits/notification_cubit/notification_cubit.dart';
import 'package:zanadu/features/profile/widgets/notification_container.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/convert_utc_into_timezone.dart';

class ProfileNotificationScreen extends StatefulWidget {
  const ProfileNotificationScreen({super.key});

  @override
  State<ProfileNotificationScreen> createState() =>
      _ProfileNotificationScreenState();
}

class _ProfileNotificationScreenState extends State<ProfileNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWithAction(firstText: "Notification"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28.w,
              vertical: 28.h,
            ),
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (state is NotificationLoadedState) {
                  // Access the loaded plan from the state
                  if (state.notifications.isEmpty) {
                    return Center(
                        child: simpleText("There is no new notification"));
                  }
                  return Column(
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.notifications.length,
                          itemBuilder: (context, index) {
                            var data = state.notifications[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<NotificationCubit>()
                                      .markNotificationAsRead(data.sId ?? "");
                                },
                                child: NotificationContainer(
                                  description: data.description ?? "",
                                  title: data.title ?? "",
                                  date: myformattedDate(data.dateTime ?? ""),
                                  time: myformattedTime(data.dateTime ?? ""),
                                  isSeen: data.isRead ?? false,
                                ),
                              ),
                            );
                          })
                    ],
                  );
                } else if (state is NotificationErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
