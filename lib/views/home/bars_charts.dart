import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/widgets/bar_chart_template.dart';

class BarChartsView extends StatelessWidget {
  BarChartsView({super.key});

  final double barWidth = 22.0;

  final colors1 = [
    natureColor,
    economyColor,
    societyColor,
    healthColor,
  ];

  final colors2 = [
    town1Color,
    town2Color,
    town3Color,
    town4Color,
    town5Color,
  ];

  List<BarChartGroupData> getBarGroups(count, List<Color> colors) {
    return List.generate(
        count,
        (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  width: barWidth,
                  toY: 100, // Example data
                  color: colors[i],
                )
              ],
              showingTooltipIndicators: [0],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final barGroups1 = getBarGroups(4, colors1);
    final barGroups2 = getBarGroups(5, colors2);
    final xAxisLabels = [
      'Nature',
      'Economy',
      'Society',
      'Health',
    ];
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
