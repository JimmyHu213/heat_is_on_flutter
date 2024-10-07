import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';

class CustomPieChart extends StatelessWidget {
  final List<PieChartSectionData> sections;
  final String title;
  final Color townColor;

  CustomPieChart(
      {required this.sections, required this.title, required this.townColor});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;
    const double fontSize = 20.0;

    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      //color: primaryColor,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 280,
                height: 280,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 0,
                    sectionsSpace: 2,
                    startDegreeOffset: -90,
                  ),
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
                child: Icon(Icons.cloud,
                    color: Colors.grey, size: iconSize), //storm surge
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
