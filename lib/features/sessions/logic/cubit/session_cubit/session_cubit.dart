import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart';
import 'package:zanadu/features/sessions/data/repository/all_session_repository.dart';

part 'session_state.dart';

class AllSessionCubit extends Cubit<AllSessionState> {
  AllSessionCubit() : super(AllSessionInitialState());

  final AllSessionRepository _repository = AllSessionRepository();

  Future<void> fetchAllSession(String id) async {
    emit(AllSessionLoadingState());
    try {
      List<Sessions> groupSessions = [];
      List<Sessions> followUp = [];
      List<Sessions> yoga = [];
      List<Sessions> discovery = [];
      List<Sessions> orientationSessions = [];
      AllSessionModel allSessions = await _repository.getAllSession(id);

      groupSessions = allSessions.sessions!
          .where((session) =>
              session.sessionType == "GROUP" && session.status != "CANCELED")
          .toList();

      followUp = allSessions.sessions!
          .where((session) => session.sessionType == "FOLLOW_UP")
          .toList();

      yoga = allSessions.sessions!
          .where((session) =>
              session.sessionType == "YOGA" && session.status != "CANCELED")
          .toList();

      discovery = allSessions.sessions!
          .where((session) => session.sessionType == "DISCOVERY")
          .toList();

      orientationSessions = allSessions.sessions!
          .where((session) =>
              session.sessionType == "ORIENTATION" &&
              session.status != "CANCELED")
          .toList();

      emit(AllSessionLoadedState(
        allSessions.sessions ?? [],
        groupSessions,
        followUp,
        discovery,
        yoga,
        orientationSessions,
      ));
    } catch (e) {
      emit(AllSessionErrorState(e.toString()));
    }
  }
}
