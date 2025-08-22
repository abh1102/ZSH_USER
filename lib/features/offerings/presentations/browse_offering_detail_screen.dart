import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/home/widgets/health_coach_container.dart';
import 'package:zanadu/features/offerings/logic/cubit/offering_id/offering_id_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';

class BrowseOfferingDetailScreen extends StatefulWidget {
  final String id;
  const BrowseOfferingDetailScreen({super.key, required this.id});

  @override
  State<BrowseOfferingDetailScreen> createState() =>
      _BrowseOfferingDetailScreenState();
}

class _BrowseOfferingDetailScreenState
    extends State<BrowseOfferingDetailScreen> {
  late OfferingIdCubit offeringIdCubit;

  @override
  void initState() {
    super.initState();
    offeringIdCubit = BlocProvider.of<OfferingIdCubit>(context);

    // Assuming you have the offering ID, replace 'yourOfferingId' with the actual offering ID
    offeringIdCubit.fetchOfferingId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Specialty", secondText: "Gurus"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 28.w),
            child: BlocBuilder<OfferingIdCubit, OfferingIdState>(
              builder: (context, state) {
                if (state is OfferingIdLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (state is OfferingIdLoadedState) {
                  // Access the loaded plan from the state

                  if (state.offering.isEmpty) {
                    return Column(
                      children: [
                        Center(
                          child: simpleText(
                              "There is no Coaches in this Offering"),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var data = state.offering[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 28.h),
                        child: GestureDetector(
                          onTap: () {
                            Routes.goTo(Screens.browseOfferingNew, arguments: {
                              'healthCoach': data,
                              'isFetch': state.isFetch,
                              'category': state.category
                            });
                          },
                          child: BigHealthCoachContainer(
                            isSpeciality: false,
                            imgUrl: data.profile?.image,
                            likeCount: data.coachInfo?.likes == null
                                ? "0"
                                : data.coachInfo?.likes.toString() ?? "0",
                            liveSession: data.countSessions ?? 0,
                            name: data.profile?.fullName ?? "",
                            rating: data.coachInfo?.rating == null
                                ? "0"
                                : data.coachInfo?.rating.toString() ?? "0",
                          ),
                        ),
                      );
                    },
                    itemCount: state.offering.length,
                    shrinkWrap: true,
                  );
                } else if (state is OfferingIdErrorState) {
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
}
