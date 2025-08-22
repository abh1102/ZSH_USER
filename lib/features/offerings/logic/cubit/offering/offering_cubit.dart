import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/offerings/data/models/offering_model.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'offering_state.dart';

class AllOfferingCubit extends Cubit<AllOfferingState> {
  AllOfferingCubit() : super(AllOfferingInitialState()) {
    fetchAllOffering();
  }

  final OfferingRepository _repository = OfferingRepository();

  Future<void> fetchAllOffering() async {
    emit(AllOfferingLoadingState());
    try {
      List<OfferingsModel> allOffering = await _repository.fetchAllOffering();

      myOfferings = allOffering;
      emit(AllOfferingLoadedState(allOffering));
    } catch (e) {
      emit(AllOfferingErrorState(e.toString()));
    }
  }
}
