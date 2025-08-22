import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/data/model/answer_model.dart';
import 'package:zanadu/features/health_coach/logic/provider/special_provider.dart';
import 'package:zanadu/features/health_coach/widgets/update_progress.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class SpecialFirstDiscoveryForm extends StatefulWidget {
  final int questionIndex;
  final String category;
  final String coachId;
  final String offeringId;

  const SpecialFirstDiscoveryForm({
    super.key,
    required this.questionIndex,
    required this.category,
    required this.coachId,
    required this.offeringId,
  });

  @override
  State<SpecialFirstDiscoveryForm> createState() =>
      _SpecialFirstDiscoveryFormState();
}

class _SpecialFirstDiscoveryFormState extends State<SpecialFirstDiscoveryForm> {
  List<String> selectedAnswers = [];
  TextEditingController controller = TextEditingController();
  int myProgress = 0;

  @override
  void dispose() {
    // Clean up resources, like controllers
    controller.dispose();

    // Call the dispose method of the superclass
    super.dispose();
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
    final question = questionProvider.allQuestions[widget.questionIndex];

    int myNum = widget.questionIndex + 1;
    return Scaffold(
      appBar: HealthCoachAppBar(
        canGoBack: myNum == 1 ? false : true,
        firstText: "$heading Intake",
        secondText: "Form",
      ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LinearProgressIndicator(
                    minHeight: 15,
                    value: myNum / questionProvider.allQuestions.length,
                    backgroundColor: const Color(0xFFEEEEEE),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                height(28),
                heading2Text(
                  question.questions ?? "",
                  textAlign: TextAlign.start,
                  color: AppColors.textDark,
                ),
                height(33),
                if (question.qusType == "INPUT_STRING") ...[
                  // Show input field
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Type your answer here",
                    ),
                  ),
                ] else if (question.qusType == "SCALING") ...[
                  // Show linear progress bar
                  UpdateProgressIndicatorContainer(
                    onProgressChanged: (progress) {
                      // Do something with the progress if needed
                      setState(() {
                        myProgress = progress;
                      });
                    },
                    maxProgress: 10,
                    text: "Your Answer",
                  ),
                ] else ...[
                  // Show radio buttons for other question types

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: question.options!.map((answer) {
                      return CheckboxListTile(
                        title: simpleText(
                          answer,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                        value: selectedAnswers.contains(answer),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              if (value) {
                                // Check if the selected answers count is less than the maximumAnwserSelect limit
                                if (selectedAnswers.length <
                                        num.parse(question.maximumAnwserSelect
                                            .toString())
                                    // question.maximumAnwserSelect!
                                    ) {
                                  selectedAnswers.add(answer);
                                } else {
                                  // Optionally show a message or handle when the user exceeds the maximum selection
                                }
                              } else {
                                selectedAnswers.remove(answer);
                              }

                              (selectedAnswers) {
                                print('Selected Answers: $selectedAnswers');
                              };
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
                height(52),
                Center(
                  child: heading2Text(
                      "${widget.questionIndex + 1}/${questionProvider.allQuestions.length}"),
                ),
                height(28),
                Center(
                  child: ColoredButtonWithoutHW(
                    onpressed: () async {
                      // Check if the current question has already been answered
                      if (!questionProvider.isQuestionAnswered(question.sId!)) {
                        SpecialAnswer newAnswer;

                        // Check the question type and create the Answer model
                        if (question.qusType == "INPUT_STRING") {
                          // For input string type question
                          newAnswer = SpecialAnswer(
                            category: widget.category,
                            questionId: question.sId!,
                            questionName: question.questions!,
                            answer: [controller.text],
                            score: 0,
                            // Calculate the score based on the answer,
                          );
                        } else if (question.qusType == "SCALING") {
                          // For scaling type question

                          // Get the current progress value
                          newAnswer = SpecialAnswer(
                            category: widget.category,
                            questionId: question.sId!,
                            questionName: question.questions!,
                            answer: [myProgress.toString()],
                            score: 0,
                            // Calculate the score based on the progress,
                          );
                        } else {
                          // For other types of questions
                          newAnswer = SpecialAnswer(
                            questionId: question.sId!,
                            questionName: question.questions!,
                            category: widget.category,
                            answer: selectedAnswers,
                            score: 0,
                            // Calculate the score based on the selected answers,
                          );
                        }

                        // Add the new answer to the provider
                        questionProvider.addAnswer(newAnswer);
                      }
                      setState(() {
                        myProgress = 0;

                        selectedAnswers = [];
                      });
                      controller.clear();
                      await Future.delayed(Duration.zero);
                      // Navigate to the next question or review screen

                      if (widget.questionIndex + 1 <
                          questionProvider.allQuestions.length) {
                        // ignore: use_build_context_synchronously

                        Routes.goTo(Screens.specialFirstDiscoveryForm,
                            arguments: {
                              'questionIndex': widget.questionIndex + 1,
                              'category': widget.category,
                              'coachId': widget.coachId,
                              'offeringId': widget.offeringId
                            });
                      } else {
                        // ignore: use_build_context_synchronously
                        Routes.goTo(Screens.specialReviewScreen, arguments: {
                          'coachId': widget.coachId,
                          'offeringId': widget.offeringId,
                          'category': heading
                        });
                      }
                    },
                    text: widget.questionIndex ==
                            questionProvider.allQuestions.length - 1
                        ? "Review"
                        : "Continue",
                    size: 16,
                    weight: FontWeight.w600,
                    verticalPadding: 14,
                  ),
                ),
                height(16),
                widget.questionIndex != 0
                    ? Center(
                        child: SimpleWhiteTextButton(
                          onpressed: () {
                            Navigator.of(context).pop();
                          },
                          text: "Back",
                          size: 16,
                          weight: FontWeight.w600,
                          verticalPadding: 14,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      //),
    );
  }
}
