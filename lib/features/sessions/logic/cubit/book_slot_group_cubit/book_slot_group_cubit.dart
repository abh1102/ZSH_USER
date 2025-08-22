import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/sessions/data/model/book_my_slot_model.dart';
import 'package:zanadu/features/sessions/data/repository/all_session_repository.dart';

part 'book_slot_group_state.dart';

class SessionBookingCubit extends Cubit<SessionBookingState> {
  final AllSessionRepository _repository = AllSessionRepository();

  SessionBookingCubit() : super(SessionBookingInitial());

  Future<void> bookSlot(String sessionId, String userId) async {
    emit(SessionBookingLoading());
    try {
      final bookedSlot = await _repository.bookMySlot(sessionId, userId);
      emit(SessionBookingSuccess(bookedSlot));
    } catch (e) {
      emit(SessionBookingError(e.toString()));
    }
  }
}

//book_slot_group