part of 'get_health_cubit.dart';


abstract class GetHealthState {}

class GetHealthInitialState extends GetHealthState {}

class GetHealthLoadingState extends GetHealthState {}

class GetHealthLoadedState extends GetHealthState {
  final GetOverAllHealthModel health;
  GetHealthLoadedState(this.health);
}

class GetHealthErrorState extends GetHealthState {
  final String error;
  GetHealthErrorState(this.error);
}