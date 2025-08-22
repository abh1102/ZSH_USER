part of 'add_one_session_cubit.dart';

abstract class AddOneSessionState {}

class AddOneSessionInitialState extends AddOneSessionState {}

class AddOneSessionLoadingState extends AddOneSessionState {}

class AddOneSessionLoadedState extends AddOneSessionState {
  final List<Sessions> oneSessions;
  final List<Sessions> followUp;

  AddOneSessionLoadedState(
    this.oneSessions,
    this.followUp,
  );
}

class OneOnOneSessionRequestedState extends AddOneSessionState {
  final String message;
  final String sessionType;

  OneOnOneSessionRequestedState({
    required this.message,
    required this.sessionType,
  });
}

class AddOneSessionErrorState extends AddOneSessionState {
  final String error;
  AddOneSessionErrorState(this.error);
}
