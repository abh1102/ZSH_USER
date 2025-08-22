part of 'cancel_reschedule_session_cubit.dart';

abstract class CancelRescheduleSessionState {}

class CancelRescheduleSessionInitial extends CancelRescheduleSessionState {}

class CancelRescheduleSessionLoading extends CancelRescheduleSessionState {}

class CancelSessionLoading extends CancelRescheduleSessionState {}

class CancelRescheduleSessionSuccess extends CancelRescheduleSessionState {
  final String result;

  CancelRescheduleSessionSuccess(this.result);
}

class CancelRescheduleSessionError extends CancelRescheduleSessionState {
  final String error;

  CancelRescheduleSessionError(this.error);
}

class CancelSessionLoaded extends CancelRescheduleSessionState {
  final String message;

  CancelSessionLoaded(this.message);
}

class CancelSessionError extends CancelRescheduleSessionState {
  final String error;

  CancelSessionError(this.error);
}
