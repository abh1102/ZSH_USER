import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/features/health_coach/data/model/answer_model.dart';
import 'package:zanadu/features/health_coach/data/model/question_model.dart';
import 'package:zanadu/features/health_coach/data/repository/health_coach_repository.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitialState()) {
    _initialize();
  }
  Future<void> _initialize() async {
    await fetchHealthIntakeQuestions();
  }

  final HealthCoachRepository _repository = HealthCoachRepository();

  final OfferingRepository offeringRepository = OfferingRepository();

  Future<void> fetchHealthIntakeQuestions() async {
    emit(QuestionLoadingState());
    try {
      List<Questions> healthIntakeQuestions =
          await _repository.fetchHealthIntakeQuestions();

      // Do something with the fetched questions, you can emit a state if needed.
      // For example, you can create a state like AllHealthIntakeQuestionsLoadedState.

      emit(QuestionLoadedState(healthIntakeQuestions));
    } catch (e) {
      // Handle errors if necessary

      emit(QuestionErrorState(e.toString()));
    }
  }

  Future<void> submitHealthIntakeAnswers(List<Answer> answers) async {
    emit(QuestionLoadingState());
    try {
      String message = await _repository.postHealthIntakeAnswers(answers);

      // You can emit a state to notify that the answers have been successfully submitted.
      // For example, you can create a state like HealthIntakeAnswersSubmittedState.

      emit(AnswerSubmittedState(message));
    } catch (e) {
      emit(QuestionErrorState(e.toString()));
    }
  }
}
