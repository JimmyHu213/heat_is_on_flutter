import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
}

//add a class townModel extended with changeNotifier to connect with the firebase
class TownModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _townCollection =
      FirebaseFirestore.instance.collection('towns');
  List<Town> _towns = [];

  List<Town> get towns => _towns;
  //create two example towns
  // final Town town1 = Town(
  //   id: '1',
  //   name: 'Town 1',
  //   effortPoints: 0,
  //   bushFire: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   flood: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   stormSurge: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   heatwave: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   biodiversity: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  // );
  // final Town town2 = Town(
  //   id: '2',
  //   name: 'Town 2',
  //   effortPoints: 0,
  //   bushFire: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   flood: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   stormSurge: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   heatwave: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  //   biodiversity: AbilityPoints(nature: 0, ecocomy: 0, society: 0, health: 0),
  // );

  Future<void> fetchTowns() async {
    final QuerySnapshot snapshot = await _townCollection.get();
    _towns = snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Town(
        id: doc.id,
        name: data['name'],
        effortPoints: data['effortPoints'],
        bushFire: AbilityPoints(
          nature: data['bushFire']['nature'],
          ecocomy: data['bushFire']['ecocomy'],
          society: data['bushFire']['society'],
          health: data['bushFire']['health'],
        ),
        flood: AbilityPoints(
          nature: data['flood']['nature'],
          ecocomy: data['flood']['ecocomy'],
          society: data['flood']['society'],
          health: data['flood']['health'],
        ),
        stormSurge: AbilityPoints(
          nature: data['stormSurge']['nature'],
          ecocomy: data['stormSurge']['ecocomy'],
          society: data['stormSurge']['society'],
          health: data['stormSurge']['health'],
        ),
        heatwave: AbilityPoints(
          nature: data['heatwave']['nature'],
          ecocomy: data['heatwave']['ecocomy'],
          society: data['heatwave']['society'],
          health: data['heatwave']['health'],
        ),
        biodiversity: AbilityPoints(
          nature: data['biodiversity']['nature'],
          ecocomy: data['biodiversity']['ecocomy'],
          society: data['biodiversity']['society'],
          health: data['biodiversity']['health'],
        ),
      );
    }).toList();
    notifyListeners();
  }

  //add a method to get the town by id
  Town getTownById(String id) {
    return _towns.firstWhere((Town town) => town.id == id);
  }

  //add a method to update the town
  Future<void> updateTown(Town town) async {
    await _townCollection.doc(town.id).update({
      'effortPoints': town.effortPoints,
      'bushFire': {
        'nature': town.bushFire.nature,
        'ecocomy': town.bushFire.ecocomy,
        'society': town.bushFire.society,
        'health': town.bushFire.health,
      },
      'flood': {
        'nature': town.flood.nature,
        'ecocomy': town.flood.ecocomy,
        'society': town.flood.society,
        'health': town.flood.health,
      },
      'stormSurge': {
        'nature': town.stormSurge.nature,
        'ecocomy': town.stormSurge.ecocomy,
        'society': town.stormSurge.society,
        'health': town.stormSurge.health,
      },
      'heatwave': {
        'nature': town.heatwave.nature,
        'ecocomy': town.heatwave.ecocomy,
        'society': town.heatwave.society,
        'health': town.heatwave.health,
      },
      'biodiversity': {
        'nature': town.biodiversity.nature,
        'ecocomy': town.biodiversity.ecocomy,
        'society': town.biodiversity.society,
        'health': town.biodiversity.health,
      },
    });
    notifyListeners();
  }

  //add a method to reset the town
  Future<void> resetTown(Town town) async {
    await _townCollection.doc(town.id).update({
      'effortPoints': 0,
      'bushFire': {
        'nature': 0,
        'ecocomy': 0,
        'society': 0,
        'health': 0,
      },
      'flood': {
        'nature': 0,
        'ecocomy': 0,
        'society': 0,
        'health': 0,
      },
      'stormSurge': {
        'nature': 0,
        'ecocomy': 0,
        'society': 0,
        'health': 0,
      },
      'heatwave': {
        'nature': 0,
        'ecocomy': 0,
        'society': 0,
        'health': 0,
      },
      'biodiversity': {
        'nature': 0,
        'ecocomy': 0,
        'society': 0,
        'health': 0,
      },
    });
    notifyListeners();
  }
}
