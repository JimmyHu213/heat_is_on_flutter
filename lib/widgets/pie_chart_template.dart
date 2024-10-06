import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';

class CustomPieChart extends StatelessWidget {
  final List<PieChartSectionData> sections;
  final String title;

  CustomPieChart({required this.sections, required this.title});

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
              Positioned(
                top: 0,
                right: 20,
                child: Icon(Icons.water_drop,
                    color: Colors.blue, size: iconSize), //water
              ),
              Positioned(
                right: 0,
                bottom: 80,
                child: Icon(Icons.local_fire_department,
                    color: Colors.red, size: iconSize), //fire
              ),
              Positioned(
                bottom: 0,
                child: Icon(Icons.cloud,
                    color: Colors.grey, size: iconSize), //storm surge
              ),
              Positioned(
                left: 0,
                bottom: 80,
                child: Icon(Icons.wb_sunny,
                    color: Colors.orange, size: iconSize), //heatwave
              ),
              Positioned(
                  top: 0,
                  left: 20,
                  child: Icon(Icons.bug_report,
                      color: Colors.green, size: iconSize)), //bioHazard
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(primaryColorLight)),
            ),
          ),
        ],
      ),
    );
  }
}
