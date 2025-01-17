import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/model/global_data.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/model/town_log.dart';
import 'package:provider/provider.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;

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

  final EventLog eventLog = EventLog();

  @override
  Widget build(BuildContext context) {
    const double fontSize = 20;
    const textStyle = TextStyle(color: Colors.white, fontSize: 16);
    const textStyleSmall = TextStyle(color: Colors.white, fontSize: 12);
    final townLogModel = Provider.of<TownLogModel>(context);

    return Consumer<TownModel>(builder: (context, townModel, child) {
      return SizedBox(
          width: double.infinity,
          height: 700,
          child: DataTable(
            dataRowMaxHeight: 100,
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
                        style: const TextStyle(
                            fontSize: fontSize, fontWeight: FontWeight.bold),
                      ),
                    )),
            rows: [
              DataRow(color: MaterialStateProperty.all(Colors.black45), cells: [
                const DataCell(Text(
                  'Event',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                )),
                ...List<DataCell>.generate(tableHeaders.length - 2, (index) {
                  var events = eventLog.getEvents(index + 1);
                  var icons = [];
                  if (events.isNotEmpty) {
                    icons = events.map((e) => config.eventIcons[e]).toList();
                  }
                  return icons.isEmpty
                      ? const DataCell(Text(''))
                      : DataCell(
                          Row(
                            children: [...icons],
                          ),
                        );
                }),
                const DataCell(Text(
                  '',
                  style: textStyle,
                )),
              ]),
              ...List<DataRow>.generate(
                townModel.towns.length,
                (index) {
                  var town = townModel.towns[index];
                  return DataRow(cells: [
                    DataCell(Text(
                      town.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
                    ...List<DataCell>.generate(tableHeaders.length - 2,
                        (index2) {
                      var townLog = townLogModel.getTownLogByTownId(town.id);
                      var cards = townLog.cards[index2 + 1]!;
                      return cards.isEmpty
                          ? DataCell(Text(
                              ' ',
                              style: textStyle,
                            ))
                          : DataCell(
                              Column(
                                children: cards
                                    .map((e) =>
                                        Text('$e', style: textStyleSmall))
                                    .toList(),
                              ),
                            );
                    }),
                    DataCell(TextField(
                      controller: TextEditingController(
                          text: townModel.towns[index].effortPoints.toString()),
                      onSubmitted: (value) {
                        var town = townModel.towns[index];
                        town.effortPoints = int.parse(value);
                        townModel.updateTown(townModel.towns[index]);
                      },
                      style: textStyle,
                    )),
                  ]);
                },
              )
            ],
          ));
    });
  }
}
