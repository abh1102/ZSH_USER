import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/health_coach/logic/cubit/question_cubit/question_cubit.dart';
import 'package:zanadu/features/health_coach/logic/provider/discovery_provider.dart';
import 'package:zanadu/features/health_coach/presentations/first_form.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class QuestionInformScreen extends StatefulWidget {
  const QuestionInformScreen({
    super.key,
  });

  @override
  State<QuestionInformScreen> createState() => _QuestionInformScreenState();
}

class _QuestionInformScreenState extends State<QuestionInformScreen> {


  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    return Scaffold(
      appBar: const AppBarWithoutBackButtonWithAction(
          firstText: "Health Intake", secondText: " Form"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<QuestionCubit, QuestionState>(
            builder: (context, state) {
              if (state is QuestionLoadingState) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is QuestionLoadedState) {
                // Access the loaded plan from the state
                questionProvider.allQuestions = state.questions;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: simpleText(
                        "Please answer the following questions using the drop down menu and a scale of 1-10 (1 being low, 5 medium and 10 high). The Health Coach (HC) will go over these with you and have a deeper dive during the One-on-One Discovery Session.",
                        align: TextAlign.center,
                      ),
                    ),
                    height(40),
                    Center(
                      child: ColoredButtonWithoutHW(
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FirstDiscoveryForm(
                                        questionIndex: 0,
                                      )));
                        },
                        text: "Start Answering",
                        size: 18,
                        weight: FontWeight.w500,
                        verticalPadding: 14,
                      ),
                    )
                  ],
                );
              } else if (state is QuestionErrorState) {
                return Text('Error: ${state.error}');
              } else {
                return const Text('Something is wrong');
              }
            },
          ),
        ),
      ),
    );
  }
}
