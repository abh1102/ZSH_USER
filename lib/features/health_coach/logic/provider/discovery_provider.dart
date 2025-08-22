import 'package:flutter/material.dart';
import 'package:zanadu/features/health_coach/data/model/answer_model.dart';
import 'package:zanadu/features/health_coach/data/model/question_model.dart';

class QuestionProvider extends ChangeNotifier {
  List<Questions> allQuestions = [];

List<Answer> allAnswers = [];

  void addAnswer(Answer answer) {
    allAnswers.add(answer);
    notifyListeners();
  }


   bool isQuestionAnswered(String questionId) {
    // Check if there is an answer for the given questionId
    return allAnswers.any((answer) => answer.questionId == questionId);
  }



}
