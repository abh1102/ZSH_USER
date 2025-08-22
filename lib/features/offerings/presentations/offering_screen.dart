import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/home/widgets/health_coach_container.dart';
import 'package:zanadu/features/home/widgets/speciality_coach_container.dart';
import 'package:zanadu/features/offerings/logic/cubit/customized_cubit/customized_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/offering/offering_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/speciality_cubit/speciality_cubit.dart';
import 'package:zanadu/features/offerings/widgets/customized_plan_container.dart';

class OfferingScreen extends StatefulWidget {
  const OfferingScreen({Key? key}) : super(key: key);

  @override
  State<OfferingScreen> createState() => _OfferingScreenState();
}

class _OfferingScreenState extends State<OfferingScreen> {
  @override
  Widget build(BuildContext context) {
    // final offerProvider = Provider.of<OfferingProvider>(context);
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
                "Offering",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "Plan",
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
            BlocBuilder<CustomizedOfferingCubit, CustomizedOfferingState>(
              builder: (context, state) {
                if (state is CustomizedOfferingLoadingState) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state is CustomizedOfferingLoadedState) {
                  // Access the loaded plan from the state
                  if (state.customizedOffering.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: CustomizedPlanContainer(
                        offering: state.customizedOffering,
                      ),
                    );
                  }
                } else if (state is CustomizedOfferingErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return const Text('Something is wrong');
                }
              },
            ),
            TabBar(
              indicatorColor: AppColors.primaryGreen,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                  horizontal: 8), // Adjust padding here
              tabs: const [
                Tab(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("Browse Offerings"),
                  ),
                ),
                Tab(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("Specialty Coaches"),
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
                          BlocBuilder<AllOfferingCubit, AllOfferingState>(
                            builder: (context, state) {
                              if (state is AllOfferingLoadingState) {
                                return const SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator.adaptive(),
                                );
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
                                          padding:
                                              EdgeInsets.only(bottom: 28.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              Routes.goTo(
                                                  Screens.browseOfferingDetail,
                                                  arguments: data.sId);
                                            },
                                            child: SpecialityCoachContainer(
                                              imgUrl: data.icon,
                                              svg:
                                                  "assets/images/Group (7).svg",
                                              text1: data.title.toString(),
                                              text2: data.subTitle.toString(),
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Return an empty container for offerings with the name "health"
                                        return Container();
                                      }
                                    });
                              } else if (state is AllOfferingErrorState) {
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
                  BlocBuilder<SpecialityCoachCubit, SpecialityCoachState>(
                    builder: (context, state) {
                      if (state is SpecialityCoachLoadingState) {
                        return const Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator.adaptive()),
                        );
                      } else if (state is SpecialityCoachLoadedState) {
                        // Access the loaded plan from the state
                        if (state.coaches.isEmpty) {
                          return Center(
                            child: Container(
                              alignment: Alignment.center,
                              child: simpleText(
                                "Add Specialty Coaches From Offerings",
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.coaches.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = state.coaches[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 28.w, vertical: 12.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        Routes.goTo(
                                            Screens.healthBrowseNewAddToPlan,
                                            arguments: data);
                                      },
                                      child: BigHealthCoachContainer(
                                        imgUrl:
                                            data.coachProfile?.profile?.image,
                                        isSpeciality: true,
                                        likeCount: data.offeringsName ?? "",
                                        liveSession: data.countSessions ?? 0,
                                        name: data.coachProfile?.profile
                                                ?.fullName ??
                                            "",
                                        rating: data.coachInfo?.rating == null
                                            ? "0"
                                            : data.coachInfo!.rating.toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (state is SpecialityCoachErrorState) {
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
