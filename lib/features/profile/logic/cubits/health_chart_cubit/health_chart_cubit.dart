import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zanadu/features/profile/data/models/health_score_model.dart';
import 'package:zanadu/features/profile/data/repository/profile_repository.dart';
import 'package:zanadu/features/profile/widgets/health_score_chart.dart';

part 'health_chart_state.dart';

class HealthChartCubit extends Cubit<HealthChartState> {
  HealthChartCubit() : super(HealthChartInitialState());

  final ProfileRepository _repository = ProfileRepository();

  Future<void> fetchHealthChart(String id) async {
    emit(HealthChartLoadingState());
    try {
      HealthScoreChartModel charts =
          await _repository.getHealthScoreByCalendar(id);

      emit(HealthChartLoadedState(
        charts,
        charts.wEEKLY?.map((weeklyData) {
              return SalesData(
              formatDateInMmDd( weeklyData.createdAt.toString()),
                weeklyData.finalScore ??
                    0, // No need to convert to double, num accommodates both
                0, // You can replace 0 with the actual index if needed
              );
            }).toList() ??
            [],
        charts.mONTHLY?.map((monthlyData) {
              return SalesData(
                monthlyData.createdAt.toString(),
                monthlyData.finalScore ??
                    0, // No need to convert to double, num accommodates both
                0, // You can replace 0 with the actual index if needed
              );
            }).toList() ??
            [],
        charts.yEARLY?.map((yearlyData) {
              return SalesData(
                yearlyData.createdAt.toString(),
                yearlyData.finalScore ??
                    0, // No need to convert to double, num accommodates both
                0, // You can replace 0 with the actual index if needed
              );
            }).toList() ??
            [],
      ));
    } catch (e) {
      emit(HealthChartErrorState(e.toString()));
    }
  }
}


String formatDateInMmDd(String? dateTimeString) {
  if (dateTimeString != null) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MM-dd').format(dateTime);
  }
  return "";
}