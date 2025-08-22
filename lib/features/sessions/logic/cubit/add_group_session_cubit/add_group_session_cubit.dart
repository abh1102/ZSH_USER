import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart';
import 'package:zanadu/features/sessions/data/repository/all_session_repository.dart';

part 'add_group_session_state.dart';

class AddGroupSessionCubit extends Cubit<AddGroupSessionState> {
  AddGroupSessionCubit() : super(AddGroupSessionInitialState());

  final AllSessionRepository _repository = AllSessionRepository();

  Future<void> fetchAddGroupSession(String id, String offerinId) async {
    emit(AddGroupSessionLoadingState());
    try {
      AllSessionModel allSessions =
          await _repository.getSessionByCoach(id, offerinId);

      List<Sessions> groupSessions = allSessions.sessions!
          .where((session) => session.sessionType == "GROUP")
          .toList();

            List<Sessions> yogaSession = allSessions.sessions!
          .where((session) => session.sessionType == "YOGA")
          .toList();

      List<Sessions> orientationSessions = allSessions.sessions!
          .where((session) => session.sessionType == "ORIENTATION")
          .toList();

      emit(AddGroupSessionLoadedState(
        orientationSessions,
        groupSessions,
        yogaSession
      ));
    } catch (e) {
      emit(AddGroupSessionErrorState(e.toString()));
    }
  }
}
