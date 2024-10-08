import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/widgets/pie_chart_template.dart';
import 'package:provider/provider.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'dart:math' as math;

class PieChartsView extends StatelessWidget {
  PieChartsView({super.key});

  final List<String> aspects = ['nature', 'ecocomy', 'society', 'health'];
  final List<String> hazards = [
    'bushFire',
    'flood',
    'stormSurge',
    'heatwave',
    'biodiversity'
  ];

  final double titleFontSize = 12.0;

  List<PieChartSectionData> getSections(Town town) {
    final colors = [
      bushFireColor2,
      floodColor2,
      stormSurgeColor2,
      heatwaveColor2,
      biohazardColor2,
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
            title: '',
            badgeWidget: Text(
              aspect[0].toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
            ),
            badgePositionPercentageOffset: 0.55,
            radius: points * 1.25,
            showTitle: false,
          ),
        );
      }
    }

    return sections;
  }

  Map<String, dynamic> getHazardPoints(Town town, String hazard) {
    switch (hazard) {
      case 'bushFire':
        return town.bushFire.toJson();
      case 'flood':
        return town.flood.toJson();
      case 'stormSurge':
        return town.stormSurge.toJson();
      case 'heatwave':
        return town.heatwave.toJson();
      case 'biodiversity':
        return town.biodiversity.toJson();
      default:
        throw ArgumentError('Unknown hazard: $hazard');
    }
  }

  final townColors = [
    town1Color,
    town2Color,
    town3Color,
    town4Color,
    town5Color,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TownModel>(
      builder: (context, townModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            townModel.towns.length,
            (i) => CustomPieChart(
              sections: getSections(townModel.towns[i]),
              title: townModel.towns[i].name,
              townColor: i < townColors.length ? townColors[i] : Colors.grey,
              titleFontSize: titleFontSize,
            ),
          ),
        );
      },
    );
  }
}
