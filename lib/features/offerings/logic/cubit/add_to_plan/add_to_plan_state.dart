part of 'add_to_plan_cubit.dart';

abstract class AddToPlanState {}

class AddToPlanInitialState extends AddToPlanState {}

class AddToPlanLoadingState extends AddToPlanState {}

class SameHealthCoachSelectedState extends AddToPlanState {}

class DifferentHealthCoachSelectedState extends AddToPlanState {}

class NoHealthCoachSelectedState extends AddToPlanState {}

class AddToPlanLoadedState extends AddToPlanState {
  final bool isSelected;
  AddToPlanLoadedState(this.isSelected);
}

class AddToPlanSelectDesState extends AddToPlanState {
  final bool isSelected;
  AddToPlanSelectDesState(this.isSelected);
}


class AddToPlanErrorState extends AddToPlanState {
  final String error;
  AddToPlanErrorState(this.error);
}
