import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/offerings/data/models/customized_offering_model.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'customized_state.dart';

class CustomizedOfferingCubit extends Cubit<CustomizedOfferingState> {
  CustomizedOfferingCubit() : super(CustomizedOfferingInitialState()) {
    fetchCustomizedOffering();
  }

  final OfferingRepository _repository = OfferingRepository();

   Future<void> fetchCustomizedOffering() async {
    emit(CustomizedOfferingLoadingState());
    try {
      List<CustomizedOfferingModel> customizedOffering =
          await _repository.getCustomizedOfferingPlan();

      emit(CustomizedOfferingLoadedState(customizedOffering));
    } catch (e) {
      emit(CustomizedOfferingErrorState(e.toString()));
    }
  }
}


