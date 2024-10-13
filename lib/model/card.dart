import 'package:heat_is_on_flutter/constants/config.dart' as config;

class GameCard {
  final String id;
  final String type;
  final int cost;
  final int round;
  final int nature;
  final int economy;
  final int society;
  final int health;

  GameCard({
    required this.id,
    required this.type,
    required this.round,
    required this.cost,
    required this.nature,
    required this.economy,
    required this.society,
    required this.health,
  });

  @override
  String toString() {
    return 'GameCard{id: $id, type: $type, round: $round, cost: $cost, nature: $nature, economy: $economy, society: $society, health: $health}';
  }

  // create 15 cards from config
  static List<GameCard> getDefaultCards(List<dynamic> cards) {
    return cards.map((card) {
      return GameCard.fromJson(card);
    }).toList();
  }

  //add fromJson and toJson methods
  factory GameCard.fromJson(Map<String, dynamic> json) {
    return GameCard(
      id: json['id'],
      type: json['type'],
      round: json['round'],
      cost: json['cost'],
      nature: json['nature'],
      economy: json['economy'],
      society: json['society'],
      health: json['health'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'cost': cost,
      'round': round,
      'nature': nature,
      'economy': economy,
      'society': society,
      'health': health,
    };
  }
}
