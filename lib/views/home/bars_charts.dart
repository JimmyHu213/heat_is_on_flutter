import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/widgets/bar_chart_template.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;
import 'package:provider/provider.dart';

class BarChartsView extends StatelessWidget {
  BarChartsView({super.key});

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
    const double barWidth = 22.0;
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
    final provider = Provider.of<TownModel>(context);
    final towns = provider.towns;
    final xAxisLabels2 = towns.map((town) => town.name).toList();

    return Consumer<TownModel>(builder: (context, townModel, child) {
      return SizedBox(
        width: double.infinity,
        height: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBarChart(
              barGroups: barGroups1,
              xAxisLabels: config.aspectsTitle,
            ),
            SizedBox(width: 20),
            CustomBarChart(
              barGroups: barGroups2,
              xAxisLabels: xAxisLabels2,
            ),
          ],
        ),
      );
    });
  }
}
