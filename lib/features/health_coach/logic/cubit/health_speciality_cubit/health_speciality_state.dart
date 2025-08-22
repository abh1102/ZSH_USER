part of 'health_speciality_cubit.dart';

abstract class HealthSpecialityCoachState {}

class HealthSpecialityCoachInitialState extends HealthSpecialityCoachState {}

class HealthSpecialityCoachLoadingState extends HealthSpecialityCoachState {}

class HealthSpecialityCoachLoadedState extends HealthSpecialityCoachState {
  final List<CurrentSelectedCoachModel> coaches;
  HealthSpecialityCoachLoadedState(this.coaches);
}

class NHealthSpecialityCoachLoadedState extends HealthSpecialityCoachState {
  final List<CurrentSelectedCoachModel> healthCoach;
  final List<CurrentSelectedCoachModel> healthspecialityCoach;
  NHealthSpecialityCoachLoadedState(
    this.healthspecialityCoach,
    this.healthCoach,
  );
}

class HealthCoachRemovedState extends HealthSpecialityCoachState {
  final bool isRemoved;
  HealthCoachRemovedState(this.isRemoved);
}

class HealthSpecialityCoachErrorState extends HealthSpecialityCoachState {
  final String error;
  HealthSpecialityCoachErrorState(this.error);
}
