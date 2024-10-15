import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

import 'package:heat_is_on_flutter/constants/app_colors.dart';

class CustomPieChart extends StatelessWidget {
  final List<PieChartSectionData> sections;
  final String title;
  final Color townColor;
  final double titleFontSize;

  const CustomPieChart({
    Key? key,
    required this.sections,
    required this.title,
    required this.townColor,
    this.titleFontSize = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;
    const double dangerRadius = 20 * 1.25; // Radius for the danger circle

    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      // Add danger circle overlay
                      CustomPaint(
                        size: const Size(280, 280),
                        painter: DangerCirclePainter(radius: dangerRadius),
                      ),
                    ],
                  ),
                ),
                // Add custom icons (unchanged)
                const Positioned(
                  top: 0,
                  right: 20,
                  child: Icon(Icons.local_fire_department,
                      color: bushfireColor1, size: iconSize),
                ),
                const Positioned(
                  left: 0,
                  bottom: 80,
                  child: Icon(Icons.wb_sunny,
                      color: heatwaveColor1, size: iconSize),
                ),
                const Positioned(
                  bottom: 0,
                  child: Icon(Icons.flood_outlined,
                      color: stormSurgeColor1, size: iconSize),
                ),
                const Positioned(
                  right: 0,
                  bottom: 80,
                  child: Icon(Icons.cloud, color: floodColor1, size: iconSize),
                ),
                const Positioned(
                  top: 0,
                  left: 20,
                  child: Icon(Icons.bug_report,
                      color: biohazardColor1, size: iconSize),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(townColor),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DangerCirclePainter extends CustomPainter {
  final double radius;

  DangerCirclePainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
