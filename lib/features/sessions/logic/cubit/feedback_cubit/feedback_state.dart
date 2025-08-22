part of 'feedback_cubit.dart';

abstract class FeedBackState {}

class FeedBackInitialState extends FeedBackState {}

class FeedBackLoadingState extends FeedBackState {}

class FeedBackCreateLoadedState extends FeedBackState {
  final String feedBacks;

  FeedBackCreateLoadedState(this.feedBacks);
}

class GetFeedBackLoadedState extends FeedBackState {
  final List<GetFeedBackModel> feedBacks;

  GetFeedBackLoadedState(this.feedBacks);
}

// Add this to FeedBack_state.dart

class FeedBackErrorState extends FeedBackState {
  final String error;
  FeedBackErrorState(this.error);
}
