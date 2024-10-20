import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/model/global_data.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/widgets/bar_chart_template.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;
import 'package:heat_is_on_flutter/widgets/pie_chart_template.dart';
import 'package:provider/provider.dart';

class BarChartsView extends StatelessWidget {
  BarChartsView({Key? key}) : super(key: key);

  final List<Color> aspectColors = [
    natureColor,
    economyColor,
    societyColor,
    healthColor,
  ];
  final List<String> aspects = config.aspectIds;
  final List<String> hazards = config.hazardIds;

  List<PieChartSectionData> getSections(Town town) {
    final colors = [
      bushfireColor1,
      floodColor1,
      stormSurgeColor1,
      heatwaveColor1,
      biohazardColor1,
    ];

    List<PieChartSectionData> sections = [];

    for (int i = 0; i < hazards.length; i++) {
      final hazard = hazards[i];
      final hazardPoints = getHazardPoints(town, hazard);
      final color = colors[i];

      for (int j = 0; j < aspects.length; j++) {
        final aspect = aspects[j];
        final points = hazardPoints[aspect] ?? 0;

        sections.add(
          PieChartSectionData(
            color: color,
            value: 1,
            title: points.toString(),
            titleStyle: TextStyle(
              color: Colors.grey[700],
              fontSize: 8,
            ),
            badgeWidget: points >= 20
                ? Text(
                    aspect[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  )
                : null,
            badgePositionPercentageOffset: 0.8,
            titlePositionPercentageOffset: points > 20 ? 1.1 : 1.5,
            radius: points * 1.25,
          ),
        );
      }
    }

    return sections;
  }

  Map<String, dynamic> getHazardPoints(Town town, String hazard) {
    switch (hazard) {
      case 'bushfire':
        return town.bushfire.toJson();
      case 'flood':
        return town.flood.toJson();
      case 'stormSurge':
        return town.stormSurge.toJson();
      case 'heatwave':
        return town.heatwave.toJson();
      case 'biohazard':
        return town.biohazard.toJson();
      default:
        throw ArgumentError('Unknown hazard: $hazard');
    }
  }

  List<BarChartGroupData> getAspectBarGroups(List<Town> towns) {
    const double barWidth = 22.0;
    List<int> sumAspects = List.filled(
        config.aspectIds.length, 0); // nature, economy, society, health

    for (var town in towns) {
      sumAspects[0] += town.bushfire.nature +
          town.flood.nature +
          town.stormSurge.nature +
          town.heatwave.nature +
          town.biohazard.nature;
      sumAspects[1] += town.bushfire.economy +
          town.flood.economy +
          town.stormSurge.economy +
          town.heatwave.economy +
          town.biohazard.economy;
      sumAspects[2] += town.bushfire.society +
          town.flood.society +
          town.stormSurge.society +
          town.heatwave.society +
          town.biohazard.society;
      sumAspects[3] += town.bushfire.health +
          town.flood.health +
          town.stormSurge.health +
          town.heatwave.health +
          town.biohazard.health;
    }

    return List.generate(
        sumAspects.length,
        (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  width: barWidth,
                  toY: sumAspects[i].toDouble(),
                  color: aspectColors[i],
                )
              ],
              showingTooltipIndicators: [0],
            ));
  }

  List<BarChartGroupData> getTownBarGroups(List<Town> towns) {
    const double barWidth = 22.0;
    return List.generate(towns.length, (i) {
      int totalPoints = 0;
      List<int> aspectPoints = List.filled(config.aspectIds.length, 0);

      void sumAspect(AbilityPoints ability) {
        aspectPoints[0] += ability.nature;
        aspectPoints[1] += ability.economy;
        aspectPoints[2] += ability.society;
        aspectPoints[3] += ability.health;
      }

      sumAspect(towns[i].bushfire);
      sumAspect(towns[i].flood);
      sumAspect(towns[i].stormSurge);
      sumAspect(towns[i].heatwave);
      sumAspect(towns[i].biohazard);

      totalPoints = aspectPoints.reduce((a, b) => a + b);

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            width: barWidth,
            toY: totalPoints.toDouble(),
            rodStackItems: List.generate(
                aspectPoints.length,
                (j) => BarChartRodStackItem(
                      j == 0
                          ? 0
                          : aspectPoints
                              .sublist(0, j)
                              .reduce((a, b) => a + b)
                              .toDouble(),
                      aspectPoints
                          .sublist(0, j + 1)
                          .reduce((a, b) => a + b)
                          .toDouble(),
                      aspectColors[j],
                    )),
          )
        ],
        showingTooltipIndicators: [0],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TownModel>(builder: (context, townModel, child) {
      final towns = townModel.towns;
      final aspectBarGroups = getAspectBarGroups(towns);
      final townBarGroups = getTownBarGroups(towns);
      final xAxisLabels = towns.map((town) => town.name).toList();

      double maxY1 = aspectBarGroups.fold(
          0,
          (max, group) =>
              group.barRods[0].toY > max ? group.barRods[0].toY : max);
      double maxY2 = townBarGroups.fold(
          0,
          (max, group) =>
              group.barRods[0].toY > max ? group.barRods[0].toY : max);

      return SizedBox(
        width: double.infinity,
        height: 450,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBarChart(
              barGroups: aspectBarGroups,
              xAxisLabels: config.aspectsTitle,
              maxY: 2000,
              title: 'Aspects Summary',
            ),
            SizedBox(width: 20),
            CustomBarChart(
              barGroups: townBarGroups,
              xAxisLabels: xAxisLabels,
              maxY: 2000,
              title: 'Towns Summary',
            ),
            SizedBox(
              width: 20,
            ),
            CustomPieChart(
                sections: getSections(GlobalDummyTown.town),
                title: 'BludgeTown',
                townColor: const Color(0xFF017f40))
          ],
        ),
      );
    });
  }
}
