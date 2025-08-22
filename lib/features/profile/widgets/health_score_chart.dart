import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/logic/cubits/health_chart_cubit/health_chart_cubit.dart';
import 'package:zanadu/features/signup/widgets/dynamic_pop_menu.dart';

class HealthScoreChart extends StatefulWidget {
  const HealthScoreChart({super.key});

  @override
  State<HealthScoreChart> createState() => _HealthScoreChartState();
}

class _HealthScoreChartState extends State<HealthScoreChart> {
  late HealthChartCubit healthChartCubit;

  @override
  void initState() {
    super.initState();
    healthChartCubit = BlocProvider.of<HealthChartCubit>(context);
    healthChartCubit.fetchHealthChart(myUser?.userInfo?.userId ?? "");
  }

  String revenuePeriod = "Weekly";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthChartCubit, HealthChartState>(
      builder: (context, state) {
        if (state is HealthChartLoadingState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HealthChartLoadedState) {
          List<SalesData> mySales;

          if (revenuePeriod == "Weekly") {
            mySales = state.weekly;
          } else if (revenuePeriod == "Monthly") {
            mySales = state.monthly;
          } else {
            mySales = state.yearly;
          }
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: Insets.fixedGradient(
                opacity: 0.2,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              children: [
                height(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: simpleText(
                          "My Health Chart",
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DynamicPopupMenuHealthChart(
                        selectedValue: revenuePeriod,
                        items: const ["Weekly", "Monthly", "Yearly"],
                        onSelected: (String value) {
                          setState(() {
                            revenuePeriod = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                height(10),
                HealthScoreChartOnly(salesData: mySales),
              ],
            ),
          );
        } else if (state is HealthChartErrorState) {
          return simpleText(
            state.error,
            align: TextAlign.center,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class HealthScoreChartOnly extends StatelessWidget {
  final List<SalesData> salesData;
  const HealthScoreChartOnly({
    super.key,
    required this.salesData,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryYAxis: const NumericAxis(maximum: 5, interval: 1, minimum: 0),
      primaryXAxis: CategoryAxis(
        interval: 2,
        labelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      series: <CartesianSeries<dynamic, dynamic>>[
        LineSeries<dynamic, dynamic>(
          dataSource: salesData,
          xValueMapper: (data, _) => data.month, // Update the type here
          yValueMapper: (data, _) => data.sales, // Update the type here
          name: 'Gold',
          color: AppColors.primaryBlue,
        ),
      ],
    );
  }
}

class SalesData {
  final String month;
  final num sales; // Use num to accommodate both int and double
  final int index;

  SalesData(this.month, this.sales, this.index);
}
