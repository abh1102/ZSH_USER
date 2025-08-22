import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/profile/data/models/notification_model.dart';
import 'package:zanadu/features/profile/data/repository/profile_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState()) {
    getNotificationData();
  }

  final ProfileRepository _repository = ProfileRepository();

  Future<void> getNotificationData() async {
    emit(NotificationLoadingState());
    try {
      List<NotificationModel> notification =
          await _repository.fetchNotification();

      emit(NotificationLoadedState(notification));
    } catch (e) {
      emit(NotificationErrorState(e.toString()));
    }
  }

  Future<void> getUnreadNotificationData() async {
    emit(NotificationLoadingState());
    try {
      List<NotificationModel> notification =
          await _repository.fetchUnreadNotification();

      emit(UnreadNotificationLoadedState(notification));
    } catch (e) {
      emit(NotificationErrorState(e.toString()));
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    emit(NotificationLoadingState());
    try {
      await _repository.markNotificationAsRead(notificationId);

      // Refresh the notification list after marking as read
      getNotificationData();
    } catch (e) {
      emit(NotificationErrorState(e.toString()));
    }
  }
}
