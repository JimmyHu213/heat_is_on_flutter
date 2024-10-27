class GameCard {
  final String id;
  final String type;
  final String name;
  final int cost;
  final int round;
  final int nature;
  final int economy;
  final int society;
  final int health;

  GameCard({
    required this.id,
    required this.type,
    required this.name,
    required this.round,
    required this.cost,
    required this.nature,
    required this.economy,
    required this.society,
    required this.health,
  });

  @override
  String toString() {
    return 'GameCard{id: $id, type: $type, name: $name,  round: $round, cost: $cost, nature: $nature, economy: $economy, society: $society, health: $health}';
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
      name: json['name'],
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
      'name': name,
      'cost': cost,
      'round': round,
      'nature': nature,
      'economy': economy,
      'society': society,
      'health': health,
    };
  }
}
