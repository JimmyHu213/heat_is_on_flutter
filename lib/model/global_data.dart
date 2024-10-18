import 'dart:html';

import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/model/hazard.dart';

class GlobalRound {
  static int round = 0;

  void incrementRound() {
    round++;
  }

  void resetRound() {
    round = 0;
  }

  int getRound() {
    return round;
  }

  //reset round to 1 if round is 5
  void checkRound() {
    if (round == 5) {
      resetRound();
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
  static Map<int, List<Hazard>> eventLog = {1: [], 2: [], 3: [], 4: [], 5: []};

  void addEvent(int round, List<Hazard> hazards) {
    if (round == 0) {
      return;
    }
    eventLog[round]!.addAll(hazards);
  }

  void clearEventLog() {
    eventLog.clear();
  }

  List<Hazard> getEvent(int round) {
    return eventLog[round]!;
  }

  Map<int, List<Hazard>> getEventLog() {
    return eventLog;
  }
}
