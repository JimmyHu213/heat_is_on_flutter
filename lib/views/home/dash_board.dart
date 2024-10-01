import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/views/home/bars_charts.dart';
import 'package:heat_is_on_flutter/views/home/pie_charts.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Center(child: PieChartsView()),
          const SizedBox(height: 20),
          BarChartsView()
        ],
      ),
    );
  }
}
