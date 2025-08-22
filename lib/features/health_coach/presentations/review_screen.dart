import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/logic/cubit/question_cubit/question_cubit.dart';
import 'package:zanadu/features/health_coach/logic/provider/discovery_provider.dart';
//import 'package:zanadu/features/home/logic/provider/home_bottom_provider.dart';
import 'package:zanadu/features/profile/presentations/edit_profile_screen.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/all_dialog.dart';

class DiscoveryFormReviewScreen extends StatefulWidget {
  const DiscoveryFormReviewScreen({
    super.key,
  });

  @override
  State<DiscoveryFormReviewScreen> createState() =>
      _DiscoveryFormReviewScreenState();
}

class _DiscoveryFormReviewScreenState extends State<DiscoveryFormReviewScreen> {
  @override
  Widget build(BuildContext context) {
    // final tabIndexProvider = Provider.of<TabIndexProvider>(context);

    final questionProvider = Provider.of<QuestionProvider>(context);
    return BlocListener<QuestionCubit, QuestionState>(
        listener: (context, state) {
          if (state is QuestionLoadingState) {
            showLoadingIndicator(context);
          }
          if (state is AnswerSubmittedState) {
            // Handle the updated user state
            // You can also add additional logic or UI updates here
            Navigator.of(context).pop();

            discoveryFormDialog(
                context,
                "assets/icons/Group 1171275112.svg",
                "Thank you!",
                "Your Discovery form has been submitted to the Health Coach. They'll reach out to you within 24 hours to schedule a Discovery Session",
                66,
                66);

            Routes.closeAllAndGoTo(Screens.homeBottomBar);
          } else if (state is QuestionErrorState) {
            // Handle error state
            Navigator.of(context).pop();
            showSnackBar(state.error);

            Routes.closeAllAndGoTo(Screens.login);
          }
        },
        child: Scaffold(
            appBar: const AppBarWithBackButtonWOSilver(
              firstText: "Health Intake",
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
                        context.read<QuestionCubit>().submitHealthIntakeAnswers(
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
