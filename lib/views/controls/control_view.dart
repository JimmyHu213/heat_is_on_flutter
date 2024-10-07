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
      body: SingleChildScrollView(
        child: CenterView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height),
            child: IntrinsicHeight(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Abilities:', style: textStyleTitle),
                            SizedBox(
                              height: 600,
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.5,
                                ),
                                itemCount: 15, // 5 rows * 3 columns
                                itemBuilder: (context, index) {
                                  return AbilityTile(
                                    abilityName: 'Ability ${index + 1}',
                                    onPressed: () {
                                      // Handle ability tile press
                                      print('Ability ${index + 1} pressed');
                                    },
                                  );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                            Text('All Abilities:', style: textStyleTitle),
                            SizedBox(
                              height: 200,
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.5,
                                ),
                                itemCount: 4, // 5 rows * 3 columns
                                itemBuilder: (context, index) {
                                  return AbilityTile(
                                    abilityName: 'Ability ${index + 1}',
                                    onPressed: () {
                                      // Handle ability tile press
                                      print('Ability ${index + 1} pressed');
                                    },
                                  );
                                },
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                            Text(
                              'Hazard: ',
                              style: textStyleTitle,
                            ),
                            SizedBox(
                              height: 200,
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.5,
                                ),
                                itemCount: 5, // 5 rows * 3 columns
                                itemBuilder: (context, index) {
                                  return AbilityTile(
                                    abilityName: 'Ability ${index + 1}',
                                    onPressed: () {
                                      // Handle ability tile press
                                      print('Hazard ${index + 1} pressed');
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      height: textStyleTitle.fontSize! + 50,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: townName,
            ),
          ),
          Text('Points: 100', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class AbilityTile extends StatelessWidget {
  final String abilityName;
  final VoidCallback onPressed;

  const AbilityTile({
    Key? key,
    required this.abilityName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            abilityName,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
