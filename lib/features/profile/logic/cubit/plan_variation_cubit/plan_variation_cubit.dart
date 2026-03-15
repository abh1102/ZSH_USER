import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/profile/data/model/plan_variation_model.dart';
import 'package:zanadu/features/profile/data/repository/plan_variation_repository.dart';

part 'plan_variation_state.dart';

class PlanVariationCubit extends Cubit<PlanVariationState> {
  final PlanVariationRepository _repository = PlanVariationRepository();

  PlanVariationCubit() : super(PlanVariationInitial());

  Future<void> fetchPlanVariation(String userId) async {
    emit(PlanVariationLoading());
    try {
      final planVariation = await _repository.getPlanVariation(userId);
      emit(PlanVariationLoaded(planVariation));
    } catch (e) {
      emit(PlanVariationError(e.toString()));
    }
  }
}
