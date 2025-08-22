// ignore_for_file: unused_import, unnecessary_import
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/services/notification_services.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/choose_plan/data/repository/my_plan_repository.dart';
import 'package:zanadu/features/health_coach/data/repository/recommended_offering_repository.dart';
import 'package:zanadu/features/health_coach/logic/cubit/health_coach_cubit/health_coach_cubit.dart';
import 'package:zanadu/features/health_coach/logic/provider/special_provider.dart';
import 'package:zanadu/features/home/logic/cubit/top_health_coach/top_health_coach_cubit.dart';
import 'package:zanadu/features/home/logic/provider/home_bottom_provider.dart';
import 'package:zanadu/features/home/widgets/best_health_coach_widget.dart';
import 'package:zanadu/features/home/widgets/health_coach_container.dart';
import 'package:zanadu/features/home/widgets/orientation_container.dart';
import 'package:zanadu/features/home/widgets/speciality_coach_container.dart';
import 'package:zanadu/features/login/data/repository/login_repository.dart';
import 'package:zanadu/features/offerings/logic/cubit/offering/offering_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/speciality_cubit/speciality_cubit.dart';
import 'package:zanadu/features/profile/logic/cubits/notification_cubit/notification_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/feedback_cubit/feedback_cubit.dart';
import 'package:zanadu/features/sessions/widgets/feedback_dialog.dart';
import 'package:zanadu/features/sessions/widgets/rating_session.dart';

import 'package:zanadu/widgets/choose_a_plan_dialog.dart';
import 'package:zanadu/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:zanadu/widgets/whitebg_blacktext_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginRepository loginRepository = LoginRepository();
  NotificationServices notificationServices = NotificationServices();

  RecommendedOfferingRepository repos = RecommendedOfferingRepository();

  late SpecialityCoachCubit specialityCoachCubit;
  // late NotificationCubit notificationCubit;
  late FeedBackCubit feedBackCubit;

  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.isTokenRefresh();
    notificationServices.forgroundMessage();
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) async {
      String? deviceId = await notificationServices.getId();
      await loginRepository.updateDeviceInfo(
          deviceId: deviceId ?? "",
          firebaseToken: value.toString(),
          type: "phone");

      print(value.toString());
      print(deviceId);
    });
    specialityCoachCubit = BlocProvider.of<SpecialityCoachCubit>(context);
    specialityCoachCubit.getCurrentSelectedCoach();
    // notificationCubit = BlocProvider.of<NotificationCubit>(context);
    // notificationCubit.getUnreadNotificationData();
    feedBackCubit = BlocProvider.of<FeedBackCubit>(context);
    feedBackCubit.getPrevFeedBack();
  }

  void clearQuestionProvider() {
    var provider = Provider.of<SpecialQuestionProvider>(context, listen: false);

    provider.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    return MultiBlocListener(
        listeners: [
          BlocListener<SpecialityCoachCubit, SpecialityCoachState>(
              listener: (context, state) {
            if (state is GetCurrentSelectedCoachLoadedState) {
              if (state.coaches.isEmpty) {
                choosePlanDialog(context, () {
                  Routes.goBack();
                  tabIndexProvider.setInitialTabIndex(4);
                }, () {
                  Routes.goBack();
                  tabIndexProvider.setInitialTabIndex(3);
                });
              }
            }
            if (state is GetCurrentCoachErrorState) {
              showSnackBar(state.error);
            }
          }),
          // BlocListener<NotificationCubit, NotificationState>(
          //     listener: (context, state) {
          //   if (state is UnreadNotificationLoadedState) {
          //     if (state.notifications.isNotEmpty) {
          //       showGreenSnackBar("New Notification");
          //     }
          //   }
          // }),
          BlocListener<FeedBackCubit, FeedBackState>(
              listener: (context, state) {
            if (state is FeedBackCreateLoadedState) {
              showGreenSnackBar(state.feedBacks);
            }
            if (state is GetFeedBackLoadedState) {
              if (state.feedBacks.isNotEmpty) {
                givePrevRatingDialog(context, state.feedBacks[0].sId ?? "");
              }
            }
          })
        ],
        child: Scaffold(
          appBar: CustomAppBar(onpressed: () {
            // giveRatingDialog(context, "jlksfjlksjflkj");
            tabIndexProvider.setInitialTabIndex(4);
          }),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                ),
                child: Column(
                  children: [
                    height(20),
                    BestHealthCoachWidget(
                      text: "Best Health Coaches",
                      onTap: () {
                        tabIndexProvider.setInitialTabIndex(4);
                      },
                    ),
                    height(17),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Horizontal scrolling
                      child: BlocBuilder<FiveHealthCoachCubit,
                          FiveHealthCoachState>(
                        builder: (context, state) {
                          if (state is FiveHealthCoachLoadingState) {
                            return const CircularProgressIndicator.adaptive();
                          } else if (state is FiveHealthCoachLoadedState) {
                            // Access the loaded plan from the state

                            return Row(
                              children: List.generate(
                                state.healthCoach
                                    .length, // Change this to the number of containers you want
                                (index) {
                                  var data = state.healthCoach[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: 20.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Routes.goTo(Screens.healthCoachDetail,
                                            arguments: data);
                                      },
                                      child: HealthCoachContainer(
                                        imgUrl: data.profile?.image,
                                        likeCount: data.coachInfo?.likes == null
                                            ? "0"
                                            : data.coachInfo?.likes
                                                    .toString() ??
                                                "0",
                                        name:
                                            data.profile?.fullName.toString() ??
                                                "",
                                        rating: data.coachInfo?.rating == null
                                            ? "0"
                                            : data.coachInfo?.rating
                                                    .toString() ??
                                                "0",
                                        session: data.countSessions.toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is FiveHealthCoachErrorState) {
                            return Text('Error: ${state.error}');
                          } else {
                            return const Text('Something is wrong');
                          }
                        },
                      ),
                    ),
                    height(28),
                    BestHealthCoachWidget(
                      text: "Offerings",
                      onTap: () {
                        tabIndexProvider.setInitialTabIndex(3);
                      },
                    ),
                    height(16),
                    BlocBuilder<AllOfferingCubit, AllOfferingState>(
                      builder: (context, state) {
                        if (state is AllOfferingLoadingState) {
                          return const CircularProgressIndicator.adaptive();
                        } else if (state is AllOfferingLoadedState) {
                          // Access the loaded plan from the state

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.offering.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = state.offering[index];

                              if (data.title != "Health") {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 28.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Routes.goTo(Screens.browseOfferingDetail,
                                          arguments: data.sId);
                                    },
                                    child: SpecialityCoachContainer(
                                      imgUrl: data.icon,
                                      svg: "assets/images/Group (7).svg",
                                      text1: data.title.toString(),
                                      text2: data.subTitle.toString(),
                                    ),
                                  ),
                                );
                              } else {
                                // Return an empty container for offerings with the name "health"
                                return Container();
                              }
                            },
                          );
                        } else if (state is AllOfferingErrorState) {
                          return Text('Error: ${state.error}');
                        } else {
                          return const Text('Something is wrong');
                        }
                      },
                    ),
                    height(28),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
