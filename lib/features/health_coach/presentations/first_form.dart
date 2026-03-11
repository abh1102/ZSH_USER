import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/data/model/answer_model.dart';
import 'package:zanadu/features/health_coach/logic/provider/discovery_provider.dart';
import 'package:zanadu/utils/bmi_utils.dart';
import 'package:zanadu/features/health_coach/widgets/update_progress.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class FirstDiscoveryForm extends StatefulWidget {
  final int questionIndex;

  const FirstDiscoveryForm({
    super.key,
    required this.questionIndex,
  });

  @override
  State<FirstDiscoveryForm> createState() => _FirstDiscoveryFormState();
}

class _FirstDiscoveryFormState extends State<FirstDiscoveryForm> {
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
  
  Widget _buildBMICalculator(QuestionProvider questionProvider) {
    // Calculate BMI from existing answers
    final healthMetrics = BMIUtils.findHealthMetrics(questionProvider.allAnswers);
    final weight = healthMetrics['weight'];
    final height = healthMetrics['height'];
    
    // Debug print to see what values are being extracted
    print('BMI Debug - Weight: $weight, Height: $height');
    print('BMI Debug - All answers count: ${questionProvider.allAnswers.length}');
    for (var answer in questionProvider.allAnswers) {
      if (answer is Answer) {
        print('BMI Debug - Question: "${answer.questionName}", Answer: ${answer.answer}');
      }
    }
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 19.w,
      ),
      decoration: BoxDecoration(
        gradient: Insets.fixedGradient(opacity: 0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.primaryGreen,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.fitness_center,
                color: AppColors.primaryGreen,
                size: 24.w,
              ),
              width(12),
              heading2Text(
                'BMI Calculator',
                color: AppColors.primaryGreen,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (weight != null && height != null) ...[
            // Show BMI calculation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    simpleText(
                      'Weight: ${weight}kg',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    simpleText(
                      'Height: ${height}cm',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: 8.h),
                    simpleText(
                      'Your BMI',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                    SizedBox(height: 4.h),
                    heading2Text(
                      BMIUtils.formatBMI(BMIUtils.calculateBMI(weight, height)),
                      color: AppColors.textDark,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    simpleText(
                      'Category',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                    SizedBox(height: 4.h),
                    heading2Text(
                      BMIUtils.getBMICategory(BMIUtils.calculateBMI(weight, height)),
                      color: _getCategoryColor(BMIUtils.getBMICategory(BMIUtils.calculateBMI(weight, height))),
                    ),
                  ],
                ),
              ],
            ),
          ] else ...[
            // Show missing data message
            simpleText(
              'BMI calculation requires weight and height data.',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
            SizedBox(height: 8.h),
            simpleText(
              'Please make sure you have answered the weight and height questions in the form.',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ],
        ],
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal weight':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return AppColors.textDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    final question = questionProvider.allQuestions[widget.questionIndex];

    int myNum = widget.questionIndex + 1;
    return Scaffold(
      appBar: HealthCoachAppBar(
        canGoBack: myNum == 1 ? false : true,
        firstText: "Health Intake",
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
                    onChanged: (value) {},
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
                // Show BMI Calculator on the last form (34th question)
                if (widget.questionIndex == questionProvider.allQuestions.length - 1) ...[
                  _buildBMICalculator(questionProvider),
                  height(28),
                ],
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
                        Answer newAnswer;

                        // Check the question type and create the Answer model
                        if (question.qusType == "INPUT_STRING") {
                          // For input string type question
                          newAnswer = Answer(
                            questionId: question.sId!,
                            questionName: question.questions!,
                            answer: [controller.text],
                            score: 0,
                            // Calculate the score based on the answer,
                          );
                        } else if (question.qusType == "SCALING") {
                          // For scaling type question

                          // Get the current progress value
                          newAnswer = Answer(
                            questionId: question.sId!,
                            questionName: question.questions!,
                            answer: [myProgress.toString()],
                            score: 0,
                            // Calculate the score based on the progress,
                          );
                        } else {
                          // For other types of questions
                          newAnswer = Answer(
                            questionId: question.sId!,
                            questionName: question.questions!,
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

                        controller.clear();
                        selectedAnswers = [];
                      });
                      await Future.delayed(Duration.zero);
                      // Navigate to the next question or review screen

                      if (widget.questionIndex + 1 <
                          questionProvider.allQuestions.length) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FirstDiscoveryForm(
                            questionIndex: widget.questionIndex + 1,
                          );
                        }));
                      } else {
                        // ignore: use_build_context_synchronously
                        Routes.goTo(
                          Screens.reviewScreen,
                        );
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
