import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/logic/cubits/get_all_health_cubit/get_health_cubit.dart';
import 'package:zanadu/features/profile/logic/cubits/health_chart_cubit/health_chart_cubit.dart';
import 'package:zanadu/features/profile/widgets/custom_circular_bar.dart';
import 'package:zanadu/features/profile/widgets/health_score_chart.dart';
import 'package:zanadu/features/profile/widgets/progress_indicator_container.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/image_widget.dart';

class MyZhScoreCardScreen extends StatefulWidget {
  final bool isAppBar;

  const MyZhScoreCardScreen({
    super.key,
    required this.isAppBar,
  });

  @override
  State<MyZhScoreCardScreen> createState() => _MyZhScoreCardScreenState();
}

class _MyZhScoreCardScreenState extends State<MyZhScoreCardScreen> {
  late GetHealthCubit getHealthCubit;
  @override
  void initState() {
    super.initState();

    getHealthCubit = BlocProvider.of<GetHealthCubit>(context);

    getHealthCubit.fetchGetHealth(myUser?.userInfo?.userId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBar
          ? AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ZH",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textDark,
                    ),
                  ),
                  width(4),
                  Text(
                    "Health Score",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            )
          : const AppBarWithBackButtonWOSilver(
              firstText: "ZH", secondText: "Health Score"),
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryGreen,
                      width: 1.5,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CustomImageWidget(
                        url: myUser?.userInfo?.profile?.image ?? defaultAvatar,
                        myradius: 0,
                        mywidth: 371.w,
                        myheight: 200.h,
                      ),
                    )),
              ),
              height(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        simpleText(
                          myUser?.userInfo?.profile?.fullName ?? "",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                        height(8),
                        body1Text(
                          "My Health Score",
                          color: AppColors.greyDark,
                        ),
                      ],
                    ),
                  ),
                  CustomCircularProgressBar(
                    value:
                        double.tryParse(myUser?.finalScore.toString() ?? "") ??
                            0,
                  )
                ],
              ),
              height(30),
              BlocBuilder<GetHealthCubit, GetHealthState>(
                builder: (context, state) {
                  if (state is GetHealthLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is GetHealthLoadedState) {
                    // Access the loaded plan from the state
                    var score = state.health.healthScore;

                    return Column(
                      children: [
                        ProgressIndicatorContainer(
                          text: 'Physical Health',
                          maxProgress: 10,
                          progress: score?.physicalHealth != null
                              ? score?.physicalHealth ?? 0
                              : 0,
                        ),
                        height(28),
                        ProgressIndicatorContainer(
                          text: 'Mental Health',
                          maxProgress: 10,
                          progress: score?.mentalHealth != null
                              ? score?.mentalHealth ?? 0
                              : 0,
                        ),
                        height(28),
                        ProgressIndicatorContainer(
                          text: 'Energy',
                          maxProgress: 10,
                          progress:
                              score?.energy != null ? score?.energy ?? 0 : 0,
                        ),
                        height(28),
                        ProgressIndicatorContainer(
                          text: 'Nutrition',
                          maxProgress: 10,
                          progress: score?.nutrition != null
                              ? score?.nutrition ?? 0
                              : 0,
                        ),
                        height(28),
                        ProgressIndicatorContainer(
                          text: 'General Health',
                          maxProgress: 10,
                          progress: score?.generalHealth != null
                              ? score?.generalHealth ?? 0
                              : 0,
                        ),
                      ],
                    );
                  } else if (state is GetHealthErrorState) {
                    return Text('Error: ${state.error}');
                  } else {
                    return const Text('Something is wrong');
                  }
                },
              ),
              height(28),
              BlocProvider(
                  create: (context) => HealthChartCubit(),
                  child: HealthScoreChart())
            ],
          ),
        ),
      )),
    );
  }
}
