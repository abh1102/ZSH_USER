part of 'about_cubit.dart';

abstract class AboutState {}

class AboutInitialState extends AboutState {}

class AboutLoadingState extends AboutState {}

class AboutLoadedState extends AboutState {
  final List<AboutUsModel> abouts;

  AboutLoadedState(this.abouts);
}

class TechnicalIssuePostedState extends AboutState {
  final String message;

  TechnicalIssuePostedState(this.message);
}


// Add this to About_state.dart

class AboutErrorState extends AboutState {
  final String error;
  AboutErrorState(this.error);
}

class TechincalIssueErrorState extends AboutState {
  final String error;
  TechincalIssueErrorState(this.error);
}
