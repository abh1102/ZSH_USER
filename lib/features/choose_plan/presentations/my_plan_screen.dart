import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/choose_plan/logic/cubit/my_plan_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_dialog.dart';

class MyPlanScreen extends StatefulWidget {
  const MyPlanScreen({super.key});

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Enterprise", secondText: "Plan"),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 28.h,
              horizontal: 28.w,
            ),
            child: BlocBuilder<MyPlanCubit, MyPlanState>(
              builder: (context, state) {
                if (state is MyPlanLoadingState) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state is MyPlanLoadedState) {
                  // Access the loaded plan from the state

                  if (state.plan?.active == false) {
                    return Center(
                      child: Container(
                          alignment: Alignment.center,
                          width: 350.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF25D366),
                                Color(0xFF03C0FF),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: simpleText(
                              "There is no active plan please contact enterprise",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              align: TextAlign.center,
                              color: Colors.white,
                            ),
                          )),
                    );
                  }
                  return MyPlanDetailContainer(
                    planName: state.plan?.plan!.name ?? "",
                    features: state.plan?.plan!.price!.features ?? [],
                  );
                } else if (state is MyPlanErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return const Text('Something is wrong');
                }
              },
            ),
          ),
        ),
      )),
    );
  }
}

class MyPlanDetailContainer extends StatelessWidget {
  final String planName;
  final List<String> features;
  const MyPlanDetailContainer({
    super.key,
    required this.planName,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF25D366),
            Color(0xFF03C0FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 36.h,
          left: 18.w,
          right: 18.w,
          top: 18.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button (SVG picture)

            heading1Text(planName, color: Colors.white),

            height(20),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            height(20),

            for (var i = 0; i < features.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(6),
                  CheckIconTextRow(
                    text: features[i],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
