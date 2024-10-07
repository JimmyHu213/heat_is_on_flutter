import 'package:flutter/material.dart';

class TownPointsTable extends StatelessWidget {
  const TownPointsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: List<DataColumn>.generate(
          5, (index) => DataColumn(label: Text('Town ${index + 1}'))),
      rows: List<DataRow>.generate(
          5,
          (index) => DataRow(
              cells:
                  List<DataCell>.generate(5, (index) => DataCell(Text(''))))),
    );
  }
}
