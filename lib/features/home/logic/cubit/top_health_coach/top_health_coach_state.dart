part of 'top_health_coach_cubit.dart';

abstract class FiveHealthCoachState {}

class FiveHealthCoachInitialState extends FiveHealthCoachState {}

class FiveHealthCoachLoadingState extends FiveHealthCoachState {}

class FiveHealthCoachLoadedState extends FiveHealthCoachState {
  final List<AllHealthCoachesModel> healthCoach;
  FiveHealthCoachLoadedState(this.healthCoach);
}

class HealthCoachQuestionLoadedState extends FiveHealthCoachState {
  final List<Questions> questions;
  HealthCoachQuestionLoadedState(this.questions);
}

class FiveHealthCoachErrorState extends FiveHealthCoachState {
  final String error;
  FiveHealthCoachErrorState(this.error);
}