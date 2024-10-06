import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/views/home/bars_charts.dart';
import 'package:heat_is_on_flutter/views/home/pie_charts.dart';
import 'package:heat_is_on_flutter/views/home/table.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          PieChartsView(),
          SizedBox(height: 20),
          TableView(),
          const SizedBox(height: 20),
          BarChartsView()
        ],
      ),
    );
  }
}
