import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/widgets/bar_chart_template.dart';

class BarChartsView extends StatelessWidget {
  const BarChartsView({super.key});

  final double barWidth = 22.0;

  List<BarChartGroupData> getBarGroups(count) {
    return List.generate(
        count,
        (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  width: barWidth,
                  toY: 100, // Example data
                  color: primaryColorLight,
                )
              ],
              showingTooltipIndicators: [0],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final barGroups1 = getBarGroups(4);
    final barGroups2 = getBarGroups(5);
    final xAxisLabels = ['Nature', 'Economy', 'Health', 'Society'];
    final xAxisLabels2 = ['Town1', 'Town2', 'Town3', 'Town4', 'Town5'];
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomBarChart(
            barGroups: barGroups1,
            xAxisLabels: xAxisLabels,
          ),
          SizedBox(width: 20),
          CustomBarChart(
            barGroups: barGroups2,
            xAxisLabels: xAxisLabels2,
          ),
        ],
      ),
    );
  }
}
