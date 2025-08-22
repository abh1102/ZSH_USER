import 'package:dio/dio.dart';
import 'package:zanadu/core/api.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/offerings/data/models/current_selected_coach_model.dart';
import 'package:zanadu/features/offerings/data/models/customized_offering_model.dart';
import 'package:zanadu/features/offerings/data/models/offering_model.dart';
import 'dart:developer';

class OfferingRepository {
  final _api = Api();

  //

  Future<List<OfferingsModel>> fetchAllOffering() async {
    try {
      Response response = await _api.sendRequest
          .get("/common/get-offerings", options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => OfferingsModel.fromJson(e)).toList();
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

  // fetch coaches on the basis of offering id

  Future<List<AllHealthCoachesModel>> fetchOfferingCoaches(String id) async {
    try {
      Response response = await _api.sendRequest.get(
          "/coach/get-all-special-coaches-by-offering/$id",
          options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      print("first");
      var convertedData =
          data.map((e) => AllHealthCoachesModel.fromJson(e)).toList();
      print("second");
      return convertedData;
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

  Future<List<CurrentSelectedCoachModel>> getCurrentSelectedCoach() async {
    try {
      Response response = await _api.sendRequest.get(
          "/user/get-current-select-coach-by-user",
          options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => CurrentSelectedCoachModel.fromJson(e)).toList();
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

  // select coach repository

  Future<bool> selectOrDeselectCoach(String coachId, bool isSelected,
      String coachType, String offeringId) async {
    try {
      Response response = await _api.sendRequest.patch(
        "/user/select-coach-by-user",
        data: {
          "coachId": coachId,
          "offeringId": offeringId,
          "coachType": coachType,
          // You might want to make this dynamic
          "isSelected": isSelected,
        },
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      // If the API call is successful, return the value of isSelected
      return isSelected;
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      // If there's an error, throw the exception
      rethrow;
    }
  }

// get customized offering name repository function

  Future<List<CustomizedOfferingModel>> getCustomizedOfferingPlan() async {
    try {
      Response response = await _api.sendRequest.get(
          "/user/customize-coach-type",
          options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => CustomizedOfferingModel.fromJson(e)).toList();
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
  //like api

  Future<String> likeVideo(String coachId, String videoId) async {
    try {
      Response response = await _api.sendRequest.patch(
        "/coach/like-video",
        data: {"coachId": coachId, "videoId": videoId},
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      // If the API call is successful, return the value of isSelected
      return apiResponse.message.toString();
    } on DioException catch (ex) {
      if (ex.response != null) {
        ApiResponse apiResponse = ApiResponse.fromResponse(ex.response!);
        throw apiResponse.message.toString();
      } else {
        throw "An error occurred while processing the request.";
      }
    } catch (ex) {
      // If there's an error, throw the exception
      rethrow;
    }
  }
}
