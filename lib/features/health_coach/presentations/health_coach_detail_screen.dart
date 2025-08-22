import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/health_coach/logic/cubit/health_coach_cubit/health_coach_cubit.dart';
import 'package:zanadu/features/home/logic/provider/home_bottom_provider.dart';
import 'package:zanadu/features/home/widgets/my_rating_row.dart';
import 'package:zanadu/features/offerings/logic/cubit/add_to_plan/add_to_plan_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/get_video_cubit/get_video_cubit.dart';
import 'package:zanadu/features/offerings/presentations/browse_see_all.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/image_widget.dart';
import 'package:zanadu/widgets/likes_converter.dart';

class HealthCoachDetailScreen extends StatefulWidget {
  final AllHealthCoachesModel healthCoach;
  const HealthCoachDetailScreen({super.key, required this.healthCoach});

  @override
  State<HealthCoachDetailScreen> createState() =>
      _HealthCoachDetailScreenState();
}

class _HealthCoachDetailScreenState extends State<HealthCoachDetailScreen> {
  late AddToPlanCubit addToPlanCubit;

  List<MyVideos>? approvedVideos;

  late GetVideoCubit getVideoCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addToPlanCubit = BlocProvider.of<AddToPlanCubit>(context);

    addToPlanCubit.fetchSelectedHealthCoach(widget.healthCoach.userId ?? "");
    getVideoCubit = BlocProvider.of<GetVideoCubit>(context);
    getVideoCubit.fetchCoachGetVideo(widget.healthCoach.userId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    var cub = BlocProvider.of<GetVideoCubit>(context, listen: true);
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    final controller =
        BlocProvider.of<AllHealthCoachCubit>(context, listen: true);
    return BlocListener<AllHealthCoachCubit, AllHealthCoachState>(
        listener: (context, state) {
          if (state is AllHealthCoachErrorState) {
            showSnackBar(state.error);
          }
          if (state is SelectHealthCoachLoadedState) {
            showGreenSnackBar(state.message);
          }
        },
        child: Scaffold(
          appBar: const AppBarWithBackButtonWOSilver(
              firstText: "Health", secondText: "Coach"),
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
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CustomImageWidget(
                      isContain: false,
                      url: widget.healthCoach.profile?.image ?? defaultAvatar,
                      myradius: 12,
                      mywidth: double.infinity,
                      myheight: 226.h,
                    ),
                  ),
                  height(20),
                  NewMyRatingRow(
                    name: widget.healthCoach.profile?.fullName ?? "",
                    rating: widget.healthCoach.coachInfo?.rating == null
                        ? "0"
                        : widget.healthCoach.coachInfo!.rating.toString(),
                    fontSize: 18,
                    weight: FontWeight.w700,
                    starSize: 15,
                  ),
                  height(8),
                  simpleText(
                    "Experience: ${widget.healthCoach.profile?.experience == null ? "0" : widget.healthCoach.profile?.experience.toString()} Years+",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  height(8),
                  simpleText(
                    widget.healthCoach.profile?.designation ?? "",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  height(10),
                  simpleText(
                    "Description ",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  height(5),
                  body2Text(
                    widget.healthCoach.profile?.bio ?? "",
                    color: AppColors.textLight,
                  ),
                  BlocBuilder<GetVideoCubit, GetVideoState>(
                    builder: (context, state) {
                      if (state is GetVideoLoadingState) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (state is GetCoachVideoLoadedState) {
                        approvedVideos = state.approvedVideos;
                        // Access the loaded plan from the state
                        if (state.demoVideos.isNotEmpty) {
                          return CoachVideoContainer(
                            likes: formatLikesCount(
                                state.demoVideos[0].likes?.length ?? 0),
                            imgUrl: state.demoVideos[0].thumbnailImage,
                            onpressed: () {
                              Routes.goTo(Screens.keyVideoDetailScren,
                                  arguments: {
                                    'videos': state.demoVideos[0],
                                    'coachId': widget.healthCoach.userId
                                  });
                            },
                            description: state.demoVideos[0].description ?? "",
                            title: state.demoVideos[0].title ?? "",
                          );
                        }
                        return Container();
                      } else if (state is GetVideoErrorState) {
                        return Text('Error: ${state.error}');
                      } else {
                        return const Text('Something is wrong');
                      }
                    },
                  ),
                  height(16),
                  BlocBuilder<AddToPlanCubit, AddToPlanState>(
                      builder: (context, state) {
                    if (state is SameHealthCoachSelectedState) {
                      return const ColoredButton(
                        text: "Selected",
                        size: 16,
                        weight: FontWeight.bold,
                      );
                    } else if (state is DifferentHealthCoachSelectedState) {
                      return const ColoredButton(
                        text: "Coach Already Selected",
                        size: 16,
                        weight: FontWeight.bold,
                      );
                    } else if (state is NoHealthCoachSelectedState) {
                      return ColoredButton(
                        isLoading:
                            controller.state is SelectHealthCoachLoadingState,
                        text: "Select",
                        size: 16,
                        weight: FontWeight.bold,
                        onpressed: () async {
                          await BlocProvider.of<AllHealthCoachCubit>(context)
                              .selectHealthCoach(
                                  widget.healthCoach.userId ?? "",
                                  widget.healthCoach.coachInfo?.offeringId ??
                                      "");
                          Routes.closeAllAndGoTo(Screens.homeBottomBar);
                          tabIndexProvider.setInitialTabIndex(4);
                        },
                      );
                    } else if (state is AddToPlanErrorState) {
                      simpleText(state.error);
                    }

                    return const ColoredButton(
                      isLoading: true,
                      text: "",
                      size: 16,
                      weight: FontWeight.bold,
                    );
                  }),
                  height(16),
                  SimpleWhiteTextButton(
                    isLoading: cub.state is GetVideoLoadingState,
                    onpressed: () {
                      if (cub.state is GetCoachVideoLoadedState) {
                        Routes.goTo(Screens.allBrowseSeeAll, arguments: {
                          'coachInfo': widget.healthCoach.coachInfo,
                          'videos': approvedVideos
                        });
                      }
                    },
                    verticalPadding: 16,
                    text: "See All Videos",
                    size: 16,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
