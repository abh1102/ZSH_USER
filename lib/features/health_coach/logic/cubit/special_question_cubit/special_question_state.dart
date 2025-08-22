part of 'special_question_cubit.dart';

abstract class SpecialQuestionState {}

class SpecialQuestionInitialState extends SpecialQuestionState {}

class SpecialQuestionLoadingState extends SpecialQuestionState {}



class SpecialQuestionLoadedState extends SpecialQuestionState {
  final List<Questions> specialquestions;
  SpecialQuestionLoadedState(this.specialquestions);
}

class SpecialAnswerSubmittedState extends SpecialQuestionState {
  final String message;
  SpecialAnswerSubmittedState(this.message);
}

class SpecialQuestionErrorState extends SpecialQuestionState {
  final String error;
  SpecialQuestionErrorState(this.error);
}