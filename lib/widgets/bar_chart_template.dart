import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';

class CustomBarChart extends StatelessWidget {
  final List<BarChartGroupData> barGroups;
  final List<String> xAxisLabels;
  final String title;
  final double maxY;

  const CustomBarChart({
    Key? key,
    required this.barGroups,
    required this.xAxisLabels,
    required this.maxY,
    this.title = 'Overall',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double interval = _calculateInterval(maxY);

    return AspectRatio(
      aspectRatio: 1.6,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 38),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: maxY,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${xAxisLabels[groupIndex]}\n',
                            const TextStyle(color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                text: rod.toY.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                xAxisLabels[value.toInt()],
                                style: const TextStyle(
                                  color: Colors.white, //Color(0xff7589a2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                          reservedSize: 38,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.white, //Color(0xff7589a2),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            );
                          },
                          reservedSize: 40,
                          interval: interval,
                        ),
                      ),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: barGroups,
                    gridData:
                        FlGridData(show: true, horizontalInterval: interval),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateInterval(double maxY) {
    if (maxY <= 100) return 20;
    if (maxY <= 500) return 100;
    if (maxY <= 1000) return 200;
    return (maxY / 5).roundToDouble();
  }
}
