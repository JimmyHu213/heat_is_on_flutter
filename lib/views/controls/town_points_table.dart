import 'package:flutter/material.dart';

class TownPointsTable extends StatelessWidget {
  TownPointsTable({
    super.key,
  });

  final headerLabel = ['', 'Town 1', 'Town 2', 'Town 3', 'Town 4', 'Town 5'];
  final rowLabel = [
    'BN',
    'BE',
    'BS',
    'BH',
    'FN',
    'FE',
    'FS',
    'FH',
    'SN',
    'SE',
    'SS',
    'SH',
    'HN',
    'HE',
    'HS',
    'HH',
    'BiN',
    'BiE',
    'BiS',
    'BiH'
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: List<DataColumn>.generate(headerLabel.length,
          (index) => DataColumn(label: Text(headerLabel[index]))),
      rows: List<DataRow>.generate(
          20,
          (index) => DataRow(cells: [
                DataCell(Text(rowLabel[index])),
                ...List<DataCell>.generate(5, (index) => DataCell(Text('80')))
              ])),
    );
  }
}
