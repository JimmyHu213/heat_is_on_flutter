import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/model/global_data.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/widgets/custom_divider.dart';
import 'package:provider/provider.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;

class LeftPanel extends StatefulWidget {
  LeftPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<LeftPanel> createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  final TextEditingController _logController = GameLog.logController;

  @override
  Widget build(BuildContext context) {
    var textStyleTitle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    final _currentRound = GlobalRound().getRound();

    return Consumer<TownModel>(builder: (context, townModel, child) {
      return Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Round: $_currentRound',
                style: textStyleTitle,
              ),
              const CustomDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    )),
                    onPressed: () {
                      if (_currentRound == 5) {
                        GlobalRound().resetRound();
                      } else {
                        GlobalRound().incrementRound();
                      }
                      setState(() {
                        _logController.text = 'Round $_currentRound started\n' +
                            _logController.text;
                      });
                      // You might want to use a callback here to trigger a rebuild
                    },
                    child: Text(
                        _currentRound == 0 ? 'Start Game' : 'Next Round',
                        style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    )),
                    onPressed: () {
                      GlobalRound().resetRound();
                      townModel.resetTowns();
                      setState(() {
                        _logController.text = '';
                      });
                    },
                    child: Text('Reset Game', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const CustomDivider(),
              Text('Town Names:', style: textStyleTitle),
              const SizedBox(height: 16),
              TownNameInputs(
                  townModel: townModel, textStyleTitle: textStyleTitle),
              const CustomDivider(),
              TownPointsTable(towns: townModel.towns),
              const CustomDivider(),
              Expanded(
                child: GameLogTextField(controller: _logController),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TownNameInputs extends StatelessWidget {
  final TownModel townModel;
  final TextStyle textStyleTitle;

  const TownNameInputs({
    Key? key,
    required this.townModel,
    required this.textStyleTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        townModel.towns.length,
        (index) => TownNameInput(
          textStyleTitle: textStyleTitle,
          town: townModel.towns[index],
          onNameChanged: (newName) async {
            if (newName != townModel.towns[index].name) {
              var town = townModel.towns[index];
              town.name = newName;
              await townModel.updateTown(town);
            }
          },
        ),
      ),
    );
  }
}

class TownNameInput extends StatefulWidget {
  const TownNameInput({
    Key? key,
    required this.town,
    required this.textStyleTitle,
    required this.onNameChanged,
  }) : super(key: key);

  final Town town;
  final TextStyle textStyleTitle;
  final Function(String) onNameChanged;

  @override
  _TownNameInputState createState() => _TownNameInputState();
}

class _TownNameInputState extends State<TownNameInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.town.name;

    return SizedBox(
      width: 120,
      height: widget.textStyleTitle.fontSize! + 60,
      child: Column(
        children: [
          TextField(
            maxLines: 1,
            controller: _controller,
            onEditingComplete: () {
              widget.onNameChanged(_controller.text);
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Town Name',
            ),
          ),
          Text('Effort Points: ${widget.town.effortPoints}',
              style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class GameLogTextField extends StatelessWidget {
  final TextEditingController controller;

  const GameLogTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TownModel>(builder: (context, townModel, child) {
      return TextField(
        style: const TextStyle(fontSize: 11),
        controller: controller,
        readOnly: true,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          labelText: 'Game Logs',
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
        ),
      );
    });
  }
}

// Implement TownPointsTable as before
class TownPointsTable extends StatelessWidget {
  final List<Town> towns;

  const TownPointsTable({Key? key, required this.towns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TownModel>(builder: (context, townModel, child) {
      return Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 2,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              const TableCell(child: Center(child: Text('Hazard'))),
              const TableCell(child: Center(child: Text('Aspect'))),
              ...towns
                  .map((town) =>
                      TableCell(child: Center(child: Text(town.name))))
                  .toList(),
            ],
          ),
          ...config.hazardIds.expand((hazard) {
            return config.aspectIds.map((aspect) {
              return TableRow(
                children: [
                  TableCell(child: Center(child: Text(hazard))),
                  TableCell(child: Center(child: Text(aspect))),
                  ...towns.map((town) {
                    var points = town.toJson()[hazard][aspect];
                    return TableCell(
                        child: Center(child: Text(points.toString())));
                  }).toList(),
                ],
              );
            });
          }).toList(),
        ],
      );
    });
  }
}
