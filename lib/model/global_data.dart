import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/model/hazard.dart';

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

  //reset round to 1 if round is 5
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
