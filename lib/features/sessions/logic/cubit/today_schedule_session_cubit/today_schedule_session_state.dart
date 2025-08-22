part of 'today_schedule_session_cubit.dart';

abstract class TodayScheduleSessionState {}

class TodayScheduleSessionInitialState extends TodayScheduleSessionState {}

class TodayScheduleSessionLoadingState extends TodayScheduleSessionState {}

class TodayScheduleSessionLoadedState extends TodayScheduleSessionState {
  final AllSessionModel todaySchedule;

  TodayScheduleSessionLoadedState(this.todaySchedule);
}

// Add this to TodayScheduleSession_state.dart

class TodayScheduleSessionErrorState extends TodayScheduleSessionState {
  final String error;
  TodayScheduleSessionErrorState(this.error);
}
