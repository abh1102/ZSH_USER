import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/profile/data/models/about_us_model.dart';
import 'package:zanadu/features/profile/data/repository/profile_repository.dart';
part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInitialState());

  final ProfileRepository _repository = ProfileRepository();

  Future<void> getAboutData() async {
    emit(AboutLoadingState());
    try {
      List<AboutUsModel> abouts = await _repository.fetchAboutUs();

      emit(AboutLoadedState(abouts));
    } catch (e) {
      emit(AboutErrorState(e.toString()));
    }
  }

  Future<List<String>?> getIssueList() async {
    try {
      List<String> issues = await _repository.getTechincalIssueList();
      return issues;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> postIssue(
      {String? descrition, String? issue, String? image}) async {
    emit(AboutLoadingState());
    try {
      String message = await _repository.postTechincalIssue(
        categoryName: issue,
        description: descrition,
        uploadFile: image,
      );

      emit(TechnicalIssuePostedState(message));
    } catch (e) {
      emit(AboutErrorState(e.toString()));
    }
  }
}
