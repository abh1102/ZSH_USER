part of 'offering_id_cubit.dart';

abstract class OfferingIdState {}

class OfferingIdInitialState extends OfferingIdState {}

class OfferingIdLoadingState extends OfferingIdState {}

class OfferingIdLoadedState extends OfferingIdState {
  final List<AllHealthCoachesModel> offering;
  final bool isFetch;
  final String category;
  OfferingIdLoadedState(this.offering, this.isFetch, this.category);
}

class OfferingIdErrorState extends OfferingIdState {
  final String error;
  OfferingIdErrorState(this.error);
}
