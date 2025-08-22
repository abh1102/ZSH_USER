import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/logic/cubit/health_coach_cubit/health_coach_cubit.dart';
import 'package:zanadu/features/health_coach/logic/cubit/health_speciality_cubit/health_speciality_cubit.dart';
import 'package:zanadu/features/health_coach/logic/cubit/recommended_offering_cubit/recommended_offering_cubit.dart';
import 'package:zanadu/features/health_coach/widgets/change_coach_dialog.dart';
import 'package:zanadu/features/health_coach/widgets/selected_health_coach_container.dart';
import 'package:zanadu/features/home/widgets/health_coach_container.dart';
import 'package:zanadu/features/home/widgets/speciality_coach_container.dart';
import 'package:zanadu/features/offerings/data/models/current_selected_coach_model.dart';
import 'package:zanadu/widgets/free_trial_dialog.dart';

class HealthCoachScreen extends StatefulWidget {
  const HealthCoachScreen({Key? key}) : super(key: key);

  @override
  State<HealthCoachScreen> createState() => _HealthCoachScreenState();
}

class _HealthCoachScreenState extends State<HealthCoachScreen> {
  String selectedLanguage = 'Lack of progress';
  // Default selected language
  List<CurrentSelectedCoachModel> specialCoaches = [];
  void showChangeCoachReasonDialog(
      BuildContext context, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) {
        return ChangeCoachReasonDialog(
          onpressed: onPressed,
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

  late RecommendedOfferingCubit recommendedOfferingCubit;

  @override
  void initState() {
    super.initState();
    recommendedOfferingCubit =
        BlocProvider.of<RecommendedOfferingCubit>(context);
    // Assuming you have the offering ID, replace 'yourOfferingId' with the actual offering ID
  }

  Future<void> _onPressedHandler(
      String coachId, BuildContext context, String offeringId) async {
    await context
        .read<HealthSpecialityCoachCubit>()
        .selectOrDeselectCoachAndUpdateState(coachId, false, offeringId);
    // ignore: use_build_context_synchronously
    await context.read<HealthSpecialityCoachCubit>().refreshData();
    setState(() {});
    // ignore: use_build_context_synchronously
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Health",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "Coach",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<HealthSpecialityCoachCubit, HealthSpecialityCoachState>(
              builder: (context, state) {
                if (state is HealthSpecialityCoachLoadedState) {
                  specialCoaches = state.coaches;
                }
                if (state is HealthSpecialityCoachLoadingState) {
                  return const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator.adaptive());
                } else if (state is NHealthSpecialityCoachLoadedState) {
                  if (state.healthCoach.isNotEmpty) {
                    recommendedOfferingCubit.fetchRecommendedOfferings(
                      myUser?.userInfo?.userId ?? "",
                      state.healthCoach[0].coachId ?? "",
                    );
                  } else {
                    recommendedOfferingCubit.clearRecommendedOfferings();
                  }
                  if (state.healthCoach.isNotEmpty) {
                    var data = state.healthCoach[0];

                    return Padding(
                      padding:
                          EdgeInsets.only(left: 28.w, right: 28.w, bottom: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          // Routes.goTo(Screens.healthBrowseNewAddToPlan,
                          //     arguments: data);
                        },
                        child: SelectedHealthCoachContainer(
                          imgUrl: data.coachProfile?.profile?.image,
                          experienceYear:
                              data.coachProfile?.profile?.experience ?? "",
                          likes: data.coachInfo?.likes ?? "",
                          name: data.coachProfile?.profile?.fullName ?? "",
                          rating: data.coachInfo?.rating ?? "0",
                          onpressed: () {
                            simpleDialog(
                                context,
                                "Are You Sure?",
                                "Want to change your Health Coach",
                                "Yes",
                                "Cancel", () {
                              Navigator.of(context).pop();
                              showChangeCoachReasonDialog(context, () {
                                Routes.goBack();
                                _onPressedHandler(
                                    state.healthCoach[0].coachId ?? "",
                                    context,
                                    state.healthCoach[0].offeringId ?? "");
                              });
                            });
                          },
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 10.h,
                    );
                  }
                } else if (state is HealthSpecialityCoachErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return const Text('Something is wrong');
                }
              },
            ),
            TabBar(
              indicatorColor: AppColors.primaryGreen,
              overlayColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              automaticIndicatorColorAdjustment: false,
              splashFactory: NoSplash.splashFactory,
              labelColor: AppColors.textDark,
              labelStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
              unselectedLabelColor: AppColors.greyLight,
              indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 8,
              ), // Adjust padding here
              tabs: const [
                Tab(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("Browse Coaches"),
                  ),
                ),
                Tab(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("Recommended Plan"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 28.w, right: 28.w, top: 16.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<AllHealthCoachCubit, AllHealthCoachState>(
                            builder: (context, state) {
                              if (state is AllHealthCoachLoadingState) {
                                return Container(
                                    width: 40,
                                    height: 40,
                                    child: const CircularProgressIndicator
                                        .adaptive());
                              } else if (state is AllHealthCoachLoadedState) {
                                return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.healthCoach.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var data = state.healthCoach[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 28.h),
                                        child: GestureDetector(
                                          onTap: () {
                                            Routes.goTo(
                                                Screens.healthCoachDetail,
                                                arguments: data);
                                          },
                                          child: BigHealthCoachContainer(
                                              isSpeciality: false,
                                              imgUrl: data.profile?.image,
                                              likeCount:
                                                  data.coachInfo?.likes ?? "",
                                              liveSession:
                                                  data.countSessions ?? 0,
                                              name:
                                                  data.profile?.fullName ?? "",
                                              rating: data.coachInfo?.rating ==
                                                      null
                                                  ? "0"
                                                  : data.coachInfo!.rating
                                                      .toString()),
                                        ),
                                      );
                                    });
                              } else if (state is AllHealthCoachErrorState) {
                                return Text('Error: ${state.error}');
                              } else {
                                return const Text('Something is wrong');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<RecommendedOfferingCubit,
                      RecommendedOfferingState>(
                    builder: (context, state) {
                      if (state is RecommendedOfferingLoadingState) {
                        return const Center(
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator.adaptive()),
                        );
                      } else if (state is RecommendedOfferingLoadedState) {
                        if (state.recommendedOffering.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 28.w, vertical: 12.h),
                            child: Container(
                              alignment: Alignment.center,
                              child: simpleText(
                                "Select a Health Coach who can recommend a customized plan for you.",
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                align: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.recommendedOffering.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              CurrentSelectedCoachModel? oneSpecialCoach;

                              var data = state.recommendedOffering[index];
                              bool isSpecialityOffering = specialCoaches.any(
                                (specialCoach) =>
                                    specialCoach.offeringsName ==
                                    state.recommendedOffering[index].offerTitle,
                              );
                              if (isSpecialityOffering) {
                                oneSpecialCoach = specialCoaches.firstWhere(
                                  (specialCoach) =>
                                      specialCoach.offeringsName ==
                                      data.offerTitle,
                                );
                              }
                              return !isSpecialityOffering
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 28.w, vertical: 12.h),
                                      child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(
                                              Screens.browseOfferingDetail,
                                              arguments: data.offeringId);
                                        },
                                        child: SpecialityCoachContainer(
                                          imgUrl: data.offerIcon,
                                          svg: "assets/images/Group (7).svg",
                                          text1: data.offerTitle ?? "",
                                          text2: data.offerSubtitle ?? "",
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 28.w, vertical: 12.h),
                                      child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(
                                              Screens.healthBrowseNewAddToPlan,
                                              arguments: oneSpecialCoach);
                                        },
                                        child: BigHealthCoachContainer(
                                          isSpeciality: false,
                                          imgUrl: oneSpecialCoach
                                              ?.coachProfile?.profile?.image,
                                          likeCount: oneSpecialCoach
                                                  ?.coachInfo?.likes ??
                                              "",
                                          liveSession:
                                              oneSpecialCoach?.countSessions ??
                                                  0,
                                          name: oneSpecialCoach?.coachProfile
                                                  ?.profile?.fullName ??
                                              "",
                                          rating: oneSpecialCoach
                                                  ?.coachInfo?.rating ??
                                              "0",
                                        ),
                                      ),
                                    );
                            });
                      } else if (state is RecommendedOfferingErrorState) {
                        return Text('Error: ${state.error}');
                      } else {
                        return const Text('Something is wrong');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
