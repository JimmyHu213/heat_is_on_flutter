import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;

class TownLog {
  final String townId;
  final Map<int, List<String>> cards;

  TownLog({
    required this.townId,
    this.cards = const {
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
    },
  });

  // create from json
  factory TownLog.fromJson(Map<String, dynamic> json) {
    var cardsData = json['cards'];
    Map<int, List<String>> convertedCards = {};

    cardsData.forEach((key, value) {
      // Convert the value to List<dynamic> first, then map to List<String>
      convertedCards[int.parse(key)] =
          (value as List<dynamic>).map((e) => e.toString()).toList();
    });

    return TownLog(
      townId: json['townId'],
      cards: convertedCards,
    );
  }

  // Convert to json
  Map<String, dynamic> toJson() {
    Map<String, List<dynamic>> convertedCards = {};

    cards.forEach((key, value) {
      // Convert the value to List<dynamic> first
      convertedCards[key.toString()] = value;
    });

    return {
      'townId': townId,
      'cards': convertedCards,
    };
  }

  TownLog copyWith({
    String? townId,
    Map<int, List<String>>? cards,
  }) {
    return TownLog(
      townId: townId ?? this.townId,
      cards: cards ?? Map<int, List<String>>.from(this.cards),
    );
  }

  @override
  String toString() {
    return 'TownLog{townId: $townId, cards: $cards}';
  }
}

class TownLogModel extends ChangeNotifier {
  final CollectionReference townLogCollection =
      FirebaseFirestore.instance.collection('townLogs');
  List<TownLog> townLogs = [];
  bool isLoading = false;
  // Fetch town logs from Firestore
  Future<void> fetchTownLogs() async {
    isLoading = true;
    try {
      final QuerySnapshot querySnapshot = await townLogCollection.get();
      townLogs = querySnapshot.docs
          .map((doc) => TownLog.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e);
    }
    //WAIT 2 SECONDS
    await Future.delayed(Duration(seconds: 2));
    isLoading = false;

    notifyListeners();
  }

  // Add card to town log
  Future<void> addCardToTownLog(String townId, int round, String card) async {
    try {
      final townLog =
          townLogs.firstWhere((element) => element.townId == townId);
      //append to the list of cards
      final cards = townLog.cards[round];
      cards!.add(card);
      await townLogCollection.doc(townId).update(townLog.toJson());
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  //reset towns
  Future<void> resetTownLogs() async {
    final List<TownLog> townLogs = [
      TownLog.fromJson(config.townLog1),
      TownLog.fromJson(config.townLog2),
      TownLog.fromJson(config.townLog3),
      TownLog.fromJson(config.townLog4),
      TownLog.fromJson(config.townLog5),
    ];
    try {
      for (var townLog in townLogs) {
        await townLogCollection.doc(townLog.townId).set(townLog.toJson());
      }
      this.townLogs = townLogs;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  //get town log by town id
  TownLog getTownLogByTownId(String townId) {
    return townLogs.firstWhere((element) => element.townId == townId);
  }

  // Delete town log from Firestore
  Future<void> deleteTownLog(String townId) async {
    try {
      await townLogCollection.doc(townId).delete();
      townLogs.removeWhere((element) => element.townId == townId);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
