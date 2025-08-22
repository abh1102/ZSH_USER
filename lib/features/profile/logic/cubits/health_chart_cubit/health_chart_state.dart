part of 'health_chart_cubit.dart';

abstract class HealthChartState {}

class HealthChartInitialState extends HealthChartState {}

class HealthChartLoadingState extends HealthChartState {}

class HealthChartLoadedState extends HealthChartState {
  final HealthScoreChartModel chart;
  final List<SalesData> weekly;
  final List<SalesData> monthly;
  final List<SalesData> yearly;

  HealthChartLoadedState(this.chart, this.weekly, this.monthly, this.yearly);
}

class HealthChartErrorState extends HealthChartState {
  final String error;
  HealthChartErrorState(this.error);
}
