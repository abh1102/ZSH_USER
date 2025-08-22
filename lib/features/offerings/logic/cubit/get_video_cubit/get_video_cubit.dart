import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/health_coach/data/repository/health_coach_repository.dart';

part 'get_video_state.dart';

class GetVideoCubit extends Cubit<GetVideoState> {
  GetVideoCubit() : super(GetVideoInitialState());

  final HealthCoachRepository _repository = HealthCoachRepository();

  Future<void> fetchCoachGetVideo(
    String coachId,
  ) async {
    emit(GetVideoLoadingState());
    try {
      List<MyVideos> approvedVideos = [];
      List<MyVideos> unapprovedVideos = [];
      List<MyVideos> demoVideos = [];
      List<MyVideos> videos = await _repository.getAllWOCoachVideos(
        coachId,
      );

      approvedVideos = videos
          .where(
              (video) => video.isApproved == true && video.videoType == "FULL")
          .toList();

      demoVideos = videos
          .where(
              (video) => video.isApproved == true && video.videoType == "DEMO")
          .toList();
      unapprovedVideos =
          videos.where((video) => video.isApproved == false).toList();

      emit(GetCoachVideoLoadedState(
          approvedVideos, unapprovedVideos, demoVideos));
    } catch (e) {
      emit(GetVideoErrorState(e.toString()));
    }
  }
}
