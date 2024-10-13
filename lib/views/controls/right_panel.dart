import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/model/card.dart';
import 'package:heat_is_on_flutter/model/global_data.dart';
import 'package:heat_is_on_flutter/model/hazard.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/widgets/custom_divider.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;
import 'package:provider/provider.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({
    super.key,
  });

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  @override
  Widget build(BuildContext context) {
    var textStyleTitle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hazard: ', style: textStyleTitle),
            HazardGrid(),
            const CustomDivider(),
            Text('Adaption Cards:', style: textStyleTitle),
            AbilitiesGrid(),
            const CustomDivider(),
            Text('All-Adaption Cards:', style: textStyleTitle),
            AllAbilitiesGrid(),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }
}

class HazardGrid extends StatelessWidget {
  HazardGrid({
    super.key,
  });

  final TextEditingController _logController = GameLog.logController;

  @override
  Widget build(BuildContext context) {
    final townModel = Provider.of<TownModel>(context);

    return SizedBox(
      height: 150,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          var hazards = Hazard.getDefaultHazards(config.hazards);
          var hazard = hazards[index];
          return AbilityTile(
            hazard: hazard,
            onPressed: () {
              _logController.text =
                  'Hazard ${hazard.name} Happended\n${_logController.text}';
              townModel.applyHazard(hazards[index]);
            },
          );
        },
      ),
    );
  }
}

class AbilitiesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final townModel = Provider.of<TownModel>(context);
    return Consumer<TownModel>(builder: (context, townModel, child) {
      return SizedBox(
        height: 600,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemCount: 15,
          itemBuilder: (context, index) {
            var cards = GameCard.getDefaultCards(config.cards);
            var card = cards[index];
            return AbilityTile2(
              card: card,
              onPressed: (String townId) {
                townModel.applyAbility(townId, card);
              },
            );
          },
        ),
      );
    });
  }
}

class AllAbilitiesGrid extends StatelessWidget {
  //final TextEditingController _controller = GameLog.logController;

  @override
  Widget build(BuildContext context) {
    final townModel = Provider.of<TownModel>(context);
    return SizedBox(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: config.allAbilityCards.length,
        itemBuilder: (context, index) {
          var cards = GameCard.getDefaultCards(config.allAbilityCards);
          var card = cards[index];
          return AbilityTile2(
            card: card,
            onPressed: (String townId) {
              townModel.applyAbility(townId, card);
            },
          );
        },
      ),
    );
  }
}

class AbilityTile extends StatelessWidget {
  final Hazard hazard;
  final VoidCallback onPressed;

  const AbilityTile({
    Key? key,
    required this.hazard,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            hazard.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class AbilityTile2 extends StatefulWidget {
  final GameCard card;
  final Function(String) onPressed;

  const AbilityTile2({
    Key? key,
    required this.card,
    required this.onPressed,
  }) : super(key: key);

  @override
  _AbilityTile2State createState() => _AbilityTile2State();
}

class _AbilityTile2State extends State<AbilityTile2> {
  String? selectedTownId;

  void _showConfirmationDialog(BuildContext context, GameCard card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adaption Card'),
          content: Text('${card.toString()}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final townModel = Provider.of<TownModel>(context);
    final towns = townModel.towns;

    return Card(
      child: InkWell(
        onTap: () {
          _showConfirmationDialog(context, widget.card);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.card.id,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: selectedTownId,
                hint: Text('Select Town'),
                isExpanded: true,
                items: towns.map((Town town) {
                  return DropdownMenuItem<String>(
                    value: town.id,
                    child: Text(town.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTownId = newValue;
                  });
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: selectedTownId != null
                    ? () {
                        // update town with card
                        widget.onPressed(selectedTownId!);
                      }
                    : null,
                child: Text('Apply'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
