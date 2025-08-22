import 'package:flutter_bloc/flutter_bloc.dart'; // Import the cancel/reschedule model
import 'package:zanadu/features/sessions/data/repository/all_session_repository.dart'; // Import the repository

part 'cancel_reschedule_session_state.dart';

class CancelRescheduleSessionCubit extends Cubit<CancelRescheduleSessionState> {
  final AllSessionRepository _repository = AllSessionRepository();

  CancelRescheduleSessionCubit() : super(CancelRescheduleSessionInitial());

  // Function to cancel or reschedule a session
  Future<void> cancelOrRescheduleSession(String sessionId, String reasonMessage,
      {bool? isApproved, String? startDate}) async {
    emit(CancelRescheduleSessionLoading());

    try {
      // Call the repository function
      final result = await _repository.rescheduleSession(
          sessionId, reasonMessage,
          isApproved: isApproved, startDate: startDate);

      // Emit the success state with the result
      emit(CancelRescheduleSessionSuccess(result));
    } catch (e) {
      // Emit the error state with the error message
      emit(CancelRescheduleSessionError(e.toString()));
    }
  }

  Future<void> cancelSession({
    required String sessionId,
    required String reasonMessage,
  }) async {
    emit(CancelSessionLoading());
    try {
      String message = await _repository.cancelSession(
        sessionId,
        reasonMessage,
      );

      emit(CancelSessionLoaded(message));
    } catch (e) {
      emit(CancelSessionError(e.toString()));
    }
  }
}
