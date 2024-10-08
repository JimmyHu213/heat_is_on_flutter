import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class CustomPieChart extends StatelessWidget {
  final List<PieChartSectionData> sections;
  final String title;
  final Color townColor;
  final double titleFontSize;

  const CustomPieChart({
    super.key,
    required this.sections,
    required this.title,
    required this.townColor,
    this.titleFontSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 280,
                height: 280,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sections: sections,
                        centerSpaceRadius: 0,
                        sectionsSpace: 2,
                        startDegreeOffset: -90,
                      ),
                    ),
                  ],
                ),
              ),
              // Add custom icons
              const Positioned(
                top: 0,
                left: 20,
                child: Icon(Icons.local_fire_department,
                    color: Colors.red, size: iconSize), //fire
              ),
              const Positioned(
                right: 20,
                top: 0,
                child: Icon(Icons.wb_sunny,
                    color: Colors.orange, size: iconSize), //heatwave
              ),
              const Positioned(
                bottom: 0,
                child: Icon(Icons.water_drop,
                    color: Colors.blue, size: iconSize), //water
              ),
              const Positioned(
                right: 0,
                bottom: 80,
                child: Icon(Icons.waves_outlined,
                    color: Colors.blueAccent, size: iconSize), //storm surge
              ),
              const Positioned(
                  bottom: 80,
                  left: 0,
                  child: Icon(Icons.bug_report,
                      color: Colors.green, size: iconSize)), //bioHazard
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(townColor)),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
