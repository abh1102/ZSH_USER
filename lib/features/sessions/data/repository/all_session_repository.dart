import 'package:dio/dio.dart';
import 'package:zanadu/core/api.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart';
import 'package:zanadu/features/sessions/data/model/book_my_slot_model.dart';
import 'package:zanadu/features/sessions/data/model/get_feedback_model.dart';

class AllSessionRepository {
  final _api = Api();

  Future<AllSessionModel> getAllSession(String id) async {
    try {
      Response response = await _api.sendRequest.get(
          "/coach/get-session-by-user/$id",
          options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return AllSessionModel.fromJson(apiResponse.data as Map<String, dynamic>);
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

  Future<AllSessionModel> getSessionByCoach(
      String id, String offeringId) async {
    try {
      Response response = await _api.sendRequest.get(
          "/coach/get-session-by-coach?coachId=$id&offeringId=$offeringId",
          options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return AllSessionModel.fromJson(apiResponse.data as Map<String, dynamic>);
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

  Future<BookMySlotGroupModel> bookMySlot(
      String sessionId, String userId) async {
    try {
      Response response = await _api.sendRequest.patch(
        "/coach/register-session/$sessionId",
        options: ApiUtils.getAuthOptions(),
        data: {
          "userId": userId,
          "isRegister": true,
        },
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return BookMySlotGroupModel.fromJson(
          apiResponse.data as Map<String, dynamic>);
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

  // function for cancel and reschedule

  Future<String> rescheduleSession(String sessionId, String reasonMessage,
      {bool? isApproved, String? startDate}) async {
    try {
      // Create the request body based on the parameters
      final Map<String, dynamic> requestBody = {"reasonMessage": reasonMessage};

      if (isApproved != null) {
        requestBody["isApproved"] = isApproved;
      }

      if (startDate != null) {
        requestBody["startDate"] = startDate;
      }

      // Make the API request
      Response response = await _api.sendRequest.patch(
        "/coach/edit-session/$sessionId",
        options: ApiUtils.getAuthOptions(),
        data: requestBody,
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
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

  // function for create session or request one on one session

  Future<String> createOneOnOneSession({
    required String sessionType,
    required String title,
    required String description,
    required String startDate,
    required int noOfSlots,
    required String coachId,
    required String offeringId,
    required String userId,
  }) async {
    try {
      Map<String, dynamic> requestData = {
        "sessionType": sessionType,
        "title": title,
        "description": description,
        "startDate": startDate,
        "noOfSlots": noOfSlots,
        "coachId": coachId,
        "userId": [userId],
        "offeringId": offeringId
      };

      Response response = await _api.sendRequest.post(
        "/coach/create-session",
        data: requestData,
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
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

  // feedback repository
  Future<String> createFeedback({
    required String sessionId,
    required String rateOfExperience,
    required String coachRate,
    required String callQualityRate,
    required String easyToUseRate,
    required String privacySecurityRate,
  }) async {
    try {
      Map<String, dynamic> requestData = {
        "sessionId": sessionId,
        "rateOfExperience": rateOfExperience,
        "coachRate": coachRate,
        "callQualityRate": callQualityRate,
        "easyToUseRate": easyToUseRate,
        "privacySecurityRate": privacySecurityRate,
      };

      Response response = await _api.sendRequest.post(
        "/user/feedback/create",
        data: requestData,
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
      // You may return additional data from the response if needed
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

  // get feedback repository

  Future<List<GetFeedBackModel>> getFeedbackModel() async {
    try {
      Response response = await _api.sendRequest.get(
        "/user/feedback/check-by-user-recent",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => GetFeedBackModel.fromJson(e)).toList();
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

  // cancel session
  Future<String> cancelSession(String sessionId, String reasonMessage) async {
    try {
      Map<String, dynamic> requestData = {
        "reasonMessage": reasonMessage,
      };

      Response response = await _api.sendRequest.patch(
        "/coach/cancel-session/$sessionId",
        data: requestData,
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
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

  // attend session
  Future<String> attendSession(
    String sessionId,
  ) async {
    try {
      Response response = await _api.sendRequest.patch(
        "/coach/attend-session/$sessionId",
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return apiResponse.message.toString();
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

  // get session by coach

  // get session of the day

  Future<AllSessionModel> getScheduleSessionsByCoachId(
      String date, String coachId) async {
    try {
      Response response = await _api.sendRequest.get(
        "/coach/get-session-of-the-day?coachId=$coachId&date=$date",
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return AllSessionModel.fromJson(apiResponse.data as Map<String, dynamic>);
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
