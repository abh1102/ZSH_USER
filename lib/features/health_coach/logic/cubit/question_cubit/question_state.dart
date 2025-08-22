part of 'question_cubit.dart';

abstract class QuestionState {}

class QuestionInitialState extends QuestionState {}

class QuestionLoadingState extends QuestionState {}



class QuestionLoadedState extends QuestionState {
  final List<Questions> questions;
  QuestionLoadedState(this.questions);
}

class AnswerSubmittedState extends QuestionState {
  final String message;
  AnswerSubmittedState(this.message);
}

class QuestionErrorState extends QuestionState {
  final String error;
  QuestionErrorState(this.error);
}