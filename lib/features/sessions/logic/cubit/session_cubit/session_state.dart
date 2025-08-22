part of 'session_cubit.dart';

abstract class AllSessionState {}

class AllSessionInitialState extends AllSessionState {}

class AllSessionLoadingState extends AllSessionState {}

class AllSessionLoadedState extends AllSessionState {
  final List<Sessions> allSession;
  final List<Sessions> groupSessions;
  final List<Sessions> followUp;
  final List<Sessions> discovery;
  final List<Sessions> yoga;
  final List<Sessions> orientationSessions;

  AllSessionLoadedState(
    this.allSession,
    this.groupSessions,
    this.followUp,
    this.discovery,
    this.yoga,
    this.orientationSessions,
  );
}

class AllSessionErrorState extends AllSessionState {
  final String error;
  AllSessionErrorState(this.error);
}
