import 'package:dio/dio.dart';
import 'package:zanadu/core/api.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/data/models/about_us_model.dart';
import 'package:zanadu/features/profile/data/models/get_over_all_health.dart';
import 'package:zanadu/features/profile/data/models/health_score_model.dart';
import 'package:zanadu/features/profile/data/models/notification_model.dart';

class ProfileRepository {
  final _api = Api();

  //

  // fetch over all health score of user

  Future<GetOverAllHealthModel> getOverAllHealth(String id) async {
    try {
      Response response = await _api.sendRequest.get(
          "/user/get-overall-health-score/$id",
          options: ApiUtils.getAuthOptions());

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return GetOverAllHealthModel.fromJson(
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

  Future<List<NotificationModel>> fetchNotification() async {
    try {
      Response response = await _api.sendRequest.get(
        "/notify/get",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => NotificationModel.fromJson(e)).toList();
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

  Future<List<NotificationModel>> fetchUnreadNotification() async {
    try {
      Response response = await _api.sendRequest.get(
        "/notify/get?type=unread",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => NotificationModel.fromJson(e)).toList();
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

  Future<List<AboutUsModel>> fetchAboutUs() async {
    try {
      Response response = await _api.sendRequest.get(
        "/common/get-about-us",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data.map((e) => AboutUsModel.fromJson(e)).toList();
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

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      Response response = await _api.sendRequest.patch(
        "/notify/read/$notificationId",
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }
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

  Future<HealthScoreChartModel> getHealthScoreByCalendar(String userId) async {
    try {
      Response response = await _api.sendRequest.get(
        "/user/get-health-score-by-calender/$userId",
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      return HealthScoreChartModel.fromJson(
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

  Future<List<String>> getTechincalIssueList() async {
    try {
      Response response = await _api.sendRequest.get(
        "/admin/technical-issue-category",
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }
      // Extracting the list of technical issue categories from the response
      List<String> technicalIssueList = List<String>.from(apiResponse.data as List<dynamic>);

      // Returning the list
      return technicalIssueList;
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

  //

  Future<String> postTechincalIssue({
    String? description,
    String? categoryName,
    String? uploadFile, // Add this parameter
  }) async {
    try {
      FormData formData = FormData();

      if (description != null) {
        formData.fields.add(MapEntry('description', description));
      }

      if (categoryName != null) {
        formData.fields.add(MapEntry('categoryName', categoryName));
      }
      

      if (uploadFile != null) {
        formData.files.add(MapEntry(
          'uploadFile',
          await MultipartFile.fromFile(
            uploadFile,
            filename: 'issue_image.jpg', // Provide a filename for the image
          ),
        ));
      }

      Response response = await _api.sendRequest.post(
        "/admin/create-technical-issue",
        data: formData,
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
}
