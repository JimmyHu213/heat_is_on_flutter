// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/model/global_data.dart';
import 'package:heat_is_on_flutter/views/controls/town_points_table.dart';
import 'package:heat_is_on_flutter/widgets/center_view.dart';

class ControlView extends StatefulWidget {
  const ControlView({super.key});

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _currentRound = GlobalRound().getRound();
    final TextEditingController _logController = TextEditingController();
    var textStyleTitle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Controls',
          style: TextStyle(
            color: secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: CenterView(
          child: Row(
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Round: $_currentRound',
                          style: textStyleTitle,
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_currentRound == 5) {
                                    GlobalRound().resetRound();
                                  } else {
                                    GlobalRound().incrementRound();
                                  }
                                  setState(() {});
                                },
                                child: _currentRound == 0
                                    ? Text('Start Game')
                                    : Text('Next Round')),
                            ElevatedButton(
                                onPressed: () {
                                  GlobalRound().resetRound();
                                  setState(() {});
                                },
                                child: Text('Reset Game')),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Text('Town Names:', style: textStyleTitle),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ...List.generate(
                                5,
                                (index) => TownNameInput(
                                      textStyleTitle: textStyleTitle,
                                      townName: 'Town ${index + 1}',
                                    ))
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        TownPointsTable(),
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 11),
                            controller: _logController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              labelText: 'Game Logs',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                width: 1,
                thickness: 2,
                color: Colors.grey,
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add your right controls here
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TownNameInput extends StatelessWidget {
  const TownNameInput({
    super.key,
    required this.textStyleTitle,
    required this.townName,
  });

  final TextStyle textStyleTitle;
  final String townName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: textStyleTitle.fontSize! + 16,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: townName,
        ),
      ),
    );
  }
}
