part of 'recommended_offering_cubit.dart';

abstract class RecommendedOfferingState {}

class RecommendedOfferingInitialState extends RecommendedOfferingState {}

class RecommendedOfferingLoadingState extends RecommendedOfferingState {}

class RecommendedOfferingLoadedState extends RecommendedOfferingState {
  final List<RecommendedOfferingModel> recommendedOffering;
  RecommendedOfferingLoadedState(this.recommendedOffering);
}

class RecommendedOfferingErrorState extends RecommendedOfferingState {
  final String error;
  RecommendedOfferingErrorState(this.error);
}