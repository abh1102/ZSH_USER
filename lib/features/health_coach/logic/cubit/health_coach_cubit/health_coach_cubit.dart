import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/health_coach/data/model/question_model.dart';
import 'package:zanadu/features/health_coach/data/repository/health_coach_repository.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'health_coach_state.dart';

class AllHealthCoachCubit extends Cubit<AllHealthCoachState> {
  AllHealthCoachCubit() : super(AllHealthCoachInitialState()) {
    _initialize();
  }
  Future<void> _initialize() async {
    await fetchAllHealthCoach();
  }

  final HealthCoachRepository _repository = HealthCoachRepository();

  final OfferingRepository offeringRepository = OfferingRepository();

  Future<void> fetchAllHealthCoach() async {
    emit(AllHealthCoachLoadingState());
    try {
      List<AllHealthCoachesModel> allHealthCoach =
          await _repository.fetchAllHealthCoaches();

      emit(AllHealthCoachLoadedState(allHealthCoach));
    } catch (e) {
      emit(AllHealthCoachErrorState(e.toString()));
    }
  }

  Future<void> selectHealthCoach(String id, String offeringId) async {
    emit(SelectHealthCoachLoadingState());
    try {
      await offeringRepository.selectOrDeselectCoach(
          id, true, "HEALTH", offeringId);

      emit(SelectHealthCoachLoadedState(
          "Your Health Coach has successfully added"));
    } catch (e) {
      emit(AllHealthCoachErrorState(e.toString()));
    }
  }
}
