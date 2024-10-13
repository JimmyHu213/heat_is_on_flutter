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

class EventLog {
  Map<int, List<Hazard>> events;

  EventLog({
    required this.events,
  });
}

class GameLog {
  static TextEditingController logController = TextEditingController();
}
