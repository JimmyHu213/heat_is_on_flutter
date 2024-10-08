import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;
// ignore_for_file: non_constant_identifier_names

class AbilityPoints {
  final int nature;
  final int ecocomy;
  final int society;
  final int health;

  AbilityPoints({
    required this.nature,
    required this.ecocomy,
    required this.society,
    required this.health,
  });

  Map<String, dynamic> toJson() {
    return {
      'nature': nature,
      'ecocomy': ecocomy,
      'society': society,
      'health': health,
    };
  }
}

class Town {
  final String id;
  final String name;
  final int effortPoints;
  final AbilityPoints bushFire;
  final AbilityPoints flood;
  final AbilityPoints stormSurge;
  final AbilityPoints heatwave;
  final AbilityPoints biodiversity;

// add requried field to all the fields
  Town({
    required this.id,
    required this.name,
    required this.effortPoints,
    required this.bushFire,
    required this.flood,
    required this.stormSurge,
    required this.heatwave,
    required this.biodiversity,
  });

  //add fromJson and toJson methods
  factory Town.fromJson(Map<String, dynamic> json) {
    return Town(
      id: json['id'],
      name: json['name'],
      effortPoints: json['effortPoints'],
      bushFire: AbilityPoints(
        nature: json['bushFire']['nature'],
        ecocomy: json['bushFire']['ecocomy'],
        society: json['bushFire']['society'],
        health: json['bushFire']['health'],
      ),
      flood: AbilityPoints(
        nature: json['flood']['nature'],
        ecocomy: json['flood']['ecocomy'],
        society: json['flood']['society'],
        health: json['flood']['health'],
      ),
      stormSurge: AbilityPoints(
        nature: json['stormSurge']['nature'],
        ecocomy: json['stormSurge']['ecocomy'],
        society: json['stormSurge']['society'],
        health: json['stormSurge']['health'],
      ),
      heatwave: AbilityPoints(
        nature: json['heatwave']['nature'],
        ecocomy: json['heatwave']['ecocomy'],
        society: json['heatwave']['society'],
        health: json['heatwave']['health'],
      ),
      biodiversity: AbilityPoints(
        nature: json['biodiversity']['nature'],
        ecocomy: json['biodiversity']['ecocomy'],
        society: json['biodiversity']['society'],
        health: json['biodiversity']['health'],
      ),
    );
  }

  //add a toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'effortPoints': effortPoints,
      'bushFire': {
        'nature': bushFire.nature,
        'ecocomy': bushFire.ecocomy,
        'society': bushFire.society,
        'health': bushFire.health,
      },
      'flood': {
        'nature': flood.nature,
        'ecocomy': flood.ecocomy,
        'society': flood.society,
        'health': flood.health,
      },
      'stormSurge': {
        'nature': stormSurge.nature,
        'ecocomy': stormSurge.ecocomy,
        'society': stormSurge.society,
        'health': stormSurge.health,
      },
      'heatwave': {
        'nature': heatwave.nature,
        'ecocomy': heatwave.ecocomy,
        'society': heatwave.society,
        'health': heatwave.health,
      },
      'biodiversity': {
        'nature': biodiversity.nature,
        'ecocomy': biodiversity.ecocomy,
        'society': biodiversity.society,
        'health': biodiversity.health,
      },
    };
  }
}

//add a class townModel extended with changeNotifier to connect with the firebase
class TownModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _townCollection =
      FirebaseFirestore.instance.collection('towns');
  List<Town> _towns = [];
  bool isLoading = false;

  List<Town> get towns => _towns;

  Future<void> fetchTowns() async {
    isLoading = true;
    final QuerySnapshot snapshot = await _townCollection.get();
    _towns = snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Town.fromJson(data);
    }).toList();
    isLoading = false;
    notifyListeners();
  }

  //add a method to get the town by id
  Town getTownById(String id) {
    return _towns.firstWhere((Town town) => town.id == id);
  }

  //add a method to update the town
  Future<void> updateTown(Town town) async {
    final DocumentReference docRef = _townCollection.doc(town.id);
    await docRef.update(town.toJson());
    await fetchTowns();
    notifyListeners();
  }

  //add a method to reset the town
  Future<void> resetTowns() async {
    final configTowns = [
      config.town1,
      config.town2,
      config.town3,
      config.town4,
      config.town5,
    ];

    for (var configTown in configTowns) {
      final town = Town.fromJson(configTown);
      await _townCollection.doc(town.id).set(town.toJson());
    }

    await fetchTowns();
    notifyListeners();
  }

  //add a method to add the town
  Future<void> addOrUpdateTown(Town town) async {
    final DocumentReference docRef = _townCollection.doc(town.id);
    final DocumentSnapshot docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      // If the document exists, update it
      await docRef.update(town.toJson());
    } else {
      // If the document doesn't exist, create a new one with the given ID
      await docRef.set(town.toJson());
    }
    await fetchTowns();
    notifyListeners();
  }

  // Add a new method to check if a town with a given ID exists
  Future<bool> townExists(String id) async {
    final DocumentSnapshot docSnapshot = await _townCollection.doc(id).get();
    return docSnapshot.exists;
  }
}
