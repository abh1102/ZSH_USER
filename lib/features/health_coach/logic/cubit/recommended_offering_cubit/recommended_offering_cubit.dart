import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/health_coach/data/model/recommended_offering_model.dart';
import 'package:zanadu/features/health_coach/data/repository/recommended_offering_repository.dart';

part 'recommended_offering_state.dart';

class RecommendedOfferingCubit extends Cubit<RecommendedOfferingState> {
  final RecommendedOfferingRepository _repository =
      RecommendedOfferingRepository();

  RecommendedOfferingCubit() : super(RecommendedOfferingInitialState());

  Future<void> fetchRecommendedOfferings(String userId, String coachId) async {
    emit(RecommendedOfferingLoadingState());

    try {

      // Call the repository function to get recommended offerings
      final recommendedOfferings =
          await _repository.getRecommendedOfferings(userId, coachId);

      emit(RecommendedOfferingLoadedState(recommendedOfferings));
    } catch (e) {
      emit(RecommendedOfferingErrorState(e.toString()));
    }
  }


  void clearRecommendedOfferings() {
    emit(RecommendedOfferingLoadedState([]));
  }
}
