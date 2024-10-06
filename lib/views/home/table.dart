import 'package:flutter/material.dart';

class TableView extends StatelessWidget {
  TableView({super.key});

  final List<String> tableHeaders = [
    '',
    '2050',
    '2051',
    '2052',
    '2053',
    '2054',
    'Budget'
  ];

  final List<String> evenLog = [
    'Event Log',
    'BushFire',
    'Storm Surge',
    'Biohazard',
    'Heatwave',
    'Flood',
    ''
  ];

  final List<String> towns = [
    'town1',
    'town2',
    'town3',
    'town4',
    'town5',
  ];

  @override
  Widget build(BuildContext context) {
    final double fontSize = 20;

    return SizedBox(
        width: double.infinity,
        height: 600,
        child: Expanded(
            child: DataTable(
          dataRowMaxHeight: 80,
          headingRowColor: MaterialStateProperty.all(Colors.grey),
          border: TableBorder.all(
              color: Colors.white,
              width: 2,
              style: BorderStyle.solid,
              borderRadius: BorderRadius.circular(20)),
          columns: List<DataColumn>.generate(
              tableHeaders.length,
              (index) => DataColumn(
                    label: Text(
                      tableHeaders[index],
                      style: TextStyle(
                          fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                  )),
          rows: [
            DataRow(
                color: MaterialStateProperty.all(Colors.black54),
                cells: List<DataCell>.generate(
                    tableHeaders.length,
                    (index) => DataCell(Text(
                          evenLog[index],
                          style: TextStyle(color: Colors.white),
                        )))),
            ...List<DataRow>.generate(
                towns.length,
                (index) => DataRow(cells: [
                      ...List<DataCell>.generate(
                          tableHeaders.length,
                          (index) => DataCell(
                                Text(''),
                              ))
                    ])),
          ],
        )));
  }
}
