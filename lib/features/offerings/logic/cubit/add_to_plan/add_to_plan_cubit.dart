import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'add_to_plan_state.dart';

class AddToPlanCubit extends Cubit<AddToPlanState> {
  AddToPlanCubit() : super(AddToPlanInitialState());

  final OfferingRepository _repository = OfferingRepository();

  Future<void> fetchAddToPlan(String coachId, String offeringId) async {
    emit(AddToPlanLoadingState());

    try {
      // Call the getCurrentSelectedCoach function to get selected coaches
      final selectedCoaches = await _repository.getCurrentSelectedCoach();

      // Check if the provided id is present in the selected coaches
      bool isSelected = selectedCoaches.any(
        (coach) =>
            coach.coachId == coachId && coach.offeringId == offeringId,
      );

      emit(AddToPlanLoadedState(isSelected));
    } catch (e) {
      emit(AddToPlanErrorState(e.toString()));
    }
  }


  Future<void> offeringfetchAddToPlan(String coachId, String offeringId) async {
    emit(AddToPlanLoadingState());

    try {
      // Call the getCurrentSelectedCoach function to get selected coaches
      final selectedCoaches = await _repository.getCurrentSelectedCoach();

      // Check if the provided id is present in the selected coaches
      bool isSelected = selectedCoaches.any(
        (coach) =>
            coach.coachId == coachId && coach.offeringId == offeringId,
      );

      emit(AddToPlanLoadedState(isSelected));
    } catch (e) {
      emit(AddToPlanErrorState(e.toString()));
    }
  }
  Future<void> fetchSelectedHealthCoach(String id) async {
    emit(AddToPlanLoadingState());

    try {
      // Call the getCurrentSelectedCoach function to get selected coaches
      final selectedCoaches = await _repository.getCurrentSelectedCoach();

      // Check if the provided id is present in the selected coaches
      bool isCoach =
          selectedCoaches.any((coach) => coach.coachType == "HEALTH");

      bool isSelected =
          selectedCoaches.any((coach) => coach.coachInfo?.offeringId == id);

      if (isCoach == true && isSelected == true) {
        emit(SameHealthCoachSelectedState());
        return;
      }
      if (isCoach == true && isSelected == false) {
        emit(DifferentHealthCoachSelectedState());
        return;
      }

      if (isCoach == false && isSelected == false) {
        emit(NoHealthCoachSelectedState());
        return;
      }
    } catch (e) {
      emit(AddToPlanErrorState(e.toString()));
    }
  }

  Future<void> selectOrDeselectCoachAndUpdateState(
      String id, bool isSelected, String offeringId) async {
    emit(AddToPlanLoadingState());

    try {
      // Call the selectOrDeselectCoach function to perform the action
      bool isSuccess = await _repository.selectOrDeselectCoach(
          id, isSelected, "SPECIAL", offeringId);

      emit(AddToPlanSelectDesState(isSuccess));

      if (isSuccess == true) {
        showGreenSnackBar("Your Plan has successfully added");
      } else {
        showGreenSnackBar("Your Plan has successfully removed");
      }
    } catch (e) {
      // If there's an error, emit the error state
      emit(AddToPlanErrorState(e.toString()));
    }
  }
}
