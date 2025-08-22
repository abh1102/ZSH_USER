import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/features/offerings/data/models/current_selected_coach_model.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'health_speciality_state.dart';

class HealthSpecialityCoachCubit extends Cubit<HealthSpecialityCoachState> {
  HealthSpecialityCoachCubit() : super(HealthSpecialityCoachInitialState()) {
    fetchHealthAndSpecialityCoaches();
  }

  final OfferingRepository _repository = OfferingRepository();

  Future<void> fetchSpecialityCoaches() async {
    emit(HealthSpecialityCoachLoadingState());

    try {
      List<CurrentSelectedCoachModel> specialityCoaches = [];

      final selectedCoaches = await _repository.getCurrentSelectedCoach();

      // Filter coaches with coachType as "SPECIAL"
      specialityCoaches = selectedCoaches
          .where((coach) => coach.coachType == "SPECIAL")
          .toList();

      emit(HealthSpecialityCoachLoadedState(specialityCoaches));
    } catch (e) {
      emit(HealthSpecialityCoachErrorState(e.toString()));
    }
  }

  Future<void> fetchHealthAndSpecialityCoaches() async {
    emit(HealthSpecialityCoachLoadingState());

    try {
      // Initialize with empty values
      List<CurrentSelectedCoachModel> specialityCoaches = [];
      List<CurrentSelectedCoachModel> healthCoachCoaches = [];

      final selectedCoaches = await _repository.getCurrentSelectedCoach();

      // Filter coaches with coachType as "SPECIAL"
      specialityCoaches = selectedCoaches
          .where((coach) => coach.coachType == "SPECIAL")
          .toList();

      // Find the first coach with coachType as "HEALTH" (if any)
      healthCoachCoaches = selectedCoaches
          .where((coach) => coach.coachType == "HEALTH")
          .toList();

      // If there is at least one health coach, use the first one; otherwise, set it to null

      emit(NHealthSpecialityCoachLoadedState(
          specialityCoaches, healthCoachCoaches));
    } catch (e) {
      emit(HealthSpecialityCoachErrorState(e.toString()));
    }
  }

  Future<void> selectOrDeselectCoachAndUpdateState(
      String id, bool isSelected, String offerinId) async {
    emit(HealthSpecialityCoachLoadingState());

    try {
      // Call the selectOrDeselectCoach function to perform the action
      bool isSuccess = await _repository.selectOrDeselectCoach(
          id, isSelected, "HEALTH", offerinId);

      emit(HealthCoachRemovedState(isSuccess));

      if (isSuccess == false) {
        showGreenSnackBar("Your Health Coach has successfully removed");
      } else {
        showGreenSnackBar("Your Health Coach has successfully added");
      }
    } catch (e) {
      // If there's an error, emit the error state
      emit(HealthSpecialityCoachErrorState(e.toString()));
    }
  }

  Future<void> refreshData() async {
    emit(HealthSpecialityCoachLoadingState());

    try {
      await fetchHealthAndSpecialityCoaches();
    } catch (e) {
      emit(HealthSpecialityCoachErrorState(e.toString()));
    }
  }
}
