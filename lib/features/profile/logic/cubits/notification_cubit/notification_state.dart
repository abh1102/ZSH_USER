part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationLoadedState(this.notifications);
}

class UnreadNotificationLoadedState extends NotificationState {
  final List<NotificationModel> notifications;

  UnreadNotificationLoadedState(this.notifications);
}

// Add this to Notification_state.dart

class NotificationErrorState extends NotificationState {
  final String error;
  NotificationErrorState(this.error);
}
