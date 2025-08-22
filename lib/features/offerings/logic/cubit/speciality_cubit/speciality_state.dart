part of 'speciality_cubit.dart';

abstract class SpecialityCoachState {}

class SpecialityCoachInitialState extends SpecialityCoachState {}

class SpecialityCoachLoadingState extends SpecialityCoachState {}

class SpecialityCoachLoadedState extends SpecialityCoachState {
  final List<CurrentSelectedCoachModel> coaches;
  SpecialityCoachLoadedState(this.coaches);
}

class GetCurrentSelectedCoachLoadedState extends SpecialityCoachState {
  final List<CurrentSelectedCoachModel> coaches;
  GetCurrentSelectedCoachLoadedState(this.coaches);
}
class GetCurrentCoachErrorState extends SpecialityCoachState {
  final String error;
  GetCurrentCoachErrorState(this.error);
}


class SpecialityCoachErrorState extends SpecialityCoachState {
  final String error;
  SpecialityCoachErrorState(this.error);
}
