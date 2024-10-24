import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;
import 'package:heat_is_on_flutter/model/card.dart';
import 'package:heat_is_on_flutter/model/global_data.dart';
import 'package:heat_is_on_flutter/model/hazard.dart';

// ignore_for_file: non_constant_identifier_names
class AbilityPoints {
  int _nature;
  int _economy;
  int _society;
  int _health;

  AbilityPoints({
    required int nature,
    required int economy,
    required int society,
    required int health,
  })  : _nature = _clamp(nature),
        _economy = _clamp(economy),
        _society = _clamp(society),
        _health = _clamp(health);

  static int _clamp(int value) {
    return value.clamp(0, 100);
  }

  int get nature => _nature;
  int get economy => _economy;
  int get society => _society;
  int get health => _health;

  set nature(int value) {
    _nature = _clamp(value);
  }

  set economy(int value) {
    _economy = _clamp(value);
  }

  set society(int value) {
    _society = _clamp(value);
  }

  set health(int value) {
    _health = _clamp(value);
  }

  Map<String, dynamic> toJson() {
    return {
      'nature': _nature,
      'economy': _economy,
      'society': _society,
      'health': _health,
    };
  }

  @override
  String toString() {
    return 'AbilityPoints{nature: $_nature, economy: $_economy, society: $_society, health: $_health}';
  }
}

class Town {
  final String id;
  String name;
  int effortPoints;
  AbilityPoints bushfire;
  AbilityPoints flood;
  AbilityPoints stormSurge;
  AbilityPoints heatwave;
  AbilityPoints biohazard;
// add requried field to all the fields
  Town({
    required this.id,
    required this.name,
    required this.effortPoints,
    required this.bushfire,
    required this.flood,
    required this.stormSurge,
    required this.heatwave,
    required this.biohazard,
  });

  //add fromJson and toJson methods
  factory Town.fromJson(Map<String, dynamic> json) {
    return Town(
      id: json['id'],
      name: json['name'],
      effortPoints: json['effortPoints'],
      bushfire: AbilityPoints(
        nature: json['bushfire']['nature'],
        economy: json['bushfire']['economy'],
        society: json['bushfire']['society'],
        health: json['bushfire']['health'],
      ),
      flood: AbilityPoints(
        nature: json['flood']['nature'],
        economy: json['flood']['economy'],
        society: json['flood']['society'],
        health: json['flood']['health'],
      ),
      stormSurge: AbilityPoints(
        nature: json['stormSurge']['nature'],
        economy: json['stormSurge']['economy'],
        society: json['stormSurge']['society'],
        health: json['stormSurge']['health'],
      ),
      heatwave: AbilityPoints(
        nature: json['heatwave']['nature'],
        economy: json['heatwave']['economy'],
        society: json['heatwave']['society'],
        health: json['heatwave']['health'],
      ),
      biohazard: AbilityPoints(
        nature: json['biohazard']['nature'],
        economy: json['biohazard']['economy'],
        society: json['biohazard']['society'],
        health: json['biohazard']['health'],
      ),
    );
  }

  //add a toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'effortPoints': effortPoints,
      'bushfire': {
        'nature': bushfire.nature,
        'economy': bushfire.economy,
        'society': bushfire.society,
        'health': bushfire.health,
      },
      'flood': {
        'nature': flood.nature,
        'economy': flood.economy,
        'society': flood.society,
        'health': flood.health,
      },
      'stormSurge': {
        'nature': stormSurge.nature,
        'economy': stormSurge.economy,
        'society': stormSurge.society,
        'health': stormSurge.health,
      },
      'heatwave': {
        'nature': heatwave.nature,
        'economy': heatwave.economy,
        'society': heatwave.society,
        'health': heatwave.health,
      },
      'biohazard': {
        'nature': biohazard.nature,
        'economy': biohazard.economy,
        'society': biohazard.society,
        'health': biohazard.health,
      },
    };
  }

  @override
  String toString() {
    return 'Town{id: $id, name: $name, effortPoints: $effortPoints, bushfire: $bushfire, flood: $flood, stormSurge: $stormSurge, heatwave: $heatwave, biohazard: $biohazard}';
  }
}

//add a class townModel extended with changeNotifier to connect with the firebase
class TownModel extends ChangeNotifier {
  final CollectionReference _townCollection =
      FirebaseFirestore.instance.collection('towns');
  List<Town> _towns = [];
  bool isLoading = false;

  List<Town> get towns => _towns;

  Future<void> fetchTowns() async {
    isLoading = true;
    final snapshot = await _townCollection.get();
    _towns = snapshot.docs
        .map((doc) => Town.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    //WAIT TWO SECONDS
    //await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }

  Town getTownById(String id) => _towns.firstWhere((town) => town.id == id);

  Future<void> updateTown(Town town) async {
    await _townCollection.doc(town.id).update(town.toJson());
    await fetchTowns();
  }

  Future<void> resetTowns() async {
    for (var configTown in [
      config.town1,
      config.town2,
      config.town3,
      config.town4,
      config.town5
    ]) {
      var town = Town.fromJson(configTown);
      await _townCollection.doc(town.id).set(town.toJson());
    }
    await fetchTowns();
  }

  Future<void> addOrUpdateTown(Town town) async {
    await _townCollection
        .doc(town.id)
        .set(town.toJson(), SetOptions(merge: true));
    await fetchTowns();
  }

  void applyAbility(String townId, GameCard card) {
    final town = getTownById(townId);
    final abilities = [
      town.bushfire,
      town.flood,
      town.stormSurge,
      town.heatwave,
      town.biohazard
    ];

    if (['bushfire', 'flood', 'stormSurge', 'heatwave', 'biohazard']
        .contains(card.type)) {
      _updateAbility(
          abilities[['bushfire', 'flood', 'stormSurge', 'heatwave', 'biohazard']
              .indexOf(card.type)],
          card);
    } else {
      abilities.forEach(
          (ability) => _updateAbility(ability, card, onlyAspect: card.type));
    }
    updateTown(town);
  }

  void _updateAbility(AbilityPoints ability, GameCard card,
      {String? onlyAspect}) {
    if (onlyAspect == null || onlyAspect == 'nature') {
      ability.nature += card.nature;
    }
    if (onlyAspect == null || onlyAspect == 'economy') {
      ability.economy += card.economy;
    }
    if (onlyAspect == null || onlyAspect == 'society') {
      ability.society += card.society;
    }
    if (onlyAspect == null || onlyAspect == 'health') {
      ability.health += card.health;
    }
  }

  void applyHazard(Hazard hazard) {
    for (var town in towns) {
      final ability = _getAbilityForHazard(town, hazard.id);

      _applyHazardToAbility(ability, hazard);
      _applyPenaltyToOtherAbilities(town);
    }
    updateAllTowns(towns);
  }

  AbilityPoints _getAbilityForHazard(Town town, String hazardId) {
    switch (hazardId) {
      case 'bushfire':
        return town.bushfire;
      case 'flood':
        return town.flood;
      case 'stormSurge':
        return town.stormSurge;
      case 'heatwave':
        return town.heatwave;
      case 'biohazard':
        return town.biohazard;
      default:
        throw ArgumentError('Invalid hazard ID');
    }
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

  Future<void> updateAllTowns(List<Town> towns) async {
    await Future.wait(towns
        .map((town) => _townCollection.doc(town.id).update(town.toJson())));
    await fetchTowns();
  }
}
