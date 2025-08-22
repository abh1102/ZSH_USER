import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/logic/cubit/special_question_cubit/special_question_cubit.dart';
import 'package:zanadu/features/health_coach/logic/provider/special_provider.dart';
import 'package:zanadu/features/offerings/logic/cubit/add_to_plan/add_to_plan_cubit.dart';
import 'package:zanadu/features/profile/presentations/edit_profile_screen.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class SpecialDiscoveryFormReviewScreen extends StatefulWidget {
  final String coachId;
  final String offeringId;
  final String category;
  const SpecialDiscoveryFormReviewScreen({
    super.key,
    required this.coachId,
    required this.offeringId, required this.category,
  });

  @override
  State<SpecialDiscoveryFormReviewScreen> createState() =>
      _SpecialDiscoveryFormReviewScreenState();
}

class _SpecialDiscoveryFormReviewScreenState
    extends State<SpecialDiscoveryFormReviewScreen> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final tabIndexProvider = Provider.of<TabIndexProvider>(context);

    final questionProvider = Provider.of<SpecialQuestionProvider>(context);
    return BlocListener<SpecialQuestionCubit, SpecialQuestionState>(
        listener: (context, state) {
          if (state is SpecialQuestionLoadingState) {
            showLoadingIndicator(context);
          }
          if (state is SpecialAnswerSubmittedState) {
            // Handle the updated user state
            // You can also add additional logic or UI updates here

            BlocProvider.of<AddToPlanCubit>(context)
                .selectOrDeselectCoachAndUpdateState(
                    widget.coachId, true, widget.offeringId);

            Routes.closeAllAndGoTo(Screens.homeBottomBar);

            questionProvider.clear();

            // showGreenSnackBar(state.message);
          } else if (state is SpecialQuestionErrorState) {
            Routes.closeAllAndGoTo(Screens.homeBottomBar);
            questionProvider.clear();
            // showSnackBar(state.error);
          }
        },
        child: Scaffold(
            appBar:  AppBarWithBackButtonWOSilver(
              firstText: "${widget.category} Intake",
              secondText: "Form",
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 28.h,
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: questionProvider.allQuestions.length,
                      itemBuilder: (context, index) {
                        if (index < questionProvider.allAnswers.length) {
                          final answer = questionProvider.allAnswers[index];
                          final question = questionProvider.allQuestions
                              .firstWhere((q) => q.sId == answer.questionId);
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: ReviewAnswerContainer(
                              question: question.questions ?? "",
                              answer: questionProvider.allAnswers[index].answer,
                              number: index + 1,
                            ),
                          );
                        } else {
                          return const SizedBox(); // Return an empty container if index is out of bounds
                        }
                      },
                    ),
                    height(16),
                    ColoredButton(
                      onpressed: () {
                        context
                            .read<SpecialQuestionCubit>()
                            .submitHealthIntakeAnswers(
                              questionProvider.allAnswers,
                            );
                      },
                      text: "Submit",
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    height(28),
                  ],
                ),
              ),
            )));
  }
}

class ReviewAnswerContainer extends StatelessWidget {
  final String question;
  final List<String> answer;
  final int number;
  const ReviewAnswerContainer({
    super.key,
    required this.question,
    required this.answer,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 19.w,
      ),
      decoration: BoxDecoration(
        gradient: Insets.fixedGradient(opacity: 0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child:
          ReviewAnswerRow(number: number, question: question, answers: answer),
    );
  }
}

class ReviewAnswerRow extends StatelessWidget {
  final String question;
  final List<String> answers;
  final int number;

  const ReviewAnswerRow({
    Key? key,
    required this.number,
    required this.question,
    required this.answers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.2), // Adjust as needed
        1: FlexColumnWidth(0.9), // Adjust as needed
      },
      children: [
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: body1Text(
                "Q.$number",
                color: AppColors.textDark,
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: body1Text(
                  question,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: simpleText(
                "Ans-",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, top: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: answers
                      .map((answer) => simpleText(
                            answer,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
