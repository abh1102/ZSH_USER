import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/sessions/data/model/get_feedback_model.dart';
import 'package:zanadu/features/sessions/data/repository/all_session_repository.dart';

part 'feedback_state.dart';

class FeedBackCubit extends Cubit<FeedBackState> {
  FeedBackCubit() : super(FeedBackInitialState());

  final AllSessionRepository _repository = AllSessionRepository();

  Future<void> createFeedback({
    required String sessionId,
    required String rateOfExperience,
    required String coachRate,
    required String callQualityRate,
    required String easyToUseRate,
    required String privacySecurityRate,
  }) async {
    emit(FeedBackLoadingState());

    try {
      String feedbackMessage = await _repository.createFeedback(
        sessionId: sessionId,
        rateOfExperience: rateOfExperience,
        coachRate: coachRate,
        callQualityRate: callQualityRate,
        easyToUseRate: easyToUseRate,
        privacySecurityRate: privacySecurityRate,
      );

      emit(FeedBackCreateLoadedState(feedbackMessage));
    } catch (e) {
      emit(FeedBackErrorState(e.toString()));
    }
  }

  Future<void> getPrevFeedBack() async {
    emit(FeedBackLoadingState());

    try {
      List<GetFeedBackModel> feedbacks = await _repository.getFeedbackModel();

      emit(GetFeedBackLoadedState(feedbacks));
    } catch (e) {
      emit(FeedBackErrorState(e.toString()));
    }
  }
}
