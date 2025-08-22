part of 'customized_cubit.dart';

abstract class CustomizedOfferingState {}

class CustomizedOfferingInitialState extends CustomizedOfferingState {}

class CustomizedOfferingLoadingState extends CustomizedOfferingState {}

class CustomizedOfferingLoadedState extends CustomizedOfferingState {
  final List<CustomizedOfferingModel> customizedOffering;
  CustomizedOfferingLoadedState(this.customizedOffering);
}

class CustomizedOfferingErrorState extends CustomizedOfferingState {
  final String error;
  CustomizedOfferingErrorState(this.error);
}