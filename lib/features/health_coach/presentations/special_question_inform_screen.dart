import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/logic/cubit/special_question_cubit/special_question_cubit.dart';
import 'package:zanadu/features/health_coach/logic/provider/special_provider.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class SpecialQuestionInformScreen extends StatefulWidget {
  final String category;
  final String coachId;
  final String offeringId;

  const SpecialQuestionInformScreen({
    Key? key,
    required this.category,
    required this.coachId,
    required this.offeringId,
  }) : super(key: key);

  @override
  State<SpecialQuestionInformScreen> createState() =>
      _SpecialQuestionInformScreenState();
}

class _SpecialQuestionInformScreenState
    extends State<SpecialQuestionInformScreen> {
  late SpecialQuestionCubit specialQuestionCubit;

  @override
  void initState() {
    super.initState();
    specialQuestionCubit = BlocProvider.of<SpecialQuestionCubit>(context);
    specialQuestionCubit.fetchSpecialIntakeQuestions(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    String heading = "";

    if (widget.category == "ENERGY_SPECIAL") {
      heading = "Energy";
    } else if (widget.category == "NUTRITION_SPECIAL") {
      heading = "Nutrition";
    } else {
      heading = "Mindset";
    }
    final questionProvider = Provider.of<SpecialQuestionProvider>(context);
    return Scaffold(
      appBar: AppBarWithoutBackButtonWithAction(
        firstText: "$heading Intake",
        secondText: " Form",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<SpecialQuestionCubit, SpecialQuestionState>(
            listener: (context, state) {
              if (state is SpecialQuestionErrorState) {}
            },
            builder: (context, state) {
              if (state is SpecialQuestionLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is SpecialQuestionLoadedState) {
                // questionProvider.clear();

                questionProvider.allQuestions = state.specialquestions;

                // Continue building the UI
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: simpleText(
                        "Please answer the following questions using the drop-down menu and a scale of 1-10 (1 being low, 5 medium, and 10 high). The Speciality Coach (HC) will go over these with you and have a deeper dive during the One-on-One Discovery Session.",
                        align: TextAlign.center,
                      ),
                    ),
                    height(40),
                    Center(
                      child: ColoredButtonWithoutHW(
                        onpressed: () {
                          Routes.goTo(Screens.specialFirstDiscoveryForm,
                              arguments: {
                                'questionIndex': 0,
                                'category': widget.category,
                                'coachId': widget.coachId,
                                'offeringId': widget.offeringId
                              });
                        },
                        text: "Start Answering",
                        size: 18,
                        weight: FontWeight.w500,
                        verticalPadding: 14,
                      ),
                    )
                  ],
                );
              } else if (state is SpecialQuestionErrorState) {
                return Center(
                  child: simpleText(state.error),
                );
              } else {
                return Container(); // Placeholder for other states if needed
              }
            },
          ),
        ),
      ),
    );
  }
}
