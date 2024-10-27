import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/model/hazard.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;

class GlobalRound {
  static int round = 0;

  static CollectionReference roundCollection =
      FirebaseFirestore.instance.collection('rounds');

  void incrementRound() {
    round++;
    uploadRound();
  }

  void resetRound() {
    round = 0;
    uploadRound();
  }

  int getRound() {
    fetchRound();
    return round;
  }

  //reset round to 0 if round is 5
  void checkRound() {
    if (round == 5) {
      resetRound();
    }
  }

  //upload round to firebase
  Future<void> uploadRound() async {
    try {
      await roundCollection.doc('currentRound').set({'round': round});
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchRound() async {
    try {
      final DocumentSnapshot documentSnapshot =
          await roundCollection.doc('currentRound').get();
      round = documentSnapshot.get('round');
    } catch (e) {
      print(e);
    }
  }
}

class GameLog {
  static TextEditingController logController = TextEditingController();

  void log(String message) {
    logController.text = message + '\n' + logController.text;
  }

  void clearLog() {
    logController.clear();
  }

  String getLog() {
    return logController.text;
  }
}

class EventLog {
  static Map<int, List<String>> eventLog = {1: [], 2: [], 3: [], 4: [], 5: []};

  static CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');

  //add event to event log
  void addEvent(int round, List<String> events) {
    if (eventLog[round] == null || round == 0) {
      return;
    }
    eventLog[round]!.addAll(events);
    uploadEventLog();
  }

  List<String> getEvents(int round) {
    fetchEventLog();
    return eventLog[round]!;
  }

  //get all events
  Map<int, List<String>> getEventLog() {
    fetchEventLog();
    return eventLog;
  }

  //clear event log
  void clearEventLog() {
    eventLog = {1: [], 2: [], 3: [], 4: [], 5: []};
    uploadEventLog();
  }

  //upload event log to firebase
  Future<void> uploadEventLog() async {
    try {
      await eventCollection.doc('eventLog').set({
        '1': eventLog[1],
        '2': eventLog[2],
        '3': eventLog[3],
        '4': eventLog[4],
        '5': eventLog[5],
      });
    } catch (e) {
      print(e);
    }
  }

  //fetch event log from firebase
  Future<void> fetchEventLog() async {
    try {
      final QuerySnapshot querySnapshot = await eventCollection.get();
      querySnapshot.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>;
        for (var i = 1; i <= 5; i++) {
          eventLog[i] = List<String>.from(data['$i']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

class GlobalDummyTown {
  static final CollectionReference _townCollection =
      FirebaseFirestore.instance.collection('dummy_town');
  static Town _town = Town.fromJson(config.town6);
  static Town get town => _town;

  Future<void> getTown() async {
    try {
      final DocumentSnapshot townDoc = await _townCollection.doc('6').get();
      _town = Town.fromJson(townDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTown(Town town) async {
    try {
      await _townCollection.doc(town.id).update(town.toJson());
    } catch (e) {
      print(e);
    }
    getTown();
  }

  //reset town to default values
  Future<void> resetTown() async {
    try {
      await _townCollection.doc('6').update(config.town6);
    } catch (e) {
      print(e);
    }
    getTown();
  }

  void applyHazard(Hazard hazard) {
    switch (hazard.id) {
      case 'bushfire':
        _applyHazardToAbility(_town.bushfire, hazard);
        break;
      case 'flood':
        _applyHazardToAbility(_town.flood, hazard);
        break;
      case 'stormSurge':
        _applyHazardToAbility(_town.stormSurge, hazard);
        break;
      case 'heatwave':
        _applyHazardToAbility(_town.heatwave, hazard);
        break;
      case 'biohazard':
        _applyHazardToAbility(_town.biohazard, hazard);
        break;
    }
    _applyPenaltyToOtherAbilities(_town);
    updateTown(_town);
  }

  void _applyHazardToAbility(AbilityPoints ability, Hazard hazard) {
    ability.nature -= hazard.nature;
    ability.economy -= hazard.economy;
    ability.society -= hazard.society;
    ability.health -= hazard.health;
  }

  void _applyPenaltyToOtherAbilities(Town town) {
    const int threshold = 20;
    const int penalty = 10;
    bool shouldApplyPenalty = false;

    // Check if any aspect of any ability is 20 or below
    List<AbilityPoints> allAbilities = [
      town.bushfire,
      town.flood,
      town.stormSurge,
      town.heatwave,
      town.biohazard
    ];

    for (var ability in allAbilities) {
      if (ability.nature <= threshold ||
          ability.economy <= threshold ||
          ability.society <= threshold ||
          ability.health <= threshold) {
        shouldApplyPenalty = true;
        break;
      }
    }

    // If any aspect is 20 or below, apply penalty to all aspects of all abilities
    if (shouldApplyPenalty) {
      for (var ability in allAbilities) {
        ability.nature -= penalty;
        ability.economy -= penalty;
        ability.society -= penalty;
        ability.health -= penalty;
      }
    }
  }
}
