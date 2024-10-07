import 'package:flutter/material.dart';

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
