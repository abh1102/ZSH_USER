part of 'offering_cubit.dart';

abstract class AllOfferingState {}

class AllOfferingInitialState extends AllOfferingState {}

class AllOfferingLoadingState extends AllOfferingState {}

class AllOfferingLoadedState extends AllOfferingState {
  final List<OfferingsModel> offering;
  AllOfferingLoadedState(this.offering);
}

class AllOfferingErrorState extends AllOfferingState {
  final String error;
  AllOfferingErrorState(this.error);
}