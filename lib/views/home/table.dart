import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:provider/provider.dart';

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

  final List<String> evenLog = ['Event Log', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    const double fontSize = 20;
    const textStyle = TextStyle(color: Colors.white, fontSize: 16);

    return Consumer<TownModel>(builder: (context, townModel, child) {
      return SizedBox(
          width: double.infinity,
          height: 600,
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
                  cells: List<DataCell>.generate(tableHeaders.length, (index) {
                    return DataCell(Text(
                      evenLog[index],
                      style: textStyle,
                    ));
                  })),
              ...List<DataRow>.generate(
                  townModel.towns.length,
                  (index) => DataRow(cells: [
                        DataCell(Text(
                          townModel.towns[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )),
                        ...List<DataCell>.generate(
                            tableHeaders.length - 2,
                            (index) => DataCell(
                                  Text(''),
                                )),
                        DataCell(TextField(
                          controller: TextEditingController(
                              text: townModel.towns[index].effortPoints
                                  .toString()),
                          onSubmitted: (value) {
                            var town = townModel.towns[index];
                            town.effortPoints = int.parse(value);
                            townModel.updateTown(townModel.towns[index]);
                          },
                          style: textStyle,
                        )),
                      ])),
            ],
          ));
    });
  }
}
