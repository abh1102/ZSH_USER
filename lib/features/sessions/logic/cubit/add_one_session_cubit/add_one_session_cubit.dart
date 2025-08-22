import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart';
import 'package:zanadu/features/sessions/data/repository/all_session_repository.dart';

part 'add_one_session_state.dart';

class AddOneSessionCubit extends Cubit<AddOneSessionState> {
  AddOneSessionCubit() : super(AddOneSessionInitialState());

  final AllSessionRepository _repository = AllSessionRepository();

  Future<void> fetchAddOneSession(String id, String offeringId) async {
    emit(AddOneSessionLoadingState());
    try {
      AllSessionModel allSessions =
          await _repository.getSessionByCoach(id, offeringId);

      List<Sessions> oneSessions = allSessions.sessions!
          .where((session) => session.sessionType == "DISCOVERY")
          .toList();

      List<Sessions> followUp = allSessions.sessions!
          .where((session) => session.sessionType == "FOLLOW_UP")
          .toList();

      emit(AddOneSessionLoadedState(oneSessions, followUp));
    } catch (e) {
      emit(AddOneSessionErrorState(e.toString()));
    }
  }

  // function for create one on one session

  Future<void> createOneOnOneSession({
    required String sessionType,
    required String title,
    required String description,
    required String startDate,
    required int noOfSlots,
    required String coachId,
      required String offeringId,
    required String userId,
  }) async {
    emit(AddOneSessionLoadingState());
    try {
      String message = await _repository.createOneOnOneSession(
          sessionType: sessionType,
          title: title,
          description: description,
          startDate: startDate,
          noOfSlots: noOfSlots,
          coachId: coachId,
          offeringId:offeringId,
          userId: userId);

      emit(OneOnOneSessionRequestedState(
          message: message, sessionType: sessionType));
    } catch (e) {
      emit(AddOneSessionErrorState(e.toString()));
    }
  }
}
