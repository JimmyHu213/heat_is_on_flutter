import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/views/home/bars_charts.dart';
import 'package:heat_is_on_flutter/views/home/pie_charts.dart';
import 'package:heat_is_on_flutter/views/home/table.dart';
import 'package:heat_is_on_flutter/views/layout/footer.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PieChartsView(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BarChartsView(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TableView(),
          ),
          const SizedBox(height: 20),
          const Footer()
        ],
      ),
    );
  }
}
