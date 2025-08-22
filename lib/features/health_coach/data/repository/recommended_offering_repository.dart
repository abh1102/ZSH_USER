import 'package:dio/dio.dart';
import 'package:zanadu/core/api.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/health_coach/data/model/recommended_offering_model.dart';

class RecommendedOfferingRepository {
  final _api = Api();

  Future<List<RecommendedOfferingModel>> getRecommendedOfferings(
      String userId, String coachId) async {
    try {
      // Make the API call to get recommended offerings
      Response response = await _api.sendRequest.get(
        "/coach/get-recommended-offerings",
        queryParameters: {
          "userId": userId,
          "coachId": coachId,
        },
        options: ApiUtils.getAuthOptions(),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.status) {
        throw apiResponse.message.toString();
      }

      // Parse the response data and return a list of RecommendedOfferingModel
      List<dynamic> data = apiResponse.data as List<dynamic>;
      return data
          .map((e) => RecommendedOfferingModel.fromJson(e))
          .toList();
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
