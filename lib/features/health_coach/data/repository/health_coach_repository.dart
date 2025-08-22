import 'package:dio/dio.dart';
import 'package:zanadu/core/api.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/health_coach/data/model/answer_model.dart';
import 'package:zanadu/features/health_coach/data/model/get_answer_model.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/health_coach/data/model/question_model.dart';

class HealthCoachRepository {
  final _api = Api();

  //

  Future<List<AllHealthCoachesModel>> fetchAllHealthCoaches() async {
    try {
      Response response = await _api.sendRequest.get(
        "/coach/get-all-health-coaches",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => AllHealthCoachesModel.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  // top 5 health coach

  Future<List<AllHealthCoachesModel>> fetchTopFiveCoach() async {
    try {
      Response response = await _api.sendRequest.get(
        "/coach/get-best-health-coaches",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => AllHealthCoachesModel.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Questions>> fetchHealthIntakeQuestions() async {
    try {
      Response response = await _api.sendRequest.get(
        "/user/get-all-health-intake-questions",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      QuestionModel questionModel = QuestionModel.fromJson(data);

      return questionModel.questions ?? [];
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Questions>> fetchSpecialIntakeQuestions(String category) async {
    try {
      Response response = await _api.sendRequest.get(
        "/user/get-all-health-intake-questions?category=$category",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      QuestionModel questionModel = QuestionModel.fromJson(data);

      return questionModel.questions ?? [];
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<GetAnswerModel>> fetchAllHealthIntakeAnswer(String userId) async {
    try {
      Response response = await _api.sendRequest.get(
        "/user/get-input-answer-healthIntake/$userId",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => GetAnswerModel.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<GetAnswerModel>> fetchAllSpecialIntakeAnswer(
      String userId, String category) async {
    try {
      Response response = await _api.sendRequest.get(
        "/user/get-input-answer-special-healthIntake/${myUser?.userInfo?.userId}?category=$category",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      
      print(data.map((e) => GetAnswerModel.fromJson(e)).toList());
      return data.map((e) => GetAnswerModel.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> postHealthIntakeAnswers(List<Answer> answers) async {
    try {
      Response response = await _api.sendRequest.post(
        "/user/create-input-answer-healthIntake",
        data: answers.map((answer) => answer.toJson()).toList(),
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }
      return apiResponse.message.toString();
      // If the request is successful, no need to return any data.
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> postSpecialIntakeAnswers(List<SpecialAnswer> answers) async {
    try {
      Response response = await _api.sendRequest.post(
        "/user/create-input-answer-special-healthIntake",
        data: answers.map((answer) => answer.toJson()).toList(),
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }
      return apiResponse.message.toString();
      // If the request is successful, no need to return any data.
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }



  Future<List<MyVideos>> getAllWOCoachVideos(
      String coachId) async {
    try {
      Response response = await _api.sendRequest.get(
        "/coach/get-videos?coachId=$coachId",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => MyVideos.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      rethrow;
    }
  }
}
