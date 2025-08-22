part of 'get_video_cubit.dart';

abstract class GetVideoState {}

class GetVideoInitialState extends GetVideoState {}

class GetVideoLoadingState extends GetVideoState {}

class GetVideoLoadedState extends GetVideoState {
  final List<MyVideos> approvedVideos;
  final List<MyVideos> unApprovedVideos;
  GetVideoLoadedState(this.approvedVideos, this.unApprovedVideos);
}

class GetCoachVideoLoadedState extends GetVideoState {
  final List<MyVideos> approvedVideos;
  final List<MyVideos> unApprovedVideos;
  final List<MyVideos> demoVideos;
  GetCoachVideoLoadedState(this.approvedVideos, this.unApprovedVideos, this.demoVideos);
}

class GetVideoErrorState extends GetVideoState {
  final String error;
  GetVideoErrorState(this.error);
}
