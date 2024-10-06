import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/widgets/pie_chart_template.dart';

class PieChartsView extends StatelessWidget {
  const PieChartsView({super.key});

  List<PieChartSectionData> getSections() {
    final colors = [
      bushFireColor1,
      heatwaveColor1,
      stormSurgeColor1,
      floodColor1,
      biohazardColor1,
    ];

    return List.generate(20, (i) {
      //final isTouched = i == 2;
      final fontSize = 10.0;
      final radius = 100.0;
      //final widgetSize = isTouched ? 55.0 : 40.0;
      final color = colors[i ~/ 4];

      return PieChartSectionData(
        color: color,
        value: 1,
        title: '${i + 1}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomPieChart(
          sections: getSections(),
          title: 'Town 1',
        ),
        CustomPieChart(
          sections: getSections(),
          title: 'Town 2',
        ),
        CustomPieChart(
          sections: getSections(),
          title: 'Town 3',
        ),
        CustomPieChart(
          sections: getSections(),
          title: 'Town 4',
        ),
        CustomPieChart(
          sections: getSections(),
          title: 'Town 5',
        )
      ],
    );
  }
}
