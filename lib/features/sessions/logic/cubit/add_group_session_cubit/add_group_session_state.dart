part of 'add_group_session_cubit.dart';

abstract class AddGroupSessionState {}

class AddGroupSessionInitialState extends AddGroupSessionState {}

class AddGroupSessionLoadingState extends AddGroupSessionState {}

class AddGroupSessionLoadedState extends AddGroupSessionState {
  final List<Sessions> orientationSessions;
  final List<Sessions> groupSessions;
  final List<Sessions> yogaSessions;

  AddGroupSessionLoadedState(
    this.orientationSessions,
    this.groupSessions,
    this.yogaSessions,
  );
}

class AddGroupSessionErrorState extends AddGroupSessionState {
  final String error;
  AddGroupSessionErrorState(this.error);
}
