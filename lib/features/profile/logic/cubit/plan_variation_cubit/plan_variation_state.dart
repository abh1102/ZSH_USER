part of 'plan_variation_cubit.dart';

abstract class PlanVariationState {}

class PlanVariationInitial extends PlanVariationState {}

class PlanVariationLoading extends PlanVariationState {}

class PlanVariationLoaded extends PlanVariationState {
  final PlanVariationModel planVariation;

  PlanVariationLoaded(this.planVariation);
}

class PlanVariationError extends PlanVariationState {
  final String error;

  PlanVariationError(this.error);
}
