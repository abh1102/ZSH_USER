import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/home/logic/provider/home_bottom_provider.dart';
import 'package:zanadu/features/home/widgets/my_rating_row.dart';
import 'package:zanadu/features/offerings/data/models/current_selected_coach_model.dart';
import 'package:zanadu/features/offerings/data/models/offering_model.dart';
import 'package:zanadu/features/offerings/logic/cubit/add_to_plan/add_to_plan_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/get_video_cubit/get_video_cubit.dart';
import 'package:zanadu/features/offerings/presentations/browse_see_all.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/image_widget.dart';
import 'package:zanadu/widgets/likes_converter.dart';

class HealthBrowseNewAddToPlan extends StatefulWidget {
  final CurrentSelectedCoachModel healthCoach;
  const HealthBrowseNewAddToPlan({super.key, required this.healthCoach});

  @override
  State<HealthBrowseNewAddToPlan> createState() =>
      _HealthBrowseNewAddToPlanState();
}

class _HealthBrowseNewAddToPlanState extends State<HealthBrowseNewAddToPlan> {
  late AddToPlanCubit addToPlanCubit;
  late GetVideoCubit getVideoCubit;
  List<MyVideos>? approvedVideos;

  @override
  void initState() {
    super.initState();

    addToPlanCubit = BlocProvider.of<AddToPlanCubit>(context);
    getVideoCubit = BlocProvider.of<GetVideoCubit>(context);

    // Assuming you have the offering ID, replace 'yourOfferingId' with the actual offering ID
    addToPlanCubit.fetchAddToPlan(
        widget.healthCoach.coachId ?? "", widget.healthCoach.offeringId ?? "");

    getVideoCubit.fetchCoachGetVideo(widget.healthCoach.coachId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    var cub = BlocProvider.of<GetVideoCubit>(context, listen: true);
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    return BlocListener<AddToPlanCubit, AddToPlanState>(
        listener: (context, state) {
          if (state is AddToPlanSelectDesState) {
            Routes.closeAllAndGoTo(Screens.homeBottomBar);
            tabIndexProvider.setInitialTabIndex(3);
            //Routes.goToReplacement(route)
          }
          if (state is AddToPlanErrorState) {
            Routes.goBack();
            showSnackBar(state.error);
            //Routes.goToReplacement(route)
          }
        },
        child: Scaffold(
          appBar: const AppBarWithBackButtonWOSilver(
              firstText: "Specialty", secondText: "Coach"),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 28.h,
                ),
                child: BlocBuilder<AddToPlanCubit, AddToPlanState>(
                  builder: (context, state) {
                    if (state is AddToPlanLoadingState) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (state is AddToPlanLoadedState) {
                      // Access the loaded plan from the state

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CustomImageWidget(
                              isContain: false,
                              url: widget.healthCoach.coachProfile?.profile
                                      ?.image ??
                                  defaultAvatar,
                              myradius: 12,
                              mywidth: double.infinity,
                              myheight: 226.h,
                            ),
                          ),
                          height(20),
                          NewMyRatingRow(
                            name: widget.healthCoach.coachProfile?.profile
                                    ?.fullName ??
                                ""
                                    "",
                            rating: widget.healthCoach.coachInfo?.rating == null
                                ? "0"
                                : widget.healthCoach.coachInfo?.rating
                                        .toString() ??
                                    "0",
                            fontSize: 18,
                            weight: FontWeight.w700,
                            starSize: 17,
                          ),
                          height(8),
                          body2Text(
                            "Experience: ${widget.healthCoach.coachProfile?.profile?.experience ?? "0"} Years+",
                            color: AppColors.textDark,
                          ),
                          height(8),
                          body2Text(
                            widget.healthCoach.coachProfile?.profile
                                    ?.designation ??
                                "",
                            color: AppColors.textDark,
                          ),
                          height(8),
                          body2Text("Description "),
                          height(5),
                          body2Text(
                            widget.healthCoach.coachProfile?.profile?.bio ?? "",
                            color: AppColors.textLight,
                          ),
                          height(20),
                          BlocBuilder<GetVideoCubit, GetVideoState>(
                            builder: (context, state) {
                              if (state is GetVideoLoadingState) {
                                return const Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                                    description:
                                        state.demoVideos[0].description ?? "",
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
                          height(40),
                          SimpleWhiteTextButton(
                            isLoading: cub.state is GetVideoLoadingState,
                            onpressed: () {
                              if (getVideoCubit.state
                                  is GetCoachVideoLoadedState) {
                                Routes.goTo(Screens.allBrowseSeeAll,
                                    arguments: {
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
                          height(16),
                          if (state.isSelected == false)
                            ColoredButton(
                              text: "Add to Plan",
                              size: 16,
                              weight: FontWeight.bold,
                              onpressed: () {
                                addToPlanCubit
                                    .selectOrDeselectCoachAndUpdateState(
                                        widget.healthCoach.coachId ?? "",
                                        true,
                                        widget.healthCoach.coachInfo
                                                ?.offeringId ??
                                            "");
                              },
                            ),
                          if (state.isSelected == true)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                WOGradButtonWithoutHW(
                                  onpressed: () {
                                    Routes.goTo(
                                      Screens.addPlanGroupSession,
                                      arguments: {
                                        'coachId': widget.healthCoach.coachId,
                                        'offeringId': widget
                                            .healthCoach.coachInfo?.offeringId,
                                      },
                                    );
                                  },
                                  verticalPadding: 16,
                                  color: AppColors.primaryBlue,
                                  text: "Group Sessions",
                                  size: 16,
                                  weight: FontWeight.w600,
                                ),
                                height(18),
                                !isYogaMeditationCoachFromSelectedCoach(
                                        widget.healthCoach)
                                    ? SizedBox()
                                    : WOGradButtonWithoutHW(
                                        onpressed: () {
                                          Routes.goTo(
                                            Screens.addPlanOneOneSession,
                                            arguments: {
                                              'myCoachId':
                                                  widget.healthCoach.coachId,
                                              'offeringId': widget.healthCoach
                                                  .coachInfo?.offeringId,
                                            },
                                          );
                                        },
                                        verticalPadding: 16,
                                        color: AppColors.primaryGreen,
                                        text: "One On One Sessions",
                                        size: 16,
                                        weight: FontWeight.w600,
                                      ),
                                if (isYogaMeditationCoachFromSelectedCoach(
                                    widget.healthCoach))
                                  height(18),
                                SimpleWhiteTextButton(
                                  onpressed: () {
                                    //  offerProvider.changeOfferSelected(false);
                                    addToPlanCubit
                                        .selectOrDeselectCoachAndUpdateState(
                                            widget.healthCoach.coachId ?? "",
                                            false,
                                            widget.healthCoach.coachInfo
                                                    ?.offeringId ??
                                                "");
                                  },
                                  verticalPadding: 16,
                                  text: "Remove From Plan",
                                  size: 16,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            )
                        ],
                      );
                    } else if (state is AddToPlanErrorState) {
                      return Text('Error: ${state.error}');
                    } else if (state is AddToPlanSelectDesState) {
                      return const SizedBox();
                    } else {
                      return const Text('Something is wrong');
                    }
                  },
                )),
          )),
        ));
  }
}

bool isYogaMeditationCoachFromSelectedCoach(
    CurrentSelectedCoachModel coachModel) {
  // Check if coachInfo is available
  bool isOneOnOne = true;

  if (coachModel.coachInfo != null) {
    // Get the offeringId from coachInfo
    String? offeringId = coachModel.coachInfo!.offeringId;

    for (OfferingsModel offerings in myOfferings ?? []) {
      if (offerings.sId == offeringId) {
        if (offerings.title == "Yoga") {
          isOneOnOne = false;
        } else if (offerings.title == "Meditation") {
          isOneOnOne = false;
        } else {
          isOneOnOne = true;
        }
      }
    }
    // Check if areaOfSpecialization is available and contains 'special'
  }

  return isOneOnOne; // The coach is not a Yoga or Meditation coach
}
