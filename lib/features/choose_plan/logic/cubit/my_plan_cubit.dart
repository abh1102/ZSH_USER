import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/choose_plan/data/model/my_plan_model.dart';
import 'package:zanadu/features/choose_plan/data/repository/my_plan_repository.dart';

part 'my_plan_state.dart';

class MyPlanCubit extends Cubit<MyPlanState> {
  MyPlanCubit() : super(MyPlanInitialState()){
    fetchPlan();
  }

  final MyPlanRepository _repository = MyPlanRepository();

  Future<void> fetchPlan() async {
    emit(MyPlanLoadingState());
    try {
      MyPlanModel myPlan = await _repository.fetchMyPlan();

      emit(MyPlanLoadedState(myPlan));
    } catch (e) {
      emit(MyPlanErrorState(e.toString()));
    }
  }
}
