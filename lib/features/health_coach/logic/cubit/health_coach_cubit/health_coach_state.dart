part of 'health_coach_cubit.dart';

abstract class AllHealthCoachState {}

class AllHealthCoachInitialState extends AllHealthCoachState {}

class AllHealthCoachLoadingState extends AllHealthCoachState {}

class SelectHealthCoachLoadingState extends AllHealthCoachState {}

class AllHealthCoachLoadedState extends AllHealthCoachState {
  final List<AllHealthCoachesModel> healthCoach;
  AllHealthCoachLoadedState(this.healthCoach);
}

class HealthCoachQuestionLoadedState extends AllHealthCoachState {
  final List<Questions> questions;
  HealthCoachQuestionLoadedState(this.questions);
}

class SelectHealthCoachLoadedState extends AllHealthCoachState {
  final String message;
  SelectHealthCoachLoadedState(this.message);
}

class AllHealthCoachErrorState extends AllHealthCoachState {
  final String error;
  AllHealthCoachErrorState(this.error);
}