import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/health_coach/data/model/get_answer_model.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/health_coach/data/repository/health_coach_repository.dart';
import 'package:zanadu/features/offerings/data/models/offering_model.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'offering_id_state.dart';

class OfferingIdCubit extends Cubit<OfferingIdState> {
  OfferingIdCubit() : super(OfferingIdInitialState());

  final OfferingRepository _repository = OfferingRepository();

  final HealthCoachRepository healthCoachRepository = HealthCoachRepository();

  Future<void> fetchOfferingId(String id) async {
    emit(OfferingIdLoadingState());
    try {
      bool isFetch = true;
      String category = "";
      List<AllHealthCoachesModel> offeringId =
          await _repository.fetchOfferingCoaches(id);

      for (OfferingsModel offering in myOfferings ?? []) {
        if (offering.sId == id) {
          if (offering.title == "Nutrition") {
            List<GetAnswerModel> data =
                await healthCoachRepository.fetchAllSpecialIntakeAnswer(
                    myUser?.userInfo?.userId ?? "", "NUTRITION_SPECIAL");

            if (data.isEmpty) {
              isFetch = false;
              category = "NUTRITION_SPECIAL";
            } else {
              isFetch = true;
            }
          } else if (offering.title == "Mindset") {
            List<GetAnswerModel> data =
                await healthCoachRepository.fetchAllSpecialIntakeAnswer(
                    myUser?.userInfo?.userId ?? "", "MINDSET_SPECIAL");
            if (data.isEmpty) {
              isFetch = false;
              category = "MINDSET_SPECIAL";
            } else {
              isFetch = true;
            }
          } else if (offering.title == "Energy") {
            List<GetAnswerModel> data =
                await healthCoachRepository.fetchAllSpecialIntakeAnswer(
                    myUser?.userInfo?.userId ?? "", "ENERGY_SPECIAL");

            if (data.isEmpty) {
              isFetch = false;
              category = "ENERGY_SPECIAL";
            } else {
              isFetch = true;
            }
          }
        }
      }
      print("//////////////working hereeeeeeeeeeeeee//////////////////");
      print(isFetch);
      emit(OfferingIdLoadedState(offeringId, isFetch, category));
    } catch (e) {
      emit(OfferingIdErrorState(e.toString()));
    }
  }
}
