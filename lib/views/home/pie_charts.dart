import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/widgets/pie_chart_template.dart';
import 'package:provider/provider.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;

class PieChartsView extends StatelessWidget {
  PieChartsView({super.key});

  final List<String> aspects = config.aspectIds;
  final List<String> hazards = config.hazardIds;

  final double titleFontSize = 12.0;

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
              townColor: Color(0xFF017f40),
              titleFontSize: titleFontSize,
            ),
          ),
        );
      },
    );
  }
}
