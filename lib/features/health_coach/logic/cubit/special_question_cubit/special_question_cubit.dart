import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/health_coach/data/model/answer_model.dart';
import 'package:zanadu/features/health_coach/data/model/question_model.dart';
import 'package:zanadu/features/health_coach/data/repository/health_coach_repository.dart';

part 'special_question_state.dart';

class SpecialQuestionCubit extends Cubit<SpecialQuestionState> {
  SpecialQuestionCubit() : super(SpecialQuestionInitialState());

  final HealthCoachRepository _repository = HealthCoachRepository();

  // final OfferingRepository offeringRepository = OfferingRepository();

  Future<void> fetchSpecialIntakeQuestions(String category) async {
    emit(SpecialQuestionLoadingState());
    try {
      List<Questions> healthIntakeQuestions =
          await _repository.fetchSpecialIntakeQuestions(category);

      emit(SpecialQuestionLoadedState(healthIntakeQuestions));
    } catch (e) {
      // Handle errors if necessary

      emit(SpecialQuestionErrorState(e.toString()));
    }
  }

  Future<void> submitHealthIntakeAnswers(List<SpecialAnswer> answers) async {
    emit(SpecialQuestionLoadingState());
    try {
      String message = await _repository.postSpecialIntakeAnswers(answers);

      emit(SpecialAnswerSubmittedState(message));
    } catch (e) {
      emit(SpecialQuestionErrorState(e.toString()));
    }
  }
}
