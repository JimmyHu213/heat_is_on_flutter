import 'package:heat_is_on_flutter/model/town.dart';

class Hazard {
  final String id;
  final String name;
  final int nature;
  final int economy;
  final int society;
  final int health;

  Hazard({
    required this.id,
    required this.name,
    required this.nature,
    required this.economy,
    required this.society,
    required this.health,
  });

  factory Hazard.fromJson(Map<String, dynamic> json) {
    return Hazard(
      id: json['id'],
      name: json['name'],
      nature: json['nature'],
      economy: json['economy'],
      society: json['society'],
      health: json['health'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nature': nature,
      'economy': economy,
      'society': society,
      'health': health,
    };
  }

  @override
  String toString() {
    return 'Hazard{id: $id, name: $name, nature: $nature, economy: $economy, society: $society, health: $health}';
  }

  static List<Hazard> getDefaultHazards(List<dynamic> hazards) {
    return hazards.map((hazard) {
      return Hazard.fromJson(hazard);
    }).toList();
  }
}
