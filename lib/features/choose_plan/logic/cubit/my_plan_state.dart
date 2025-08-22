part of 'my_plan_cubit.dart';

abstract class MyPlanState {}

class MyPlanInitialState extends MyPlanState {}

class MyPlanLoadingState extends MyPlanState {}

class MyPlanLoadedState extends MyPlanState {
  final MyPlanModel? plan;
  MyPlanLoadedState(this.plan);
}

class MyPlanErrorState extends MyPlanState {
  final String error;
  MyPlanErrorState(this.error);
}