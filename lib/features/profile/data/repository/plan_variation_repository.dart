import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/data/model/plan_variation_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/api.dart';

class PlanVariationRepository {
  final _api = Api();

  Future<PlanVariationModel> getPlanVariation(String userId) async {
    try {
      final response = await _api.sendRequest.get(
        '/coach/plans/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return PlanVariationModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load plan variation');
      }
    } catch (e) {
      throw Exception('Failed to load plan variation: $e');
    }
  }
}
