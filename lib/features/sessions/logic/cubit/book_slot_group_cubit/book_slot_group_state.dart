part of 'book_slot_group_cubit.dart';

abstract class SessionBookingState {}

class SessionBookingInitial extends SessionBookingState {}

class SessionBookingLoading extends SessionBookingState {}

class SessionBookingSuccess extends SessionBookingState {
  final BookMySlotGroupModel bookedSlot;

  SessionBookingSuccess(this.bookedSlot);
}

class SessionBookingError extends SessionBookingState {
  final String error;

  SessionBookingError(this.error);
}
