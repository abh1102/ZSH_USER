import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/offerings/data/models/current_selected_coach_model.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'speciality_state.dart';

class SpecialityCoachCubit extends Cubit<SpecialityCoachState> {
  SpecialityCoachCubit() : super(SpecialityCoachInitialState()) {
    fetchSpecialityCoaches();
   
  }

  final OfferingRepository _repository = OfferingRepository();

  Future<void> fetchSpecialityCoaches() async {
    emit(SpecialityCoachLoadingState());

    try {
        List<CurrentSelectedCoachModel> specialityCoaches = [];
      
      final selectedCoaches = await _repository.getCurrentSelectedCoach();

      // Filter coaches with coachType as "SPECIAL"
       specialityCoaches = selectedCoaches
          .where((coach) => coach.coachType == "SPECIAL")
          .toList();

      emit(SpecialityCoachLoadedState(specialityCoaches));
    } catch (e) {
      emit(SpecialityCoachErrorState(e.toString()));
    }
  }


Future<void> getCurrentSelectedCoach() async {
    emit(SpecialityCoachLoadingState());

    try {
        List<CurrentSelectedCoachModel> specialityCoaches = [];
      
       specialityCoaches = await _repository.getCurrentSelectedCoach();

   

      emit(GetCurrentSelectedCoachLoadedState(specialityCoaches));
    } catch (e) {
      emit(GetCurrentCoachErrorState(e.toString()));
    }
  }

  
}
