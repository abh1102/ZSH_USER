import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/profile/data/models/get_over_all_health.dart';
import 'package:zanadu/features/profile/data/repository/profile_repository.dart';

part 'get_health_state.dart';

class GetHealthCubit extends Cubit<GetHealthState> {
  GetHealthCubit() : super(GetHealthInitialState());

  final ProfileRepository _repository = ProfileRepository();

  Future<void> fetchGetHealth(String id) async {
    emit(GetHealthLoadingState());
    try {
      GetOverAllHealthModel health = await _repository.getOverAllHealth(id);

      emit(GetHealthLoadedState(health));
    } catch (e) {
      emit(GetHealthErrorState(e.toString()));
    }
  }
}
